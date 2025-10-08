@echo off
netsh advfirewall firewall delete rule name="Khorvie Block mDNS UDP" protocol=UDP localport=5353 dir=in
netsh advfirewall firewall delete rule name="Khorvie Block mDNS UDP" protocol=UDP localport=5353 dir=out
