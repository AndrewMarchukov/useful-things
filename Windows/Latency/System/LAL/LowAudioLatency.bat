@echo off
rem https://github.com/spddl/LowAudioLatency
rem Install to a protected (admin-only) folder so the SYSTEM-run exe can't be tampered with.
if not exist "%ProgramFiles%\LowAudioLatency" mkdir "%ProgramFiles%\LowAudioLatency"
copy /y "%~dp0low_audio_latency_no_console.exe" "%ProgramFiles%\LowAudioLatency\"
schtasks /create /tn "LowAudioLatency" /tr "cmd /c timeout /t 11 & \"%ProgramFiles%\LowAudioLatency\low_audio_latency_no_console.exe\"" /sc onstart /rl highest /f /ru "SYSTEM"
