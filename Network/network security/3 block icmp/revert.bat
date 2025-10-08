@echo off
netsh advfirewall firewall delete rule name="Khorvie Block ICMPv4 Echo Requests" protocol=icmpv4:8 dir=in

netsh advfirewall firewall delete rule name="Khorvie Block ICMPv6 Echo Requests" protocol=icmpv6:128 dir=in
