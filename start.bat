echo off
TITLE Inventory Management System
COLOR 0B

echo ======================================================
echo       INVENTORY MANAGEMENT SYSTEM STARTUP
echo ======================================================
echo.

:: Kill any existing process on port 5000
echo [0/2] Checking for existing server on port 5000...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :5000 ^| findstr LISTENING') do (
    echo [!] Found existing process (PID %%a). Killing it...
    taskkill /F /PID %%a >nul 2>&1
)
timeout /t 1 /nobreak >nul

:: Check if backend node_modules exist
if not exist "backend\node_modules\" (
    echo [!] backend/node_modules not found.
    echo [!] Attempting to install dependencies...
    cd backend
    npm install
    cd ..
)

:: Start the Backend Server in a new window
echo [1/2] Starting Backend Server (Port 5000)...
start "IMS-Backend" cmd /k "cd /d "%~dp0backend" && node server.js"

:: Give the server a few seconds to initialize
echo [.] Waiting for server to initialize...
timeout /t 3 /nobreak >nul

:: Open the Frontend in the default browser
echo [2/2] Launching Frontend Interface...
start "" "%~dp0frontend\index.html"

echo.
echo ======================================================
echo   SUCCESS: System is now running!
echo   - Backend: http://localhost:5000
echo   - Frontend: Opened in your default browser
echo.
echo   NOTE: Keep the Backend terminal window open.
echo ======================================================
echo.
pause
