@echo off
echo Adding values to the Registry...
:: DPC watchdog stays ENABLED. Zeroing DpcWatchdogPeriod/DpcTimeout has no latency
:: upside (the watchdog only monitors) - it just turns diagnosable
:: DPC_WATCHDOG_VIOLATION bugchecks into silent hard freezes with no culprit named.
:: The deletes restore kernel defaults on systems where the old script already ran.
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DpcWatchdogProfileOffset /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DpcTimeout /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DpcWatchdogPeriod /f >nul 2>&1
:: NT-era DPC queue tuning (unverified whether the modern kernel reads these, harmless):
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v IdealDpcRate /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v MaximumDpcQueueDepth /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v MinimumDpcRate /t REG_DWORD /d 1 /f
echo Completed adding values to the Registry.
pause
