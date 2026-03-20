# 🛠️ **Инструменты для оптимизации видео**  

https://www.wagnardsoft.com/ Качественное удаление драйверов в безопасном режиме Display Driver Uninstaller (DDU) 

https://www.techpowerup.com/download/techpowerup-nvcleanstall/ Установка драйверов NVIDIA без лишних сервисов и модулей

как поменять сглаживание в играх на нвидиа - https://forums.guru3d.com/threads/nvidia-anti-aliasing-guide-updated.357956/

Инспектор профилей nvidia - https://github.com/Orbmu2k/nvidiaProfileInspector/releases

Настройка прерываний - https://github.com/spddl/GoInterruptPolicy/releases

Андервольтинг - https://youtu.be/qipJcQW5mis

#### DLSS
https://github.com/artur-graniszewski/DLSS-Enabler/releases

https://github.com/cdozdil/OptiScaler

https://github.com/beeradmoore/dlss-swapper

https://github.com/SimonMacer/AnWave/releases/tag/AnWave-DLSS

#### DLSS, FSR, XESS, DirectStorage update
https://github.com/Recol/DLSS-Updater/releases?page=1

#### Для мониторов
https://www.reddit.com/r/MotionClarity/s/pAOspNGG1a This is a snake oil?

проверка сертификации Display port кабеля
https://www.displayport.org/product-category/cables-adaptors/?ps=ugreen

Калибровка цветов - https://bitbucket.org/CalibrationTools/calibration-tools/src/master/

#### difference betwen display modes in windows 
https://youtu.be/JLKzp8WMcqk


#### Rebar Force to all Games (NVIDIA)
✅ Force Resizable BAR (ReBAR) with NVIDIA Profile Inspector
rbar size limit - 0x0000000060000000 


#### Shader cache

🛠️ Commands & Paths Used
Step 1 – Purge DirectX Shader Cache
Run →
cleanmgr
✔ Select DirectX Shader Cache → Clean
Manual delete:
C:\Users\YourUser\AppData\Local\D3DSCache

Step 2 – Disable Shader Compiler Service
Run →
regedit
Path:
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\D3DShaderCache
Set Start → 4 (Disabled)
Revert: 2 (Automatic)

Step 3 – GPU Shader Cache Size
NVIDIA: Control Panel → Manage 3D Settings → Shader Cache Size → Set to 10GB or Unlimited
AMD: Radeon Software → Settings → Storage → Delete Shader Cache

Step 4 – Disable DirectX Telemetry Logging
Run →
regedit
Path:
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\EventLog-Microsoft-Windows-Direct3DShaderCache
Set Start → 0 (Disable logging)
Revert: 1 (Enable logging)

Step 5 – Clean Driver Shader Dumps & Crash Logs
Run →
%localappdata%
Delete inside folders:
NVIDIA\DXCache
AMD\DxCache
CrashDumps
Batch cleanup commands (CMD):
del /s /q "%localappdata%\NVIDIA\DXCache\*.*"
del /s /q "%localappdata%\AMD\DxCache\*.*"
del /s /q "%localappdata%\CrashDumps\*.*"
