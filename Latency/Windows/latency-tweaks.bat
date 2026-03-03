:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: This script must be run as Administrator.
    pause
    exit /b
)

echo - ThreadDPC setting, i think not worth it, you can enable it if you want but it can cause stuttering in some games, especially if you have a lot of background processes running. It can help reduce latency in some cases, but it can also cause performance issues if not used correctly. It's best to test it with your specific setup and see if it improves or worsens your gaming experience.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "ThreadDpcEnable" /t REG_DWORD /d "1" /f

echo - Disabling Fault Tolerant Heap
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\FTH" /v Enabled /t REG_DWORD /d 0 /f

echo - Disabling IoLatencyCap
FOR /F "eol=E" %%a in ('REG QUERY "HKLM\SYSTEM\CurrentControlSet\Services" /S /F "IoLatencyCap"^| FINDSTR /V "IoLatencyCap"') DO (
	REG ADD "%%a" /F /V "IoLatencyCap" /T REG_DWORD /d 0

	FOR /F "tokens=*" %%z IN ("%%a") DO (
		SET STR=%%z
		SET STR=!STR:HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\=!
		SET STR=!STR:\Parameters=!
	)
)

echo - Disabling StorPort Idle
for /f "tokens=*" %%s in ('reg query "HKLM\System\CurrentControlSet\Enum" /S /F "StorPort" ^| findstr /e "StorPort"') do reg add "%%s" /v "EnableIdlePowerManagement" /t REG_DWORD /d "0" /f



echo Disabling DMA memory protection and cores isolation...

:: BCD Edit modifications
bcdedit /deletevalue hypervisorlaunchtype >nul 2>&1
bcdedit /deletevalue vsmlaunchtype >nul 2>&1
bcdedit /deletevalue vm >nul 2>&1
bcdedit /set loadoptions DISABLE-LSA-ISO,DISABLE-VBS >nul 2>&1

:: BitLocker/FVE Policies
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v "DisableExternalDMAUnderLock" /t REG_DWORD /d 0 /f >nul 2>&1

:: DeviceGuard Policies
set "DG_POLICY=HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard"
reg add "%DG_POLICY%" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%DG_POLICY%" /v "HVCIMATRequired" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%DG_POLICY%" /v "RequirePlatformSecurityFeatures" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%DG_POLICY%" /v "LsaCfgFlags" /t REG_DWORD /d 0 /f >nul 2>&1

:: LSA Control
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "LsaCfgFlags" /t REG_DWORD /d 0 /f >nul 2>&1

:: System DeviceGuard Control
set "DG_CONTROL=HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard"
reg add "%DG_CONTROL%" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%DG_CONTROL%" /v "HVCIMATRequired" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%DG_CONTROL%" /v "RequirePlatformSecurityFeatures" /t REG_DWORD /d 0 /f >nul 2>&1

echo DMA and Core Isolation commands completed.

echo Uninstalling Hyper-V...

:: Query the registry to determine if the OS is "Server" or "Client"
reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion" /v InstallationType | findstr /i "Server" >nul

if %errorlevel% equ 0 (
    :: OS is Windows Server
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Uninstall-WindowsFeature -Name 'Hyper-V' -IncludeManagementTools -WarningAction SilentlyContinue | Out-Null"
) else (
    :: OS is Windows Client (e.g., Windows 10/11)
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Hyper-V-All' -NoRestart -WarningAction SilentlyContinue | Out-Null"
)

echo Hyper-V uninstallation command completed.

echo - Disabling Sleep Study
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "SleepstudyAccountingEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDeviceAccountingLevel" /t REG_DWORD /d "0" /f

::echo - Disabling Energy Logging
::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "DisableTaggedEnergyLogging" /t REG_DWORD /d "1" /f
::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxApplication" /t REG_DWORD /d "0" /f
::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxTagPerApplication" /t REG_DWORD /d "0" /f

echo - Setting Win32 Priority Seperation Value
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 0x00000024 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f

timeout 10