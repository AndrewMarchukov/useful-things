@Echo Off
Title Per-game High priority (IFEO PerfOptions)
cd %systemroot%\system32
call :IsAdmin

rem Same mechanism this repo already uses for csrss/dwm/audiodg, applied per game.
rem CpuPriorityClass: 3 = High. Never Realtime - it starves input and audio threads.
rem Applies on every launch of the exe, no Task Manager or Process Lasso needed.
rem Usage: "Set Game Priority.bat" game.exe          - start with High priority
rem        "Set Game Priority.bat" game.exe revert   - remove
rem        "Set Game Priority.bat" list              - show all exes with it set

set "IFEO=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options"

If /i "%~1"=="list" (
 Reg.exe query "%IFEO%" /s /f "CpuPriorityClass"
 Pause & Exit
)
If "%~1"=="" (
 Echo Usage: "%~nx0" game.exe [revert]  or  "%~nx0" list
 Pause & Exit
)
If /i not "%~x1"==".exe" (
 Echo Argument must be an .exe name, e.g. cs2.exe
 Pause & Exit
)

If /i "%~2"=="revert" (
 Reg.exe delete "%IFEO%\%~nx1\PerfOptions" /v "CpuPriorityClass" /f
 Echo Removed High priority for %~nx1
 Pause & Exit
)

Reg.exe add "%IFEO%\%~nx1\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "3" /f
Echo %~nx1 will now start with High priority.
Pause & Exit

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment" >nul 2>&1
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ...
 Pause & Exit
)
Cls
goto:eof
