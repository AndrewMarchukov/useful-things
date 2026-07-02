@Echo Off
Title Check Resizable BAR (NVIDIA)
cd %systemroot%\system32

rem Verifies ReBAR is ACTIVE at the platform level - the Profile Inspector
rem per-game force does nothing if Above 4G Decoding / ReBAR is off in BIOS.
rem BAR1 "Total" close to VRAM size = active. 256 MiB = inactive.
rem Also visible in: NVIDIA Control Panel - System Information - "Resizable BAR".
rem Read-only check, changes nothing.

where nvidia-smi >nul 2>&1
If Not %ERRORLEVEL% EQU 0 (
 Echo nvidia-smi not found - is the NVIDIA driver installed?
 Pause & Exit
)

nvidia-smi -q -d MEMORY
Echo.
Echo BAR1 Total close to VRAM size = ReBAR active. 256 MiB = NOT active:
Echo enable Above 4G Decoding + Resizable BAR in BIOS, then recheck.
Pause & Exit
