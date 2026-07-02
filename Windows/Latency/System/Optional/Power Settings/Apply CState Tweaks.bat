@Echo Off
Title CState Idle Threshold Tweak
cd %systemroot%\system32
call :IsAdmin

rem Pins cores to C1 by making deep C-state promotion impossible:
rem   IdlePromoteThreshold=100 -> idleness can never exceed 100%%, never promotes deeper
rem   IdleDemoteThreshold=100  -> idleness almost always below 100%%, demotes to lightest
rem Real effect: removes deep C-state wake latency (microseconds, visible in LatencyMon).
rem Real cost: higher idle power/heat, less boost headroom (Precision Boost / Turbo).
rem   Verify single-core boost clocks with HWiNFO after applying - revert if they drop.
rem Docs: learn.microsoft.com power-settings IdleDemoteThreshold / IdlePromoteThreshold
rem Usage: apply (no args) ^| revert ^| status
rem AC only on purpose - desktop box. No third-party tools needed, powercfg does it all.

set "SUB=54533251-82be-4824-96c1-47b60b740d00"
set "DEMOTE=4b92d758-5a24-4851-a470-815d78aee119"
set "PROMOTE=7b224883-b3cc-4d79-819f-8374152cbe7c"

If /i "%~1"=="revert" goto :Revert
If /i "%~1"=="status" goto :Status

rem unhide so both settings show up in the power plan GUI
powercfg -attributes %SUB% %DEMOTE% -ATTRIB_HIDE
powercfg -attributes %SUB% %PROMOTE% -ATTRIB_HIDE
powercfg /setacvalueindex scheme_current %SUB% %DEMOTE% 100
powercfg /setacvalueindex scheme_current %SUB% %PROMOTE% 100
powercfg /setactive scheme_current
Echo Applied: idle demote/promote thresholds = 100 (cores stay in C1).
Echo Verify: LatencyMon for DPC latency, HWiNFO for boost clocks.
Echo Revert: "%~nx0" revert
goto :Status

:Revert
rem deleting the per-scheme override restores the Windows default (no hardcoded guesses)
for /f "tokens=4" %%g in ('powercfg /getactivescheme') do set "SCHEME=%%g"
If Not Defined SCHEME (Echo Could not detect active power scheme. & Pause & Exit)
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\%SCHEME%\%SUB%\%DEMOTE%" /f >nul 2>&1
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\%SCHEME%\%SUB%\%PROMOTE%" /f >nul 2>&1
powercfg /setactive scheme_current
Echo Reverted to Windows defaults.
goto :Status

:Status
Echo.
powercfg /q scheme_current %SUB% %DEMOTE%
powercfg /q scheme_current %SUB% %PROMOTE%
Pause & Exit

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment" >nul 2>&1
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ...
 Pause & Exit
)
Cls
goto:eof
