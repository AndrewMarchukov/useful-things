@echo off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f
netsh advfirewall firewall add rule name="Block RDP TCP" protocol=TCP localport=3389 dir=in action=block
sc stop RemoteRegistry
sc config RemoteRegistry start= disabled
