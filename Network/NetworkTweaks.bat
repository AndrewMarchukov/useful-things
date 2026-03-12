rem # Packet Scheduler Timer Resolution
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "TimerResolution" /t REG_DWORD /d "1" /f

rem # Windows Defender disable inspection of UDP connections.
Set-MpPreference -DisableDatagramProcessing 1
rem # Windows Defender disable the gathering and sending of performance telemetry from network protection.
Set-MpPreference -DisableNetworkProtectionPerfTelemetry 1

rem # Add TCP settings for BBR2 and ECN
netsh int tcp set supplemental Template=Internet CongestionProvider=bbr2
netsh int tcp set supplemental Template=Datacenter CongestionProvider=bbr2
netsh int tcp set supplemental Template=Compat CongestionProvider=bbr2
netsh int tcp set supplemental Template=DatacenterCustom CongestionProvider=bbr2
netsh int tcp set supplemental Template=InternetCustom CongestionProvider=bbr2
netsh int ipv6 set gl loopbacklargemtu=disable
netsh int ipv4 set gl loopbacklargemtu=disable

rem # Add TCP settings for DCTCP and ECN if BBR2 not working
::netsh int tcp set supplemental template=Internet congestionprovider=DCTCP
::netsh int tcp set global ECN=Enabled
