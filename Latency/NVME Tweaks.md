[https://techcommunity.microsoft.com/blog/windowsservernewsandbestpractices/announcing-native-nvme-in-windows-server-2025-ushering-in-a-new-era-of-storage-p/4477353](https://techcommunity.microsoft.com/blog/windowsservernewsandbestpractices/announcing-native-nvme-in-windows-server-2025-ushering-in-a-new-era-of-storage-p/4477353)

>  
How to Get Started

>Check your hardware: Ensure you have NVMe-capable devices that are currently using the Windows NVMe driver (StorNVMe.sys). Note that some NVMe device vendors provide their own drivers, so unless using the in-box Windows NVMe driver, you will not notice any differences.

>Enable Native NVMe: After applying the 2510-B Latest Cumulative Update (or most recent), add the registry key with the following PowerShell command:  
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides /v 1176759950 /t REG_DWORD /d 1 /f

>Alternatively, use this [Group Policy MSI](https://download.microsoft.com/download/123547b0-bff7-419d-96ba-d1cfee92f442/Windows%2011%2024H2,%20Windows%2011%2025H2%20and%20Windows%20Server%202025%20KB5066835%20251014_21251%20Feature%20Preview.msi) to add the policy that controls the feature then run the local Group Policy Editor to enable the policy (found under Local Computer Policy > Computer Configuration > Administrative Templates > KB5066835 251014\_21251 Feature Preview > Windows 11, version 24H2, 25H2). Once Native NVMe is enabled, open Device Manager and ensure that all attached NVMe devices are displayed under the “Storage disks” section.

  
Just adding a registry flag isn't going to help unless you're running Windows Server 2025 and have applied the necessary update first.

It's great news, but let's not get ahead of our skis here.




You can enable this now on the latest version of 24H2 / 25H2 Home, Pro or any other version with these reg edit keys

Paste this into powershell:
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides /v 1853569164 /t REG_DWORD /d 1 /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides /v 156965516 /t REG_DWORD /d 1 /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides /v 735209102 /t REG_DWORD /d 1 /f

Just check Device Manager for the new icons to know its enabled

Source: https://forums.guru3d.com/threads/windows-server-2025-finally-gains-native-nvme-storage-support.458797/