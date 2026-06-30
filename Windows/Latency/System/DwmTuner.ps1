# 1. Require Administrator Privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "You must run this as Administrator! Please restart PowerShell as Admin and try again."
    break
}

# 2. Define target paths
$Folder = "$env:ProgramFiles\DwmTuner"
$FilePath = "$Folder\DwmTuner.ps1"
$TaskName = "DWM Priority Tuner"

# Create target directory if missing
if (-not (Test-Path $Folder)) {
    New-Item -ItemType Directory -Path $Folder | Out-Null
}

# 3. Define worker script content using a bulletproof single-quoted string
$ScriptContent = 'Start-Sleep -Seconds 5

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
using System.Text;

public class DwmTuner {
    [DllImport("kernel32.dll")] public static extern IntPtr OpenThread(int access, bool inherit, uint tid);
    [DllImport("kernel32.dll")] public static extern IntPtr OpenProcess(int access, bool inherit, int pid);
    [DllImport("kernel32.dll")] public static extern bool SetThreadPriority(IntPtr hThread, int prio);
    [DllImport("kernel32.dll")] public static extern bool CloseHandle(IntPtr h);
    [DllImport("ntdll.dll")]    public static extern int NtQueryInformationThread(IntPtr hThread, int cls, IntPtr buf, int size, out int ret);
    [DllImport("psapi.dll", CharSet=CharSet.Unicode)] public static extern uint GetMappedFileNameW(IntPtr hProc, IntPtr addr, StringBuilder name, uint size);
}
"@

function Get-ThreadMod([IntPtr]$hProc, [IntPtr]$hThread) {
    $pAddr = [System.Runtime.InteropServices.Marshal]::AllocHGlobal([IntPtr]::Size)
    try {
        $dummy = 0
        [DwmTuner]::NtQueryInformationThread($hThread, 9, $pAddr, [IntPtr]::Size, [ref]$dummy) | Out-Null
        $addr = [System.Runtime.InteropServices.Marshal]::ReadIntPtr($pAddr)
        $sb = New-Object System.Text.StringBuilder 512
        [DwmTuner]::GetMappedFileNameW($hProc, $addr, $sb, 512) | Out-Null
        return $sb.ToString()
    } finally {
        [System.Runtime.InteropServices.Marshal]::FreeHGlobal($pAddr)
    }
}

$dwm   = Get-Process dwm | Select-Object -First 1
$hProc = [DwmTuner]::OpenProcess(0x0410, $false, $dwm.Id)

foreach ($t in $dwm.Threads) {
    $hThread = [DwmTuner]::OpenThread(0x1FFFFF, $false, [uint32]$t.Id)
    if ($hThread -eq [IntPtr]::Zero) { continue }

    $mod     = Get-ThreadMod $hProc $hThread
    $modName = ($mod -split ''\\'' | Select-Object -Last 1)

    if ($modName -eq "dwmcore.dll" -or $modName -eq "dwmredir.dll") {
        [DwmTuner]::SetThreadPriority($hThread, 15) | Out-Null
    }

    [DwmTuner]::CloseHandle($hThread) | Out-Null
}
[DwmTuner]::CloseHandle($hProc) | Out-Null'

# 4. Write clean script payload to destination
Set-Content -Path $FilePath -Value $ScriptContent -Encoding UTF8
Write-Host "Script successfully saved to $FilePath" -ForegroundColor Green

# 5. Build and configure the Scheduled Task
Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false -ErrorAction SilentlyContinue

$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$FilePath`""
$Trigger = New-ScheduledTaskTrigger -AtLogon
$Principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit 0

Register-ScheduledTask -TaskName $TaskName -Action $Action -Trigger $Trigger -Principal $Principal -Settings $Settings | Out-Null

Write-Host "Task Scheduler configured! DwmTuner will run silently out of Program Files on startup." -ForegroundColor Cyan