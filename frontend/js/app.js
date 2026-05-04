// Auth Guard
function checkAuth() {
    const user = JSON.parse(localStorage.getItem('user'));
    const path = window.location.pathname;
    const isLoginPage = path.endsWith('index.html') || path === '/';
    
    if (!user && !isLoginPage) {
        window.location.href = 'index.html';
        return;
    }
    
    if (user) {
        if (isLoginPage) {
            window.location.href = user.role === 'Cashier' ? 'cart.html' : 'dashboard.html';
            return;
        }

        // Role-based restrictions
        if (user.role === 'Cashier') {
            const allowedPages = ['cart.html', 'payment.html'];
            const currentPage = path.split('/').pop() || 'index.html';
            if (!allowedPages.includes(currentPage)) {
                window.location.href = 'cart.html';
            }
        }
    }
}

// Logout
function logout() {
    localStorage.removeItem('user');
    window.location.href = 'index.html';
}

// Render Sidebar
function renderSidebar() {
    const user = JSON.parse(localStorage.getItem('user'));
    let navItems = '';
    
    if (user && user.role === 'Cashier') {
        navItems = `
            <li class="nav-item"><a href="cart.html" id="nav-cart"><i class="fa-solid fa-cart-shopping"></i> Cart / POS</a></li>
        `;
    } else {
        navItems = `
            <li class="nav-item"><a href="dashboard.html" id="nav-dashboard"><i class="fa-solid fa-chart-pie"></i> Dashboard</a></li>
            <li class="nav-item"><a href="products.html" id="nav-products"><i class="fa-solid fa-box"></i> Products</a></li>
            <li class="nav-item"><a href="cart.html" id="nav-cart"><i class="fa-solid fa-cart-shopping"></i> Cart / POS</a></li>
            <li class="nav-item"><a href="employees.html" id="nav-employees"><i class="fa-solid fa-users"></i> Employees</a></li>
            <li class="nav-item"><a href="logs.html" id="nav-logs"><i class="fa-solid fa-clipboard-list"></i> Inventory Logs</a></li>
            <li class="nav-item"><a href="accounts.html" id="nav-accounts"><i class="fa-solid fa-user-gear"></i> Account Management</a></li>
        `;
    }

    const sidebarHTML = `
        <div class="sidebar">
            <div class="sidebar-logo"><i class="fa-solid fa-layer-group"></i> InventoryPro</div>
            <ul class="nav-links">
                ${navItems}
            </ul>
            <div class="user-info">
                <p id="user-display-name" style="font-weight: 500; color: var(--text-primary); font-size: 14px;">User Name</p>
                <p id="user-display-role" style="color: var(--accent); font-weight: 500; font-size: 12px; margin-top: 2px;">Role</p>
                <button class="btn btn-outline btn-small" onclick="logout()" style="margin-top: 12px; width: 100%;"><i class="fa-solid fa-right-from-bracket"></i> Logout</button>
            </div>
        </div>
    `;
    
    const body = document.querySelector('body');
    if (!body.querySelector('.sidebar')) {
        body.insertAdjacentHTML('afterbegin', sidebarHTML);
    }
    
    const userLocal = JSON.parse(localStorage.getItem('user'));
    if (userLocal) {
        document.getElementById('user-display-name').innerText = userLocal.username || userLocal.Name || 'User';
        document.getElementById('user-display-role').innerText = userLocal.role || userLocal.Role;
    }
    
    // Highlight active link
    const path = window.location.pathname;
    const page = path.split('/').pop() || 'index.html';
    const navLinks = document.querySelectorAll('.nav-item a');
    navLinks.forEach(link => {
        if (link.getAttribute('href') === page) {
            link.classList.add('active');
        }
    });
}

// Initialize App
document.addEventListener('DOMContentLoaded', () => {
    checkAuth();
    if (!window.location.pathname.endsWith('index.html') && window.location.pathname !== '/') {
        renderSidebar();
    }
});
