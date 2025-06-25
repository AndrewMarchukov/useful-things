
Оптимизированные настройки к играм
https://www.reddit.com/r/OptimizedGaming/
последнии версии DLSS тут, можно заменять библиотеку на более новую в папке с игрой
https://www.techpowerup.com/download/nvidia-dlss-dll/ 
запуск старых dx9-dx11 игр через Vulkan дает новую жизнь старым играм
https://github.com/doitsujin/dxvk 

Ryzen 1-3 gen and old intel DPC Latency fix 

https://www.overclockers.at/articles/the-hpet-bug-what-it-is-and-what-it-isnt

https://sites.google.com/view/melodystweaks/misconceptions-about-timers-hpet-tsc-pmt

```
bcdedit /set tscsyncpolicy enhanced
bcdedit /set useplatformclock false
bcdedit /set disabledynamictick yes 
```
Иногда происходят резкие просадки производительности, периодически резко падает нагрузка на цпу и гпу в играх, помогает отключение сжатия памяти в виндовс https://www.outsidethebox.ms/19318/
```Disable-MMAgent -mc ```

Иногда синхронизация времени может быть важна по умолчанию в Windows это делается раз в неделю при условие если отставание более чем на 1 секунду, поменяем на каждый час и будем использовать дополнительные серверы синхронизации
```
w32tm  /config /manualpeerlist:"ru.pool.ntp.org ntp3.vniiftri.ru ntp4.vniiftri.ru ntp.ix.ru time.cloudflare.com time.google.com ground.corbina.net time.apple.com time.aws.com time.facebook.com ntp2.mail.ru ntp.se" /syncfromflags:manual /update
Regedit
HKEY_LOCAL_MACHINE \SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient
Value name: SpecialPollInterval
Default: 604800
Modified value: 3600

(base) C:\WINDOWS\system32>w32tm /config /update
The following error occurred: The specified service does not exist as an installed service. (0x80070424)

(base) C:\WINDOWS\system32>w32tm /register
W32Time successfully registered.

(base) C:\WINDOWS\system32>w32tm /query /source
The following error occurred: The service has not been started. (0x80070426)

(base) C:\WINDOWS\system32>net start w32time
The Windows Time service is starting.
The Windows Time service was started successfully.

(base) C:\WINDOWS\system32>w32tm /query /source
Local CMOS Clock
```




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