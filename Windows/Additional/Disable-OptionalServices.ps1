#Requires -Version 5.1
# Set-OptionalServices.ps1 — downgrade optional/privacy services one step.
#   Automatic -> Manual,  Manual -> Disabled,  Disabled -> unchanged.
# Monotonic: re-running never re-enables anything. Reboot to fully apply.
# Right-click -> "Run with PowerShell" (self-elevates).

# --- self-elevate to Administrator ---
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
        ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -Verb RunAs `
        -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    exit
}

# Base service names. Per-user services use the template name (no _<luid> suffix).
# NEVER add GameInputSvc here: it is Microsoft's modern input stack (GameInput API) -
# controllers/input in newer titles break without it.
$targets = 'whesvc','DusmSvc','SSDPSRV','lmhosts','StiSvc','CDPSvc','CDPUserSvc'

$reg   = 'HKLM:\SYSTEM\CurrentControlSet\Services'
$label = @{ 2='Automatic'; 3='Manual'; 4='Disabled' }

$changed = 0; $unchanged = 0; $fail = 0; $missing = 0
foreach ($svc in $targets) {
    $key = Join-Path $reg $svc
    if (-not (Test-Path $key)) { Write-Host "[missing  ] $svc" -ForegroundColor DarkGray; $missing++; continue }

    $cur = (Get-ItemProperty -Path $key -Name Start -ErrorAction SilentlyContinue).Start
    switch ([int]$cur) {
        2       { $target = 3 }   # Automatic -> Manual
        3       { $target = 4 }   # Manual    -> Disabled
        4       { $target = 4 }   # Disabled  -> stay
        default { $target = 3 }   # unknown   -> Manual
    }

    $from = if ($label.ContainsKey([int]$cur)) { $label[[int]$cur] } else { "Start=$cur" }
    if ($target -eq [int]$cur) { Write-Host "[ok       ] $svc already $from" -ForegroundColor DarkGray; $unchanged++; continue }

    try {
        Set-ItemProperty -Path $key -Name Start -Value $target -Type DWord -ErrorAction Stop
        Write-Host "[set      ] $svc : $from -> $($label[$target])" -ForegroundColor Green; $changed++
    } catch {
        Write-Host "[failed   ] $svc -> $($_.Exception.Message)" -ForegroundColor Red; $fail++
    }
}
Write-Host "`nChanged: $changed   Unchanged: $unchanged   Failed: $fail   Not-found: $missing" -ForegroundColor Cyan
Write-Host "Reboot for the new start types to take effect." -ForegroundColor Yellow
Read-Host "`nPress Enter to close"
