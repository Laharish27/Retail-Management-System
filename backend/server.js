require('dotenv').config();

const express = require('express');
const cors = require('cors');
const db = require('./db');

const app = express();

app.use(cors());
app.use(express.json());

/* ================= ROOT ================= */
app.get('/', (req, res) => {
    res.send("🚀 Server is running properly");
});

/* ================= LOGIN ================= */
/* ⚠️ Change table if needed (users OR employee) */
app.post('/api/login', async (req, res) => {
    const { username, password } = req.body;

    try {
        const [rows] = await db.query(
            'SELECT * FROM users WHERE username = ? AND password = ?',
            [username, password]
        );

        if (rows.length > 0) {
            res.json({ success: true, user: rows[0] });
        } else {
            res.status(401).json({ success: false, message: 'Invalid credentials' });
        }
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

/* ================= DASHBOARD ================= */
app.get('/api/dashboard', async (req, res) => {
    try {
        const [productCount] = await db.query('SELECT COUNT(*) as count FROM product');
        const [lowStock] = await db.query('SELECT COUNT(*) as count FROM product WHERE Stock_Quantity < 10');
        const [employeeCount] = await db.query('SELECT COUNT(*) as count FROM employee');
        const [revenue] = await db.query('SELECT IFNULL(SUM(Total_Amount),0) as total FROM transaction');

        res.json({
            products: productCount[0].count,
            lowStock: lowStock[0].count,
            employees: employeeCount[0].count,
            revenue: revenue[0].total
        });

    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

/* ================= PRODUCTS ================= */
app.get('/api/products', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM product');
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.post('/api/products', async (req, res) => {
    const { id, name, price, stock } = req.body;

    try {
        await db.query(
            'INSERT INTO product (Product_ID, Name, Price, Stock_Quantity) VALUES (?, ?, ?, ?)',
            [id, name, price, stock]
        );

        res.json({ success: true });

    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.put('/api/products/:id', async (req, res) => {
    const { id } = req.params;
    const { name, price, stock } = req.body;

    try {
        await db.query(
            'UPDATE product SET Name=?, Price=?, Stock_Quantity=? WHERE Product_ID=?',
            [name, price, stock, id]
        );

        res.json({ success: true });

    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.delete('/api/products/:id', async (req, res) => {
    const { id } = req.params;

    try {
        await db.query('DELETE FROM product WHERE Product_ID=?', [id]);
        res.json({ success: true });

    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

/* ================= EMPLOYEES ================= */
app.get('/api/employees', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM employee');
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

/* ================= INVENTORY LOG ================= */
app.get('/api/inventory-log', async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT il.Log_ID, p.Name AS Product_Name, e.Name AS Employee_Name,
                   il.Quantity_Adjusted, il.Change_Type
            FROM inventory_log il
            LEFT JOIN product p ON il.Product_ID = p.Product_ID
            LEFT JOIN employee e ON il.Employee_ID = e.Employee_ID
            ORDER BY il.Log_ID DESC
        `);

        res.json(rows);

    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

/* ================= PAYMENT ================= */
app.post('/api/payment', async (req, res) => {
    const { employeeId, items, totalAmount } = req.body;

    const conn = await db.getConnection();

    try {
        await conn.beginTransaction();

        const date = new Date().toISOString().split('T')[0];
        const time = new Date().toTimeString().split(' ')[0];

        /* ✅ Insert transaction (AUTO_INCREMENT) */
        const [result] = await conn.query(
            'INSERT INTO transaction (Date, Time, Total_Amount, Employee_ID) VALUES (?, ?, ?, ?)',
            [date, time, totalAmount, employeeId]
        );

        const transId = result.insertId;

        for (let item of items) {

            /* ✅ Insert transaction items */
            await conn.query(
                'INSERT INTO transaction_item (Transaction_ID, Product_ID, Quantity, Unit_Price) VALUES (?, ?, ?, ?)',
                [transId, item.productId, item.quantity, item.price]
            );

            /* ✅ Update stock */
            await conn.query(
                'UPDATE product SET Stock_Quantity = Stock_Quantity - ? WHERE Product_ID = ?',
                [item.quantity, item.productId]
            );

            /* ✅ Insert inventory log (NO Log_ID) */
            await conn.query(
                'INSERT INTO inventory_log (Product_ID, Employee_ID, Quantity_Adjusted, Change_Type) VALUES (?, ?, ?, ?)',
                [item.productId, employeeId, -item.quantity, 'Sold']
            );
        }

        await conn.commit();

        res.json({
            success: true,
            message: "✅ Payment successful",
            transactionId: transId
        });

    } catch (err) {
        await conn.rollback();
        res.status(500).json({ error: err.message });
    } finally {
        conn.release();
    }
});

/* ================= ACCOUNTS / USER MANAGER ================= */

/* GET all accounts — returns users list with matched employee info via Employee_ID */
app.get('/api/accounts', async (req, res) => {
    try {
        /* Check if employee_id column exists on users table yet */
        const [rows] = await db.query(`
            SELECT u.id, u.username, u.role,
                   e.Employee_ID, e.Name, e.Phone_No
            FROM users u
            LEFT JOIN employee e ON u.employee_id = e.Employee_ID
            ORDER BY u.id DESC
        `);
        res.json(rows);
    } catch (err) {
        /* Fallback: if employee_id column doesn't exist yet, return users only */
        try {
            const [rows] = await db.query('SELECT id, username, role FROM users ORDER BY id DESC');
            res.json(rows);
        } catch (err2) {
            res.status(500).json({ error: err2.message });
        }
    }
});

/* POST create a new account (user login + employee record) */
app.post('/api/accounts', async (req, res) => {
    const { username, password, role, name, phone, employeeId } = req.body;

    if (!username || !password || !role || !name || !employeeId) {
        return res.status(400).json({ error: 'All fields are required.' });
    }

    const conn = await db.getConnection();
    try {
        await conn.beginTransaction();

        /* Insert login credentials into users table */
        await conn.query(
            'INSERT INTO users (username, password, role) VALUES (?, ?, ?)',
            [username, password, role]
        );

        /* Insert employee record */
        await conn.query(
            'INSERT INTO employee (Employee_ID, Name, Role, Phone_No) VALUES (?, ?, ?, ?)',
            [employeeId, name, role, phone || null]
        );

        await conn.commit();
        res.json({ success: true, message: '✅ Account created successfully' });
    } catch (err) {
        await conn.rollback();
        if (err.code === 'ER_DUP_ENTRY') {
            res.status(409).json({ error: 'Employee ID or phone number already exists.' });
        } else {
            res.status(500).json({ error: err.message });
        }
    } finally {
        conn.release();
    }
});

/* DELETE an account by user id */
app.delete('/api/accounts/:id', async (req, res) => {
    const { id } = req.params;
    try {
        await db.query('DELETE FROM users WHERE id = ?', [id]);
        res.json({ success: true });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

/* ================= SERVER ================= */
const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
    console.log(`🚀 Server running on port ${PORT}`);
});