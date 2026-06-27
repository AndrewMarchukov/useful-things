@echo off
:: CoalescingTimerInterval = 0 disables Windows timer coalescing.
:: Coalescing batches timer expirations together to save power (fewer CPU idle wakeups).
:: Disabling it = more precise timer firing = lower latency / less mouse+keyboard input lag.
:: Trade-off: more wakeups = more power draw -> DESKTOP ONLY (skip on laptops).
:: Consensus read location is Session Manager\Power; the other keys are harmless redundancy.
REG ADD "HKLM\System\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
REG ADD "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
REG ADD "HKLM\System\CurrentControlSet\Control\Session Manager\kernel" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
REG ADD "HKLM\System\CurrentControlSet\Control\Session Manager\Executive" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
REG ADD "HKLM\System\CurrentControlSet\Control\Session Manager" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
REG ADD "HKLM\System\CurrentControlSet\Control\Power\ModernSleep" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
REG ADD "HKLM\System\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
REG ADD "HKLM\System\CurrentControlSet\Control" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f

:: Removed EventProcessorEnabled=0 : undocumented, default-on power feature that appears to
:: speed up the CPU's response to load. Disabling it has no proven benefit and may hurt responsiveness.
pause
