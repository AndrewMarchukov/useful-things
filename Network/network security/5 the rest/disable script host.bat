@echo off
reg add "HKLM\Software\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 0 /f
