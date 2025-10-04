ECHO Disabling USB Hub idle...
DISM /Online /Add-Capability /CapabilityName:WMIC~~~~
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

timeout 10