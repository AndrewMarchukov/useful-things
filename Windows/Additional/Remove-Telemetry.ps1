#Requires -Version 5.1
# Remove-Telemetry.ps1 — deletes telemetry tasks from Windows and third-party software.

# --- self-elevate to Administrator ---
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
        ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -Verb RunAs `
        -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    exit
}

$targets = @(
    # Google PEH telemetry only (Daily/Metrics)
    @{ Path='\GoogleUserPEH\'; Name='*' }

    # Windows telemetry
    @{ Path='\Microsoft\Windows\Application Experience\';   Name='MareBackup' }
    @{ Path='\Microsoft\Windows\Application Experience\';   Name='StartupAppTask' }
    @{ Path='\Microsoft\Windows\Autochk\';                 Name='Proxy' }
    @{ Path='\Microsoft\Windows\Diagnosis\';               Name='RecommendedTroubleshootingScanner' }
    @{ Path='\Microsoft\Windows\Diagnosis\';               Name='Scheduled' }
    @{ Path='\Microsoft\Windows\Diagnosis\';               Name='UnexpectedCodepath' }
    @{ Path='\Microsoft\Windows\DUSM\';                    Name='dusmtask' }
    @{ Path='\Microsoft\Windows\Flighting\FeatureConfig\'; Name='UsageDataFlushing' }
    @{ Path='\Microsoft\Windows\Flighting\FeatureConfig\'; Name='UsageDataReceiver' }
    @{ Path='\Microsoft\Windows\Flighting\FeatureConfig\'; Name='UsageDataReporting' }
    @{ Path='\Microsoft\Windows\Flighting\OneSettings\';   Name='RefreshCache' }
    @{ Path='\Microsoft\Windows\PerformanceTrace\';        Name='RequestTrace' }
    @{ Path='\Microsoft\Windows\PerformanceTrace\';        Name='ShowFeedbackToast' }
    @{ Path='\Microsoft\Windows\PerformanceTrace\';        Name='WhesvcToast' }
    @{ Path='\Microsoft\Windows\PI\';                      Name='Sqm-Tasks' }   # NOT Secure-Boot-Update
    @{ Path='\Microsoft\Windows\Sustainability\';          Name='SustainabilityTelemetry' }
    @{ Path='\Microsoft\Windows\UsageAndQualityInsights\'; Name='UsageAndQualityInsights-MaintenanceTask' }
    @{ Path='\Microsoft\Windows\Windows Error Reporting\'; Name='QueueReporting' }

    #
    @{ Path='\Microsoft\Windows\Maps\';                  Name='MapsToastTask' }
    @{ Path='\Microsoft\Windows\Shell\';                 Name='FamilySafetyMonitor' }
    @{ Path='\Microsoft\Windows\Shell\';                 Name='FamilySafetyRefreshTask' }
    @{ Path='\Microsoft\Windows\Speech\';                Name='SpeechModelDownloadTask' }
    @{ Path='\Microsoft\Windows\RemoteAssistance\';      Name='RemoteAssistanceTask' }
    @{ Path='\Microsoft\Windows\PushToInstall\';         Name='LoginCheck' }
    @{ Path='\Microsoft\Windows\PushToInstall\';         Name='Registration' }
    @{ Path='\Microsoft\Windows\Sustainability\';        Name='PowerGridForecastTask' }
    @{ Path='\Microsoft\Windows\Windows Media Sharing\'; Name='UpdateLibrary' }
    @{ Path='\Microsoft\Windows\WindowsAI\ClickToDo\';   Name='*' }
    @{ Path='\Microsoft\Windows\WindowsAI\Recall\';      Name='PolicyConfiguration' }
    @{ Path='\Microsoft\Windows\WindowsAI\Settings\';    Name='InitialConfiguration' }
    @{ Path='\Microsoft\Windows\Work Folders\';          Name='*' }
    @{ Path='\Microsoft\Windows\WwanSvc\';               Name='*' }
    @{ Path='\Microsoft\Windows\EDP\';                   Name='*' }
    @{ Path='\Microsoft\Windows\DeviceDirectoryClient\'; Name='*' }   # Find My Device
)

$done = 0; $fail = 0; $missing = 0
foreach ($t in $targets) {
    $tasks = Get-ScheduledTask -TaskPath $t.Path -TaskName $t.Name -ErrorAction SilentlyContinue
    if (-not $tasks) { Write-Host "[missing] $($t.Path)$($t.Name)" -ForegroundColor DarkGray; $missing++; continue }
    foreach ($task in $tasks) {
        $id = "$($task.TaskPath)$($task.TaskName)"
        try {
            Unregister-ScheduledTask -TaskName $task.TaskName -TaskPath $task.TaskPath -Confirm:$false -ErrorAction Stop
            Write-Host "[removed ] $id" -ForegroundColor Green; $done++
        } catch {
            Write-Host "[failed  ] $id -> $($_.Exception.Message)" -ForegroundColor Red; $fail++
        }
    }
}
Write-Host "`nRemoved: $done   Failed: $fail   Not-found: $missing" -ForegroundColor Cyan
Read-Host "`nPress Enter to close"
