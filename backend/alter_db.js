const db = require('./db');

async function fixDB() {
    try {
        console.log("Altering inventory_log table...");
        await db.query('ALTER TABLE inventory_log MODIFY Log_ID INT NOT NULL AUTO_INCREMENT');
        console.log("inventory_log altered successfully.");

        console.log("Altering transaction table...");
        await db.query('SET FOREIGN_KEY_CHECKS = 0');
        await db.query('ALTER TABLE transaction MODIFY Transaction_ID INT NOT NULL AUTO_INCREMENT');
        await db.query('SET FOREIGN_KEY_CHECKS = 1');
        console.log("transaction altered successfully.");

        process.exit(0);
    } catch (err) {
        console.error("Error altering tables:", err.message);
        process.exit(1);
    }
}

fixDB();
