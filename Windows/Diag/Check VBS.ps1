# Verifies VBS/HVCI is actually OFF - feature updates and Defender silently
# re-enable it, overriding Main-Latency-Tweaks.bat. Read-only, changes nothing.
# Also confirms Game Mode is still ON (drives CCD parking on X3D CPUs,
# blocks Windows Update restarts mid-game).

$dg = Get-CimInstance -Namespace root\Microsoft\Windows\DeviceGuard -ClassName Win32_DeviceGuard

$vbsMap = @{ 0 = 'Off'; 1 = 'Enabled but not running'; 2 = 'RUNNING' }
$vbs = [int]$dg.VirtualizationBasedSecurityStatus
Write-Host "VBS status: $($vbsMap[$vbs])"

$svcMap = @{ 1 = 'Credential Guard'; 2 = 'HVCI (Memory Integrity)'; 3 = 'System Guard'; 4 = 'SMM Firmware Protection' }
$running = @($dg.SecurityServicesRunning) | Where-Object { $_ -ne 0 }
if ($running) {
    Write-Host "Security services running: $(($running | ForEach-Object { $svcMap[[int]$_] }) -join ', ')"
} else {
    Write-Host "Security services running: none"
}

if ($vbs -eq 2) {
    Write-Host "WARNING: VBS is running - an update or Defender re-enabled it. Re-run Main-Latency-Tweaks.bat and reboot." -ForegroundColor Yellow
}

# Game Mode: value absent = default ON
$gm = (Get-ItemProperty 'HKCU:\Software\Microsoft\GameBar' -Name AutoGameModeEnabled -ErrorAction SilentlyContinue).AutoGameModeEnabled
if ($null -eq $gm -or $gm -eq 1) {
    Write-Host "Game Mode: On (keep it on)"
} else {
    Write-Host "Game Mode: OFF - turn it back on: Settings > Gaming > Game Mode" -ForegroundColor Yellow
}

pause
