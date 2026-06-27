@Echo Off
Title NVMe Tweak
cd %systemroot%\system32
call :IsAdmin

rem NumberOfRequests: real StorPort value, valid range 16-255 (255 = max queue)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "NumberOfRequests" /t REG_DWORD /d "255" /f
Exit

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ...
 Pause & Exit
)
Cls
goto:eof
