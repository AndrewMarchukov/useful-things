rem # Packet Scheduler Timer Resolution
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "TimerResolution" /t REG_DWORD /d "1" /f

rem # Windows Defender disable inspection of UDP connections.
Set-MpPreference -DisableDatagramProcessing 1
rem # Windows Defender disable the gathering and sending of performance telemetry from network protection.
Set-MpPreference -DisableNetworkProtectionPerfTelemetry 1
