const mysql = require('mysql2/promise');
require('dotenv').config();

const pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || 'laharish@22',
    database: process.env.DB_NAME || 'Inventory_System',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Test connection (VERY IMPORTANT)
async function testConnection() {
    try {
        const connection = await pool.getConnection();
        console.log("✅ MySQL Connected Successfully");
        connection.release();
    } catch (err) {
        console.error("❌ MySQL Connection Failed:", err.message);
    }
}

testConnection();

module.exports = pool;