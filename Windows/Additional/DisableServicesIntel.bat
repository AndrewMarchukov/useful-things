rem # Disable Intel bloat services  (Start=4 = Disabled)

rem -- HDCP/content protection: may affect protected 4K playback
reg add "HKLM\SYSTEM\CurrentControlSet\Services\cplspcon" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\cphs" /v "Start" /t REG_DWORD /d "4" /f
rem -- Intel graphics control-panel UI only (not the GPU driver): safe
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igccservice" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfxCUIService2.0.0.0" /v "Start" /t REG_DWORD /d "4" /f
rem -- LMS = Intel ME/AMT mgmt: safe unless you use vPro/AMT remote management
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LMS" /v "Start" /t REG_DWORD /d "4" /f
rem -- RST middleware = RAID alerts only, NOT the storage driver: won't break boot
reg add "HKLM\SYSTEM\CurrentControlSet\Services\RstMwService" /v "Start" /t REG_DWORD /d "4" /f
rem -- TPM provisioning: safe once provisioned; don't disable mid BitLocker/Win11 setup
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Intel(R) TPM Provisioning Service" /v "Start" /t REG_DWORD /d "4" /f
rem -- jhi = DAL host interface (ME): mostly safe; some DRM/Hello use it
reg add "HKLM\SYSTEM\CurrentControlSet\Services\jhi_service" /v "Start" /t REG_DWORD /d "4" /f
rem -- Intel System Usage Report telemetry: safe
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SystemUsageReportSvc_QUEENCREEK" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Intel(R) SUR QC SAM" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ESRV_SVC_QUEENCREEK" /v "Start" /t REG_DWORD /d "4" /f
sc config ESRV_SVC_QUEENCREEK start= disabled
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USER_ESRV_SVC_QUEENCREEK" /v "Start" /t REG_DWORD /d "4" /f

rem # esifsvc = Intel DPTF (thermal/power management)
rem # CAUTION laptops: disabling can cause overheating / worse battery. Desktops usually fine.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\esifsvc" /v "Start" /t REG_DWORD /d "4" /f

PAUSE
