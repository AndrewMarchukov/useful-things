
Оптимизированные настройки к играм
https://www.reddit.com/r/OptimizedGaming/
последнии версии DLSS тут, можно заменять библиотеку на более новую в папке с игрой
https://www.techpowerup.com/download/nvidia-dlss-dll/ 
запуск старых dx9-dx11 игр через Vulkan дает новую жизнь старым играм
https://github.com/doitsujin/dxvk 

Ryzen 1-3 gen and old intel DPC Latency fix
```
bcdedit /set tscsyncpolicy enhanced
bcdedit /set useplatformclock false
bcdedit /set disabledynamictick yes 
```
Иногда происходят резкие просадки производительности, периодически резко падает нагрузка на цпу и гпу в играх, помогает отключение сжатия памяти в виндовс
```Disable-MMAgent -mc ```

Иногда синхронизация времени может быть важна по умолчанию в Windows это делается раз в неделю при условие если отставание более чем на 1 секунду, поменяем на каждый час и будем использовать дополнительные серверы синхронизации
```
w32tm  /config /manualpeerlist:"ru.pool.ntp.org ntp3.vniiftri.ru ntp4.vniiftri.ru ntp.ix.ru ntp6.ntp-servers.net ntp1.ntp-servers.net time.cloudflare.com time.google.com pool.ntp.org" /syncfromflags:manual /update
Regedit
HKEY_LOCAL_MACHINE \SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient
Value name: SpecialPollInterval
Default: 604800
Modified value: 3600

w32tm /config /update
```

#### Улучшаем TCP соединения для Windows некоторые игры до сих пор его используют к примеру Path of Exile, Once Human
``` Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force ```
https://github.com/MysticFoxDE/WINDOWS-OPTIMIZATIONS/blob/main/W10ANDW11-NETWORK-TCP-DESUBOPTIMIZATION.ps1
https://www.speedguide.net/downloads.php 

#### Буфер передачи для сетевой карты должен быть чем меньше тем лучше
https://netbeez.net/blog/what-is-bufferbloat/
https://www.bufferbloat.net/projects/bloat/wiki/Bufferbloat_FAQs/
https://www.bufferbloat.net/projects/bloat/wiki/Linux_Tips/

#### Безопасные твики, запускать под администратором
<details>

```
echo - Disabling ThreadDPC
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "ThreadDpcEnable" /t REG_DWORD /d "0" /f

echo - Disabling Fault Tolerant Heap
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\FTH" /v Enabled /t REG_DWORD /d 0 /f

echo - Disabling IoLatencyCap
FOR /F "eol=E" %%a in ('REG QUERY "HKLM\SYSTEM\CurrentControlSet\Services" /S /F "IoLatencyCap"^| FINDSTR /V "IoLatencyCap"') DO (
REG ADD "%%a" /F /V "IoLatencyCap" /T REG_DWORD /d 0

FOR /F "tokens=*" %%z IN ("%%a") DO (
SET STR=%%z
SET STR=!STR:HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\=!
SET STR=!STR:\Parameters=!
)
)

echo - Disabling StorPort Idle
for /f "tokens=*" %%s in ('reg query "HKLM\System\CurrentControlSet\Enum" /S /F "StorPort" ^| findstr /e "StorPort"') do reg add "%%s" /v "EnableIdlePowerManagement" /t REG_DWORD /d "0" /f


echo - Disabling Windows Tracking
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\Maps" /v "AutoUpdateEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f


echo - Disabling VBS
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f

echo - Disabling Sleep Study
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "SleepstudyAccountingEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDeviceAccountingLevel" /t REG_DWORD /d "0" /f

echo - Disabling Energy Logging
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "DisableTaggedEnergyLogging" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxApplication" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxTagPerApplication" /t REG_DWORD /d "0" /f

echo - Setting Win32 Priority Seperation Value
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 42 /f


echo - Optimizing Your Nvidia GPU
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v "SendTelemetryData" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v "SendTelemetryData" /t REG_DWORD /d "0" /f
schtasks /change /disable /tn "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
timeout 10
```

</details>



#### Исключения для защитника виндовс (Microsoft defender)
<details>

```
Add-MpPreference -ExclusionPath ${env:ProgramFiles(x86)}"\Steam\"
Add-MpPreference -ExclusionPath $env:LOCALAPPDATA"\Temp\NVIDIA Corporation\NV_Cache"
Add-MpPreference -ExclusionPath $env:PROGRAMDATA"\NVIDIA Corporation\NV_Cache"
Add-MpPreference -ExclusionPath $env:windir"\SoftwareDistribution\Datastore\Datastore.edb"
Add-MpPreference -ExclusionPath $env:windir"\SoftwareDistribution\Datastore\Logs\Edb*.jrs"
Add-MpPreference -ExclusionPath $env:windir"\SoftwareDistribution\Datastore\Logs\Edb.chk"
Add-MpPreference -ExclusionPath $env:windir"\SoftwareDistribution\Datastore\Logs\Tmp.edb"
Add-MpPreference -ExclusionPath $env:windir"\SoftwareDistribution\Datastore\Logs\*.log"
Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.edb"
Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.sdb"
Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.log"
Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.chk"
Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.jrs"
Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.xml"
Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.csv"
Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.cmtx"
Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\GroupPolicy\Machine\Registry.pol"
Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\GroupPolicy\Machine\Registry.tmp"
Add-MpPreference -ExclusionPath $env:userprofile"\NTUser.dat"
Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\sru\*.log"
Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\sru\*.dat"
Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\sru\*.chk"
Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\Configuration\MetaConfig.mof"
Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\winevt\Logs\*.evtx"
Add-MpPreference -ExclusionPath $env:windir"\apppatch\sysmain.sdb"
Add-MpPreference -ExclusionPath $env:windir"\EventLog\Data\lastalive?.dat"
Add-MpPreference -ExclusionProcess ${env:ProgramFiles(x86)}"\Windows Kits\10\Windows Performance Toolkit\WPRUI.exe"
Add-MpPreference -ExclusionProcess ${env:ProgramFiles(x86)}"\Windows Kits\10\Windows Performance Toolkit\wpa.exe"
Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\WindowsPowerShell\v1.0\Modules"
Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\Configuration\DSCStatusHistory.mof"
Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\Configuration\DSCEngineCache.mof"
Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\Configuration\DSCResourceStateCache.mof"
Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\Configuration\ConfigurationStatus"
Add-MpPreference -ExclusionProcess ${env:ProgramFiles(x86)}"\Common Files\Steam\SteamService.exe"
```

</details>