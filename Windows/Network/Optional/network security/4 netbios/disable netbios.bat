@echo off
netsh advfirewall firewall add rule name="Block NetBIOS UDP" protocol=UDP localport=137,138 dir=in action=block
netsh advfirewall firewall add rule name="Block NetBIOS TCP" protocol=TCP localport=139 dir=in action=block
