@Echo Off
Title Check BypassIO / DirectStorage readiness
cd %systemroot%\system32
call :IsAdmin

rem BypassIO is the DirectStorage fast path (Win11, NVMe + NTFS).
rem If a filter driver or storage tweak breaks it, fsutil names the component
rem that vetoes it, per drive. Pure check - changes nothing.
for %%d in (C D E F G H I J) do If exist %%d:\ (
 Echo === Drive %%d: ===
 fsutil bypassIo state %%d:\
 Echo.
)
Pause & Exit

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment" >nul 2>&1
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ...
 Pause & Exit
)
Cls
goto:eof
