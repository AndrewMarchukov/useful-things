@echo off
rem Disable Windows location fully. Run as Administrator.

rem 1) Deny app access to location (all users)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f >nul 2>&1

rem 2) Turn off the location/sensor platform (policy)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >nul 2>&1

rem 3) Stop + disable the Geolocation service (lfsvc) - stops the OS polling location at all
sc stop lfsvc >nul 2>&1
sc config lfsvc start= disabled >nul 2>&1

echo Location disabled. Reboot to fully apply.
pause
