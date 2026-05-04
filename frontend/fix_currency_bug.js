const fs = require('fs');
const filesToUpdate = ['cart.html', 'payment.html', 'dashboard.html', 'products.html', 'logs.html', 'employees.html'];

filesToUpdate.forEach(file => {
    if (fs.existsSync(file)) {
        let content = fs.readFileSync(file, 'utf8');
        
        // Fix double Rupee to Rupee + Dollar (for currency + interpolation)
        content = content.replace(/₹₹\{/g, '₹${');
        
        // Fix single Rupee back to Dollar (for interpolation)
        content = content.replace(/₹\{/g, '${');
        
        fs.writeFileSync(file, content, 'utf8');
        console.log('Fixed ' + file);
    }
});
