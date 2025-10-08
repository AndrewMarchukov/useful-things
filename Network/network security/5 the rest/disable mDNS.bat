@echo off
netsh advfirewall firewall add rule name="Khorvie Block mDNS UDP" protocol=UDP localport=5353 dir=in action=block
netsh advfirewall firewall add rule name="Khorvie Block mDNS UDP" protocol=UDP localport=5353 dir=out action=block
