@echo off
rem wmic is removed in Win11 24H2/25H2 - enumerate the GPU via CIM instead
for /f %%i in ('powershell -NoProfile -Command "(Get-CimInstance Win32_VideoController).PNPDeviceID" ^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\System\ControlSet001\Control\Class\%%i" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f >nul 2>&1
                   )
                )
             )
