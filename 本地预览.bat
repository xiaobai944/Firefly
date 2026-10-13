@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo.
echo 正在启动本地预览（不会影响线上）...
echo 大约 10 秒后浏览器会自动打开 http://localhost:4321
echo 想停止预览：关掉这个黑窗口即可。
echo.
start "" cmd /c "timeout /t 10 >nul && start http://localhost:4321"
call pnpm dev
pause
