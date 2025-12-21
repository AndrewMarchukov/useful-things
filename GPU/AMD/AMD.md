Amd chipset drivers install errors in windows 11 24-25h2
For those trying to fix this:  
Open Powershell as Administrator.

To see if VBS is installed or not:

Get-WindowsCapability -Online -Name vbs*

To install VBS:  
Add-WindowsCapability -Online -Name "VBScript~~~~0.0.1.0"

or

DISM /Online /Add-Capability /CapabilityName:VBScript

The Chipset drivers should install perfectly fine afterwards. If you want to remove VBS for security reasons afterwards:  
Remove-WindowsCapability -Online -Name "VBScript~~~~0.0.1.0"

or

DISM /Online /remove-Capability /CapabilityName:VBScript


https://www.reddit.com/r/radeon/s/pGybq2lF4y