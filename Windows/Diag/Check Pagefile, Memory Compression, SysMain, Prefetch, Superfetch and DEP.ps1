# Self-elevate to Administrator if not already running elevated
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

function Write-Section {
    param ($title)
    Write-Host "`n==== $title ===="
}

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

# === PAGEFILE ===
Write-Section "PAGEFILE"

# Check if automatic pagefile management is enabled
$autoPagefile = (Get-WmiObject -Class Win32_ComputerSystem).AutomaticManagedPagefile
$pagefiles = Get-WmiObject Win32_PageFileUsage

# Determine if at least one Pagefile is "System Managed Size"
$hasSystemManaged = $false
foreach ($pagefile in $pagefiles) {
    if ($pagefile.AllocatedBaseSize -eq 0) { 
        $hasSystemManaged = $true
        break
    }
}

# Detect if all Pagefiles are disabled
$allPagefilesDisabled = $pagefiles.Count -eq 0 -or ($pagefiles | Where-Object { $_.AllocatedBaseSize -gt 0 }).Count -eq 0

# Set the appropriate output text
if ($autoPagefile) {
    Write-Host "Pagefile management: Automatic (all drives)"
} elseif ($allPagefilesDisabled) {
    Write-Host "Pagefile management: Disabled (no paging file configured)"
} elseif ($hasSystemManaged) {
    Write-Host "Pagefile management: System managed size"
} else {
    Write-Host "Pagefile management: Custom size"
}

# Display current Pagefile state
if ($pagefiles) {
    Write-Host "`nCurrent Pagefile status:"
    $pagefiles | ForEach-Object {
        Write-Host ("{0,-15} | Used: {1,7} MB | Allocated Max: {2,7} MB" -f $_.Name, $_.CurrentUsage, $_.AllocatedBaseSize)
    }
} else {
    Write-Host "No Pagefile detected on the system."
}

# === MEMORY COMPRESSION ===
Write-Section "MEMORY COMPRESSION"
$mc = (Get-MMAgent).MemoryCompression
Write-Host "Status: $($mc -replace 'True','Enabled' -replace 'False','Disabled')"

# === SYSMAIN (Superfetch) ===
Write-Section "SUPERFETCH (SysMain)"
$sysMain = Get-Service -Name "SysMain" -ErrorAction SilentlyContinue
if ($sysMain) {
    Write-Host "Service status: $($sysMain.Status)"
} else {
    Write-Host "SysMain service not found."
}

# === PREFETCH & SUPERFETCH (REGISTRY) ===
Write-Section "PREFETCH & SUPERFETCH (Registry)"
try {
    $regPath = "HKLM:\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Memory Management\\PrefetchParameters"
    if (Test-Path $regPath) {
        $params = Get-ItemProperty -Path $regPath

        # Prefetch
        $prefetchStatus = switch ($params.EnablePrefetcher) {
            0 { "Disabled" }
            1 { "Application launch only" }
            2 { "Boot only" }
            3 { "Applications and boot (default)" }
            Default { "Unknown ($($params.EnablePrefetcher))" }
        }
        Write-Host "Prefetch:  $prefetchStatus"

        # Superfetch (if present)
        if ($params.PSObject.Properties.Name -contains "EnableSuperfetch") {
            $superfetchStatus = switch ($params.EnableSuperfetch) {
                0 { "Disabled" }
                1 { "Application launch only" }
                2 { "Boot only" }
                3 { "Applications and boot (default)" }
                Default { "Unknown ($($params.EnableSuperfetch))" }
            }
            Write-Host "Superfetch: $superfetchStatus"
        } else {
            Write-Host "Superfetch: Not configured in registry."
        }
    } else {
        Write-Host "Prefetch/Superfetch registry key not found."
    }
} catch {
    Write-Host "Error accessing Prefetch/Superfetch registry settings."
}

# === DEP (Data Execution Prevention) ===
Write-Section "DEP (Data Execution Prevention)"
try {
    # wmic is removed in Win11 24H2/25H2 - query CIM directly
    $depPolicyValue = [int](Get-CimInstance Win32_OperatingSystem).DataExecutionPrevention_SupportPolicy
    $depStatus = switch ($depPolicyValue) {
        0 { "Disabled for all processes" }
        1 { "Enabled for all processes" }
        2 { "Enabled only for essential Windows programs and services (default)" }
        3 { "Enabled for all processes" }
        Default { "Unknown value ($depPolicyValue)" }
    }
    Write-Host "Current DEP status: $depStatus"
} catch {
    Write-Host "Error querying DEP status."
}

pause