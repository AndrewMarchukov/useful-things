@Echo Off
Title Per-game DSCP tagging (QoS policy)
cd %systemroot%\system32
call :IsAdmin

rem Tags a game exe's traffic with DSCP 46 (Expedited Forwarding) via a Windows QoS policy.
rem ONLY pays off if your router runs SQM/QoS that honors DSCP marks - plain ISP
rem modem/router setups ignore them (see Network\README.md bufferbloat links).
rem Also sets "Do not use NLA"=1: without it, non-domain machines ignore QoS policies.
rem Usage: "Set Game DSCP.bat" game.exe          - tag its traffic
rem        "Set Game DSCP.bat" game.exe revert   - remove the policy
rem        "Set Game DSCP.bat" list              - show all QoS policies

If /i "%~1"=="list" (
 powershell -NoProfile -Command "Get-NetQosPolicy | Format-Table -AutoSize Name, AppPathName, DSCPValue"
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
 powershell -NoProfile -Command "Remove-NetQosPolicy -Name 'DSCP46 %~nx1' -Confirm:$false"
 Echo Removed DSCP policy for %~nx1
 Pause & Exit
)

rem non-domain machines ignore QoS policies without this (documented QoS gotcha)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\QoS" /v "Do not use NLA" /t REG_SZ /d "1" /f >nul
powershell -NoProfile -Command "New-NetQosPolicy -Name 'DSCP46 %~nx1' -AppPathNameMatchCondition '%~nx1' -DSCPAction 46 -NetworkProfile All" >nul
Echo %~nx1 traffic now tagged DSCP 46 - effective only if the router honors DSCP (SQM/QoS).
Echo Reboot (or gpupdate /force) may be needed for "Do not use NLA" to take effect.
Pause & Exit

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment" >nul 2>&1
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ...
 Pause & Exit
)
Cls
goto:eof
