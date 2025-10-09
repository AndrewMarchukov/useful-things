@echo off
netsh advfirewall firewall delete rule name="Block mDNS UDP" protocol=UDP localport=5353 dir=in
netsh advfirewall firewall delete rule name="Block mDNS UDP" protocol=UDP localport=5353 dir=out
