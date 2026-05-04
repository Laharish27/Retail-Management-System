const API_URL = 'http://localhost:5000/api';

/* ── Safe fetch helper ──────────────────────────────────────────
   Always returns a parsed object.
   If the server is down → { error: 'Cannot connect to server...' }
   If the server returns non-JSON (e.g. an HTML 404 page) → { error: '...' }
   ─────────────────────────────────────────────────────────────── */
async function safeFetch(url, options = {}) {
    let res;
    try {
        res = await fetch(url, options);
    } catch (networkErr) {
        return { error: 'Cannot connect to server. Please make sure the backend is running on port 5000.' };
    }

    const text = await res.text();
    try {
        return JSON.parse(text);
    } catch {
        return { error: `Unexpected server response (HTTP ${res.status}). Try restarting the backend.` };
    }
}

const api = {
    async login(username, password) {
        return safeFetch(`${API_URL}/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ username, password })
        });
    },

    async getDashboardStats() {
        return safeFetch(`${API_URL}/dashboard`);
    },

    async getProducts() {
        return safeFetch(`${API_URL}/products`);
    },

    async addProduct(data) {
        return safeFetch(`${API_URL}/products`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        });
    },

    async updateProduct(id, data) {
        return safeFetch(`${API_URL}/products/${id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        });
    },

    async deleteProduct(id) {
        return safeFetch(`${API_URL}/products/${id}`, { method: 'DELETE' });
    },

    async getEmployees() {
        return safeFetch(`${API_URL}/employees`);
    },

    async getInventoryLogs() {
        return safeFetch(`${API_URL}/inventory-log`);
    },

    async processPayment(employeeId, items, totalAmount) {
        return safeFetch(`${API_URL}/payment`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ employeeId, items, totalAmount })
        });
    },

    async getAccounts() {
        return safeFetch(`${API_URL}/accounts`);
    },

    async createAccount(data) {
        return safeFetch(`${API_URL}/accounts`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        });
    },

    async deleteAccount(id) {
        return safeFetch(`${API_URL}/accounts/${id}`, { method: 'DELETE' });
    }
};
