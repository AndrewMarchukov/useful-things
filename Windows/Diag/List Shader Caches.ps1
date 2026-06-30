# Self-elevate to Administrator if not already running elevated
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$sep = '=' * 80

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'Green'
Clear-Host

$folders = @(
    "C:\Program Files (x86)\Steam\steamapps\shadercache",
    "$env:LOCALAPPDATA\D3DSCache",
    "$env:USERPROFILE\AppData\LocalLow\NVIDIA\PerDriverVersion\DXCache",
    "$env:USERPROFILE\AppData\LocalLow\NVIDIA\PerDriverVersion\GLCache",
    "$env:LOCALAPPDATA\NVIDIA\DXCache",
    "$env:LOCALAPPDATA\NVIDIA\GLCache",
    "D:\SteamLibrary\steamapps\shadercache",
    "E:\SteamLibrary\steamapps\shadercache",
    "F:\SteamLibrary\steamapps\shadercache",
    "G:\SteamLibrary\steamapps\shadercache",
    "C:\Windows\Prefetch",
    "$env:LOCALAPPDATA\NVIDIA\VulkanCache",
    "$env:USERPROFILE\AppData\LocalLow\NVIDIA\PerDriverVersion\VkCache",
    "C:\ProgramData\NVIDIA\NvBackend\ApplicationOntology\cache",
    "C:\ProgramData\NVIDIA Corporation\NV_Cache",
    "$env:LOCALAPPDATA\NVIDIA\NvTelemetryContainer",
    "$env:APPDATA\NVIDIA\ComputeCache",
    "C:\Windows\Temp\NVIDIA Corporation",
    "$env:LOCALAPPDATA\Temp\NVIDIA Corporation",
    "$env:APPDATA\NVIDIA",

    # --- AMD GPU driver shader caches ---
    "$env:LOCALAPPDATA\AMD\DxCache",
    "$env:LOCALAPPDATA\AMD\DxcCache",
    "$env:LOCALAPPDATA\AMD\GLCache",
    "$env:LOCALAPPDATA\AMD\VkCache",

    # --- Path of Exile (game-side ShaderCache) ---
    "C:\Program Files (x86)\Grinding Gear Games\Path of Exile\ShaderCache",
    "C:\Program Files (x86)\Steam\steamapps\common\Path of Exile\ShaderCache",
    "D:\SteamLibrary\steamapps\common\Path of Exile\ShaderCache",
    "E:\SteamLibrary\steamapps\common\Path of Exile\ShaderCache",
    "F:\SteamLibrary\steamapps\common\Path of Exile\ShaderCache",
    "G:\SteamLibrary\steamapps\common\Path of Exile\ShaderCache",

    # --- Path of Exile 2 (game-side ShaderCache) ---
    "C:\Program Files (x86)\Grinding Gear Games\Path of Exile 2\ShaderCache",
    "C:\Program Files (x86)\Steam\steamapps\common\Path of Exile 2\ShaderCache",
    "D:\SteamLibrary\steamapps\common\Path of Exile 2\ShaderCache",
    "E:\SteamLibrary\steamapps\common\Path of Exile 2\ShaderCache",
    "F:\SteamLibrary\steamapps\common\Path of Exile 2\ShaderCache",
    "G:\SteamLibrary\steamapps\common\Path of Exile 2\ShaderCache"
)

$totalSize = 0

Write-Host "`n$sep" -ForegroundColor Cyan
Write-Host "[*] SHADER & PREFETCH CACHES" -ForegroundColor Yellow
Write-Host "$sep`n" -ForegroundColor Cyan

foreach ($folder in $folders) {
    if (Test-Path $folder) {
        $size = (Get-ChildItem $folder -Recurse -File | Measure-Object -Property Length -Sum).Sum
        $sizeMB = "{0:N2}" -f ($size / 1MB)
        Write-Host "$folder - Size: $sizeMB MB"
        $totalSize += $size
    }
}

# Calculate and display total size in different units
$totalSizeMB = "{0:N2}" -f ($totalSize / 1MB)
$totalSizeGB = "{0:N2}" -f ($totalSize / 1GB)

Write-Host "`n$sep" -ForegroundColor Cyan
Write-Host "TOTAL SIZE OF ALL SHADER AND PREFETCH CACHES" -ForegroundColor Yellow
Write-Host "$sep" -ForegroundColor Cyan
Write-Host "$totalSizeMB MB ($totalSizeGB GB)"
Write-Host "$sep`n" -ForegroundColor Cyan

Read-Host "`nDone. Press Enter to close"
