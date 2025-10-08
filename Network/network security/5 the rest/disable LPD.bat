@echo off
netsh advfirewall firewall add rule name="Khorvie Block LPD TCP" protocol=TCP localport=515 dir=in action=block
