# Self-elevate to Administrator if not already running elevated
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Read-only: BIOS-level ground truth visible from inside Windows.
# 1) RAM: ConfiguredClockSpeed below Speed = XMP/EXPO NOT applied (running JEDEC).
# 2) Secure Boot + TPM: required by Riot Vanguard / FACEIT titles on Win11.
# 3) CPU boost mode / energy-performance preference on the active power plan.

Write-Host "==== RAM: rated vs configured speed (XMP/EXPO check) ===="
$dimms = @(Get-CimInstance Win32_PhysicalMemory)
$dimms | Format-Table -AutoSize BankLabel, Manufacturer, PartNumber, Speed, ConfiguredClockSpeed
if ($dimms | Where-Object { $_.ConfiguredClockSpeed -lt $_.Speed }) {
    Write-Host "ConfiguredClockSpeed below rated Speed: XMP/EXPO is NOT applied - enable it in BIOS (single biggest free perf win)." -ForegroundColor Yellow
} elseif ($dimms) {
    Write-Host "RAM is running at its rated speed."
}

Write-Host "`n==== Secure Boot (required for Valorant/Vanguard, FACEIT) ===="
try {
    if (Confirm-SecureBootUEFI) { Write-Host "Secure Boot: ON" }
    else { Write-Host "Secure Boot: OFF - Vanguard titles will not launch (VAN9001/9003)." -ForegroundColor Yellow }
} catch { Write-Host "Secure Boot: cannot query (legacy BIOS boot mode?)." }

Write-Host "`n==== TPM ===="
try {
    $tpm = Get-Tpm
    Write-Host "TpmPresent: $($tpm.TpmPresent)   TpmReady: $($tpm.TpmReady)"
} catch { Write-Host "TPM: cannot query." }

Write-Host "`n==== CPU boost mode / energy-performance preference (active plan) ===="
# PERFBOOSTMODE: 2 = Aggressive = max boost on CPPC systems.
# PERFEPP: 0 = favor performance, 100 = favor energy savings (CPPC v2 autonomous only).
foreach ($setting in 'PERFBOOSTMODE', 'PERFEPP') {
    $out = powercfg /q scheme_current sub_processor $setting 2>$null | Select-String 'Power Setting GUID', 'Current AC'
    if ($out) { Write-Host "--- $setting ---"; $out | ForEach-Object { Write-Host $_.Line.Trim() } }
    else { Write-Host "--- $setting --- not exposed on this system/plan" }
}
Write-Host ""
Write-Host "Set if needed:  powercfg /setacvalueindex scheme_current sub_processor PERFBOOSTMODE 2"
Write-Host "                powercfg /setacvalueindex scheme_current sub_processor PERFEPP 0"
Write-Host "then apply:     powercfg /setactive scheme_current"

pause
