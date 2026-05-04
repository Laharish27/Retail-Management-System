const fs = require('fs');
const path = require('path');

const filesToUpdate = ['cart.html', 'payment.html', 'dashboard.html', 'products.html'];

filesToUpdate.forEach(file => {
    const filePath = path.join(__dirname, file);
    if (fs.existsSync(filePath)) {
        let content = fs.readFileSync(filePath, 'utf8');
        
        // 1. Replace currency symbol
        content = content.replace(/\$/g, '₹');
        
        // 2. Add Cart extra features to cart.html
        if (file === 'cart.html') {
            // Add Clear Cart button and Total Items count
            const oldSummary = `<div class="cart-summary">
                    <div class="summary-row">
                        <span>Total:</span>
                        <span id="cart-total">₹0.00</span>
                    </div>
                    <button class="btn" style="margin-top: 15px;" onclick="proceedToPayment()" id="checkout-btn" disabled><i class="fa-solid fa-credit-card"></i> Proceed to Payment</button>
                </div>`;
                
            const newSummary = `<div class="cart-summary">
                    <div class="summary-row" style="font-size: 14px; color: var(--text-muted); margin-bottom: 5px;">
                        <span>Total Items:</span>
                        <span id="cart-item-count">0</span>
                    </div>
                    <div class="summary-row">
                        <span>Total Price:</span>
                        <span id="cart-total">₹0.00</span>
                    </div>
                    <div style="display: flex; gap: 10px; margin-top: 15px;">
                        <button class="btn btn-outline" style="flex: 1;" onclick="clearCart()">Clear</button>
                        <button class="btn" style="flex: 2;" onclick="proceedToPayment()" id="checkout-btn" disabled><i class="fa-solid fa-credit-card"></i> Checkout</button>
                    </div>
                </div>`;
                
            content = content.replace(oldSummary, newSummary);

            // Update JS to handle Total Items and clearCart
            if (!content.includes('function clearCart()')) {
                const clearCartFunc = `
        function clearCart() {
            cart = [];
            renderCart();
        }

        function renderCart() {`;
                content = content.replace('function renderCart() {', clearCartFunc);
            }
            
            // Add updating of cart-item-count
            if (!content.includes("document.getElementById('cart-item-count')")) {
                content = content.replace("document.getElementById('cart-total').innerText = '₹0.00';", "document.getElementById('cart-total').innerText = '₹0.00';\n                document.getElementById('cart-item-count').innerText = '0';");
                
                content = content.replace("let total = 0;", "let total = 0;\n            let totalItemsCount = 0;");
                content = content.replace("total += itemTotal;", "total += itemTotal;\n                totalItemsCount += item.quantity;");
                content = content.replace("document.getElementById('cart-total').innerText = '₹' + total.toFixed(2);", "document.getElementById('cart-total').innerText = '₹' + total.toFixed(2);\n            document.getElementById('cart-item-count').innerText = totalItemsCount;");
            }
        }
        
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`Updated ${file}`);
    }
});
