@Echo Off
Title Xbox Mode / Full Screen Experience (staged Windows feature, ViVeTool)
cd %systemroot%\system32
call :IsAdmin

rem Xbox mode (formerly Full Screen Experience): the Xbox shell as a console-like
rem gaming mode with fewer background processes - official rollout July 14, 2026,
rem staged in 25H2 since the May 2026 update. This enables the hidden toggle early;
rem after reboot configure it in Settings ^> Gaming ^> Xbox mode.
rem Designed for handhelds/controller-first: desktop keyboard+mouse benefit is
rem UNPROVEN - measure (see ..\APPLY-ORDER.md) before keeping.
rem Needs ViVeTool.exe next to this script: https://github.com/thebookisclosed/ViVe/releases
rem Usage: enable (no args) ^| revert ^| status

set "FIDS=58989070,59765208"

set "VIVE="
if exist "%~dp0ViVeTool.exe" set "VIVE=%~dp0ViVeTool.exe"
if not defined VIVE (where vivetool.exe >nul 2>&1 && set "VIVE=vivetool.exe")
if not defined VIVE (
 Echo ViVeTool not found. Download it from https://github.com/thebookisclosed/ViVe/releases
 Echo and place ViVeTool.exe next to this script.
 Pause & Exit
)

for /f "tokens=3" %%v in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuildNumber ^| findstr /i CurrentBuildNumber') do set "BUILD=%%v"
if %BUILD% LSS 26200 (
 Echo Requires Windows 11 25H2 (Build 26200+) with the May 2026 update or newer.
 Pause & Exit
)

If /i "%~1"=="revert" (
 "%VIVE%" /disable /id:%FIDS%
 Echo Xbox mode feature flags disabled. Reboot to apply.
 goto :Status
)
If /i "%~1"=="status" goto :Status

"%VIVE%" /enable /id:%FIDS%
Echo Xbox mode feature flags enabled. Reboot, then Settings ^> Gaming ^> Xbox mode.

:Status
Echo.
"%VIVE%" /query /id:%FIDS%
Pause & Exit

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment" >nul 2>&1
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ...
 Pause & Exit
)
Cls
goto:eof
