@echo off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 1 /f
netsh advfirewall firewall delete rule name="Khorvie Block RDP TCP"
sc config RemoteRegistry start= auto
sc start RemoteRegistry
