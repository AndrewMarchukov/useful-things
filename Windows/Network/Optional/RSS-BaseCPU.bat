@Echo Off
Title RSS Base CPU (move NIC receive DPCs off core 0)
cd %systemroot%\system32
call :IsAdmin

rem Moves RSS (NIC receive processing) base CPU off core 0 to logical CPU 2
rem (second physical core with SMT). Docs: learn.microsoft.com Set-NetAdapterRss.
rem Requires RSS ENABLED on the adapter. If you deliberately run RSS off
rem (common choice on 1GbE), this tweak does not apply - the script detects
rem that and changes nothing; it never force-enables RSS.
rem Modern Windows already migrates load off a busy core 0 dynamically, so the
rem gain is small and steady-state only. Verify with LatencyMon per-CPU DPC
rem view: ndis.sys work should move off CPU 0.
rem Usage: apply (no args) ^| revert ^| status

If /i "%~1"=="revert" goto :Revert
If /i "%~1"=="status" goto :Status

powershell -NoProfile -Command "$rss = @(Get-NetAdapterRss -Name * -ErrorAction SilentlyContinue | Where-Object {$_.Enabled}); if (-not $rss) { Write-Host 'RSS is DISABLED on all adapters - nothing to do (enable first: Enable-NetAdapterRss -Name <adapter>)' } else { $rss | ForEach-Object { Set-NetAdapterRss -Name $_.Name -BaseProcessorNumber 2; Write-Host ('Base CPU set to 2 on: ' + $_.Name) } }"
goto :Status

:Revert
rem 0 = the Windows default base processor
powershell -NoProfile -Command "Get-NetAdapterRss -Name * -ErrorAction SilentlyContinue | Where-Object {$_.Enabled} | ForEach-Object { Set-NetAdapterRss -Name $_.Name -BaseProcessorNumber 0; Write-Host ('Base CPU restored to 0 on: ' + $_.Name) }"
goto :Status

:Status
Echo.
powershell -NoProfile -Command "Get-NetAdapterRss -Name * -ErrorAction SilentlyContinue | Format-List Name, Enabled, BaseProcessorNumber, MaxProcessorNumber, MaxProcessors"
Pause & Exit

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment" >nul 2>&1
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ...
 Pause & Exit
)
Cls
goto:eof
