bcdedit /set disabledynamictick yes
copy "%~dp0\SetTimerResolution.exe" C:\SetTimerResolution.exe
schtasks /create /tn "ResolutionTimerTweak" /tr "cmd /c timeout /t 10 & C:\SetTimerResolution.exe --resolution 5000 --no-console" /sc onstart /rl highest /f /ru "SYSTEM"