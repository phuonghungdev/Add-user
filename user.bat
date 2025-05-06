@echo off
:: Doi ma ky tu sang UTF-8
chcp 65001 >nul

:: Kiem tra quyen administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [LOI] Hay chay file nay bang quyen Administrator.
    echo Click chuot phai > "Run as administrator"
    pause
    exit /b
)

setlocal

:: Thong tin tai khoan
set "USERNAME=Test"
set "PASSWORD=T3st@User2025#"

:: Tao user
net user %USERNAME% %PASSWORD% /add

:: Goi nhom Administrators (neu co)
net localgroup Administrators %USERNAME% /delete 2>nul

:: Them vao nhom Users
net localgroup Users %USERNAME% /add

:: Cho phep Remote Desktop
net localgroup "Remote Desktop Users" %USERNAME% /add

:: Su dung PowerShell de dat tuy chon mat khau (an toan hon WMIC)
powershell -Command "Set-LocalUser -Name '%USERNAME%' -PasswordNeverExpires \$true -UserMayChangePassword \$false"

echo.
echo === USER DA TAO THANH CONG ===
echo User: %USERNAME%
echo Da co quyen dang nhap Remote Desktop.
echo Khi cai app se bi hoi mat khau admin.
echo.
pause
