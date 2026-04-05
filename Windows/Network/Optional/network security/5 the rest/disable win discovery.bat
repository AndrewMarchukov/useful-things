@echo off
sc stop fdPHost
sc config fdPHost start= disabled
sc stop FDResPub
sc config FDResPub start= disabled
