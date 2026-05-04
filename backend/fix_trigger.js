const db = require('./db');

async function fixTrigger() {
    try {
        console.log("Dropping old log_stock trigger...");
        await db.query("DROP TRIGGER IF EXISTS log_stock");
        
        console.log("Creating new log_stock trigger...");
        await db.query(`
            CREATE TRIGGER log_stock 
            AFTER UPDATE ON product 
            FOR EACH ROW 
            BEGIN
                INSERT INTO inventory_log(Product_ID, Quantity_Adjusted, Change_Type)
                VALUES (NEW.Product_ID, NEW.Stock_Quantity, 'Updated');
            END;
        `);
        console.log("Trigger fixed successfully!");
        process.exit(0);
    } catch(err) {
        console.error("Error fixing trigger:", err.message);
        process.exit(1);
    }
}

fixTrigger();
