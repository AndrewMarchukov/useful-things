copy "%~dp0\low_audio_latency_no_console.exe" C:\low_audio_latency_no_console.exe
schtasks /create /tn "LowAudioLatency" /tr "cmd /c timeout /t 11 & C:\low_audio_latency_no_console.exe" /sc onstart /rl highest /f /ru "SYSTEM"
