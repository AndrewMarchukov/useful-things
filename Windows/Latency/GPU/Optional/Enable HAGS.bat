@Echo Off
Title HAGS - Hardware-accelerated GPU Scheduling
cd %systemroot%\system32
call :IsAdmin

rem HwSchMode: 2 = on, 1 = off. Needs WDDM 2.7+ GPU/driver (RTX 20+, RX 5000+, Arc).
rem Hard requirement for DLSS Frame Generation. Measured effect otherwise:
rem ~1-3 ms lower input latency, +/- 0..3%% FPS depending on game.
rem Reboot required after change.
rem Usage: apply (no args) ^| revert ^| status

If /i "%~1"=="revert" (
 Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d "1" /f
 Echo HAGS off. Reboot to apply.
 goto :Status
)
If /i "%~1"=="status" goto :Status

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d "2" /f
Echo HAGS on. Reboot to apply.

:Status
Echo.
Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode"
Pause & Exit

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment" >nul 2>&1
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ...
 Pause & Exit
)
Cls
goto:eof
