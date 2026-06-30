@echo off
setlocal
title All-in-one AMD-safe Tweaks

:: ============================================================
::  All-in-one (AMD-safe) launcher.
::  Just runs the curated tweak files from their own folders.
::  Excludes: Latency\System\Optional, Latency\System\PowerSettingsExplorer,
::            Network\Optional.
:: ============================================================

:: ---- self-elevate to Administrator ----
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"
set "ROOT=%~dp0"

echo ============================================================
echo  Running AMD-safe tweaks. Each file runs in its own window-less
echo  child process; pauses are auto-skipped.
echo ============================================================

:: ---------- Latency\System ----------
call :run "Latency\System\Apply DPC Kernel Tweaks.bat"
call :run "Latency\System\Apply Kernel Tweaks.bat"
call :run "Latency\System\Apply NVME Tweaks.bat"
call :run "Latency\System\Main-Latency-Tweaks.bat"
call :run "Latency\System\Disable CoalescingTimerInterval.cmd"
call :run "Latency\System\Gamebar.bat"
call :run "Latency\System\set-int-steer-mode.bat"
call :run "Latency\System\CSRSS.reg"
call :run "Latency\System\DriverPrio.reg"
call :run "Latency\System\ExtendedComposition.reg"
call :run "Latency\System\Mouseq.reg"
call :run "Latency\System\NduDisable.reg"
call :run "Latency\System\Resource Sets.reg"
call :run "Latency\System\SerializeTimerExpiration.reg"
call :run "Latency\System\SplitLargeCaches.reg"
call :run "Latency\System\SystemProfile.reg"
call :run "Latency\System\audiodg.reg"
call :run "Latency\System\dwm.reg"
call :run "Latency\System\LAL\LowAudioLatency.bat"
call :run "Latency\System\TimerResolutionTweak\ResolutionTimerTweak.bat"
call :run "Latency\System\TimerResolutionTweak\GlobalTimerResolutionRequests_on.reg"

:: ---------- Latency\CPU ----------
call :run "Latency\CPU\all_proc_for_PBO.ps1"

:: ---------- Network (Optional excluded) ----------
call :run "Network\afd.reg"
call :run "Network\pnpcap.bat"
call :run "Network\NetworkTweaks.bat"

:: ---------- Additional ----------
call :run "Additional\EdgePreloadDisable.reg"
call :run "Additional\HibernateOFF.reg"
call :run "Additional\stickykeysOFF.reg"
call :run "Additional\DisableDVRbackground capture.bat"
call :run "Additional\DisableServicesIntel.bat"
call :run "Additional\LocationServiceDisable.bat"
call :run "Additional\NTFStweak.bat"
call :run "Additional\ShowHiddenFilesAndFileExtensions.bat"
call :run "Additional\telemetrystop.cmd"

:: ---------- Sound ----------
call :run "Sound\SoundCommN.reg"
call :run "Sound\AL-HRTF.bat"

echo.
echo ============================================================
echo  Done. A reboot is recommended for all tweaks to take effect.
echo ============================================================
pause
exit /b

:: ---------- launcher subroutine ----------
:: %1 = path relative to this script's folder. Dispatches by extension.
:: .reg -> silent import; .ps1 -> powershell; .bat/.cmd -> isolated child
:: cmd with stdin from nul so their EXIT/pause can't stop this script.
:run
set "f=%~1"
if not exist "%ROOT%%f" (
    echo [SKIP missing] %f
    goto :eof
)
echo.
echo --- %f ---
if /i "%~x1"==".reg" (
    regedit /s "%ROOT%%f"
) else if /i "%~x1"==".ps1" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%%f" <nul
) else (
    cmd /c ""%ROOT%%f"" <nul
)
goto :eof
