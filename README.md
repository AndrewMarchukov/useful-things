sources with research:
https://github.com/djdallmann/GamingPCSetup
https://github.com/AlchemyTweaks/Verified-Tweaks/tree/main

another questionable tweaks sources:
https://github.com/Hyyote/files-/tree/main
https://github.com/shoober420/windows11-scripts/tree/main
https://sites.google.com/view/melodystweaks/basictweaks

Tweaks:
https://www.techpowerup.com/forums/threads/revisiting-hpet-bcdedit-tweaks-what-are-your-timer-bench-results-and-settings.326187/page-5
https://www.youtube.com/@Savitarax/videos


Question:
https://answers.microsoft.com/en-us/windows/forum/all/why-does-this-happen-in-24h2/7e8145b4-f56c-452f-8bba-7da58614d6f7

Crap free windows: https://atlasos.net/


TODO:
```

ECHO Enabling AL HRTF...
ECHO hrtf ^= true > "%appdata%\alsoft.ini"
ECHO hrtf ^= true > "C:\ProgramData\alsoft.ini"



ECHO Disabling USB Hub idle...
FOR /F %%a in ('WMIC PATH Win32_USBHub GET DeviceID^| FINDSTR /L "VID_"') DO (
REG ADD "HKLM\System\CurrentControlSet\Enum\%%a\Device Parameters" /v "EnhancedPowerManagementEnabled" /t REG_DWORD /d "0" /f >NUL 2>&1
REG ADD "HKLM\System\CurrentControlSet\Enum\%%a\Device Parameters" /v "AllowIdleIrpInD3" /t REG_DWORD /d "0" /f >NUL 2>&1
REG ADD "HKLM\System\CurrentControlSet\Enum\%%a\Device Parameters" /v "DeviceSelectiveSuspended" /t REG_DWORD /d "0" /f >NUL 2>&1	
REG ADD "HKLM\System\CurrentControlSet\Enum\%%a\Device Parameters" /v "SelectiveSuspendEnabled" /t REG_DWORD /d "0" /f >NUL 2>&1	
REG ADD "HKLM\System\CurrentControlSet\Enum\%%a\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d "0" /f >NUL 2>&1	
REG ADD "HKLM\System\CurrentControlSet\Enum\%%a\Device Parameters" /v "fid_D1Latency" /t REG_DWORD /d "0" /f >NUL 2>&1
REG ADD "HKLM\System\CurrentControlSet\Enum\%%a\Device Parameters" /v "fid_D2Latency" /t REG_DWORD /d "0" /f >NUL 2>&1
REG ADD "HKLM\System\CurrentControlSet\Enum\%%a\Device Parameters" /v "fid_D3Latency" /t REG_DWORD /d "0" /f >NUL 2>&1
REG ADD "HKLM\System\CurrentControlSet\Control\usbflags" /v "fid_D1Latency" /t REG_DWORD /d "0" /f >NUL 2>&1
REG ADD "HKLM\System\CurrentControlSet\Control\usbflags" /v "fid_D2Latency" /t REG_DWORD /d "0" /f >NUL 2>&1
REG ADD "HKLM\System\CurrentControlSet\Control\usbflags" /v "fid_D3Latency" /t REG_DWORD /d "0" /f >NUL 2>&1
)

```