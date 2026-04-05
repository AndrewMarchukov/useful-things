@echo off
netsh advfirewall firewall delete rule name="Block ICMPv4 Echo Requests" protocol=icmpv4:8 dir=in

netsh advfirewall firewall delete rule name="Block ICMPv6 Echo Requests" protocol=icmpv6:128 dir=in
