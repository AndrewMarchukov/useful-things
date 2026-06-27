@echo off
bcdedit /set disabledynamictick yes
rem Install to a protected (admin-only) folder so the SYSTEM-run exe can't be tampered with.
if not exist "%ProgramFiles%\TimerResolution" mkdir "%ProgramFiles%\TimerResolution"
copy /y "%~dp0SetTimerResolution.exe" "%ProgramFiles%\TimerResolution\"
schtasks /create /tn "ResolutionTimerTweak" /tr "cmd /c timeout /t 10 & \"%ProgramFiles%\TimerResolution\SetTimerResolution.exe\" --resolution 5120 --no-console" /sc onstart /rl highest /f /ru "SYSTEM"
