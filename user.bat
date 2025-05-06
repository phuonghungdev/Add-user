@echo off
:: Đổi sang mã UTF-8 để hiển thị tiếng Việt
chcp 65001 >nul

:: Kiểm tra quyền administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [LỖI] Vui lòng chạy file này bằng quyền Administrator.
    echo Click chuột phải > "Run as administrator"
    pause
    exit /b
)

setlocal

:: Thông tin tài khoản
set "USERNAME=Test"
set "PASSWORD=Test@1234!"

:: Tạo user
net user %USERNAME% %PASSWORD% /add

:: Gỡ khỏi nhóm Administrators nếu có (ẩn lỗi nếu không có)
net localgroup Administrators %USERNAME% /delete 2>nul

:: Thêm vào nhóm Users
net localgroup Users %USERNAME% /add

:: Thêm vào nhóm Remote Desktop Users
net localgroup "Remote Desktop Users" %USERNAME% /add

:: Không cho phép đổi mật khẩu
wmic useraccount where name="%USERNAME%" set PasswordChangeable=FALSE

:: Mật khẩu không hết hạn
wmic useraccount where name="%USERNAME%" set PasswordExpires=FALSE

echo.
echo === USER ĐÃ TẠO THÀNH CÔNG ===
echo User: %USERNAME%
echo Có thể đăng nhập Remote Desktop, nhưng không cài đặt app nếu không có mật khẩu admin.
echo.
pause
