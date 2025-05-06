@echo off
chcp 65001 >nul

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [LOI] Hay chay file nay bang quyen Administrator.
    pause
    exit /b
)

setlocal
set "USERNAME=Test"
set "PASSWORD=Admin@123123#"

:: Tao user
net user %USERNAME% %PASSWORD% /add

:: Bo khoi nhom Administrators (neu co)
net localgroup Administrators %USERNAME% /delete 2>nul

:: Them vao nhom Users va Remote Desktop Users
net localgroup Users %USERNAME% /add
net localgroup "Remote Desktop Users" %USERNAME% /add

:: Cai dat quyen khong duoc doi mat khau, khong het han mat khau
powershell -Command "Set-LocalUser -Name '%USERNAME%' -PasswordNeverExpires \$true -UserMayChangePassword \$false"

:: Xoa quyen tat may va restart bang ntrights
ntrights.exe -u %USERNAME% -r SeShutdownPrivilege
ntrights.exe -u %USERNAME% -r SeRemoteShutdownPrivilege

echo.
echo === USER DA TAO THANH CONG ===
echo User: %USERNAME%
echo Co the dang nhap Remote Desktop.
echo User KHONG CO quyen tat hoac khoi dong lai may.
echo.
pause
