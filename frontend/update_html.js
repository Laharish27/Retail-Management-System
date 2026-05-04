const fs = require('fs'); 
const files = ['index.html', 'dashboard.html', 'products.html', 'employees.html', 'logs.html', 'cart.html', 'payment.html']; 

files.forEach(f => { 
    let c = fs.readFileSync(f, 'utf8'); 
    
    // Add FontAwesome
    if (!c.includes('font-awesome')) { 
        c = c.replace('</head>', '    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">\n</head>'); 
    } 
    
    // Add animations & borders
    c = c.replace(/class="main-content"/g, 'class="main-content fade-in"'); 
    c = c.replace(/class="stat-card glass"/g, 'class="stat-card glass gradient-border"'); 

    // Update buttons with icons in products.html
    if (f === 'products.html') {
        c = c.replace('>Add Product</button>', '><i class="fa-solid fa-plus"></i> Add Product</button>');
        c = c.replace(/>Edit<\/button>/g, '><i class="fa-solid fa-pen-to-square"></i> Edit</button>');
        c = c.replace(/>Delete<\/button>/g, '><i class="fa-solid fa-trash"></i> Delete</button>');
        c = c.replace(/>Save Product<\/button>/g, '><i class="fa-solid fa-floppy-disk"></i> Save Product</button>');
    }

    // Update index.html
    if (f === 'index.html') {
        c = c.replace(/>Sign In<\/button>/g, '><i class="fa-solid fa-right-to-bracket"></i> Sign In</button>');
    }

    // Update cart.html and payment.html
    if (f === 'cart.html') {
        c = c.replace(/>Proceed to Payment<\/button>/g, '><i class="fa-solid fa-credit-card"></i> Proceed to Payment</button>');
    }
    if (f === 'payment.html') {
        c = c.replace(/>Complete Payment<\/button>/g, '><i class="fa-solid fa-check"></i> Complete Payment</button>');
        c = c.replace(/>Back to Cart<\/button>/g, '><i class="fa-solid fa-arrow-left"></i> Back to Cart</button>');
    }

    // Update Status badges logic globally (we will modify the JS part of the files where applicable, or simply let the app.js or existing badge classes take over)
    c = c.replace(/badge-success/g, 'badge-in-stock');
    c = c.replace(/badge-warning/g, 'badge-low-stock');

    fs.writeFileSync(f, c); 
}); 
console.log('HTML files successfully updated with professional UI enhancements.');
