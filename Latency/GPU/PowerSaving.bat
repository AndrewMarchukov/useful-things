:: Turn off gpu power saving
::  
:: REG ADD "HKLM\System\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "1" /f >NUL 2>&1 
REG ADD "HKLM\System\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "VsyncIdleTimeout" /t REG_DWORD /d "0" /f >NUL 2>&1