@echo off
netsh advfirewall firewall delete rule name="Block NetBIOS UDP" protocol=UDP localport=137,138 dir=in
netsh advfirewall firewall delete rule name="Block NetBIOS TCP" protocol=TCP localport=139 dir=in
