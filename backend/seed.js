const db = require('./db');
async function run() {
    try {
        await db.query("INSERT IGNORE INTO users (id, username, password, role) VALUES (1, 'manager', 'admin123', 'Manager'), (2, 'cashier', 'cash123', 'Cashier')");
        console.log('Test users inserted: manager/admin123, cashier/cash123');
        process.exit(0);
    } catch(err) {
        console.error(err);
        process.exit(1);
    }
}
run();
