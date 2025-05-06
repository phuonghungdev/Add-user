@echo off
setlocal

:: Thông tin tài khoản
set "USERNAME=Test"
set "PASSWORD=Admin@123"

:: Tạo user
net user %USERNAME% %PASSWORD% /add

:: Đảm bảo user không nằm trong nhóm Administrators
net localgroup Administrators %USERNAME% /delete

:: Thêm vào nhóm Users (mặc định, không có quyền admin)
net localgroup Users %USERNAME% /add

:: Không cho phép đổi mật khẩu
wmic useraccount where name="%USERNAME%" set PasswordChangeable=FALSE

:: Mật khẩu không hết hạn
wmic useraccount where name="%USERNAME%" set PasswordExpires=FALSE

echo.
echo User %USERNAME% đã được tạo với quyền hạn giới hạn.
echo Người dùng sẽ bị yêu cầu nhập mật khẩu admin khi cài đặt phần mềm.
pause
