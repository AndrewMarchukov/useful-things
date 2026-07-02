# Read-only audit: running overlay processes + autostart entries.
# Overlays inject into the game's present path - stacked overlays are a common
# frame-time/stutter source that no registry tweak can fix.

$overlays = @{
    'Discord'            = 'Discord overlay (Settings > Activity Settings > toggle off if unused)'
    'NVIDIA Overlay'     = 'NVIDIA App / GeForce overlay (NVIDIA App > Settings > Overlay)'
    'NVIDIA Share'       = 'GeForce Experience Share/ShadowPlay overlay'
    'Medal'              = 'Medal.tv clip overlay'
    'Overwolf'           = 'Overwolf overlay platform'
    'outplayed'          = 'Outplayed (Overwolf) clip overlay'
    'GameBarFTServer'    = 'Xbox Game Bar capture'
    'XboxGameBarWidgets' = 'Xbox Game Bar widgets'
    'RTSS'               = 'RivaTuner Statistics Server (fine if used as fps limiter/OSD)'
    'MSIAfterburner'     = 'MSI Afterburner (OSD renders via RTSS)'
    'obs64'              = 'OBS (game capture hook when active)'
}

Write-Host "==== Running overlay-capable processes ===="
$found = $false
foreach ($name in $overlays.Keys) {
    if (Get-Process -Name $name -ErrorAction SilentlyContinue) {
        Write-Host ("{0,-22} - {1}" -f $name, $overlays[$name]) -ForegroundColor Yellow
        $found = $true
    }
}
if (-not $found) { Write-Host "None of the known overlay processes are running." }

Write-Host "`n==== Autostart (Run keys + Startup folders) ===="
Get-CimInstance Win32_StartupCommand | Sort-Object Location |
    Format-Table -AutoSize Name, Command, Location

pause
