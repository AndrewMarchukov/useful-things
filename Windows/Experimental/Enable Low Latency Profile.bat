@Echo Off
Title Low Latency Profile (staged Windows feature, ViVeTool)
cd %systemroot%\system32
call :IsAdmin

rem "Race to Sleep" CPU boost for interactive actions (June 2026, KB5094126 wave):
rem up to 40%% faster app launches, up to 70%% faster shell interactions, small
rem input-lag gains when overlays/voice chat run alongside games.
rem Controlled rollout - this enables it early via its documented feature ID.
rem Pairs with Main-Latency-Tweaks.bat, which extends the LowLatency power event to 6s.
rem Requires Build 26200.8524+ (KB5089573) and ViVeTool.exe next to this script:
rem   https://github.com/thebookisclosed/ViVe/releases
rem EXPERIMENTAL: flips a Microsoft staging flag - documented ID, clean revert, but
rem behavior may change between builds. Reboot after enable/revert.
rem Usage: enable (no args) ^| revert ^| status

set "FID=58989092"

set "VIVE="
if exist "%~dp0ViVeTool.exe" set "VIVE=%~dp0ViVeTool.exe"
if not defined VIVE (where vivetool.exe >nul 2>&1 && set "VIVE=vivetool.exe")
if not defined VIVE (
 Echo ViVeTool not found. Download it from https://github.com/thebookisclosed/ViVe/releases
 Echo and place ViVeTool.exe next to this script.
 Pause & Exit
)

for /f "tokens=3" %%v in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuildNumber ^| findstr /i CurrentBuildNumber') do set "BUILD=%%v"
for /f "tokens=3" %%v in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v UBR ^| findstr /i UBR') do set /a UBR=%%v
if %BUILD% LSS 26200 (
 Echo Requires Build 26200.8524 or newer - you are on %BUILD%.%UBR%. Update Windows first.
 Pause & Exit
)
if %BUILD% EQU 26200 if %UBR% LSS 8524 (
 Echo Requires Build 26200.8524 or newer - you are on %BUILD%.%UBR%. Install KB5089573+.
 Pause & Exit
)

If /i "%~1"=="revert" (
 "%VIVE%" /disable /id:%FID%
 Echo Low Latency Profile disabled. Reboot to apply.
 goto :Status
)
If /i "%~1"=="status" goto :Status

"%VIVE%" /enable /id:%FID%
Echo Low Latency Profile enabled. Reboot to apply.

:Status
Echo.
"%VIVE%" /query /id:%FID%
Pause & Exit

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment" >nul 2>&1
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ...
 Pause & Exit
)
Cls
goto:eof
