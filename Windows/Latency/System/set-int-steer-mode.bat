@echo off
::Check Administrator Privileges
dism >nul 2>&1 || (echo ^<Run Script In Administrator^> && pause>nul && cls&exit)
title set-int-steer-mode

:: ============================================================
:: Interrupt Steering Mode - forces "Force enabled"
:: ============================================================
:: Two settings get written together: a kernel flag and a power
:: scheme value. Possible values for each:
::
:: 1) Kernel: InterruptSteeringFlags (REG_DWORD)
::      key absent  = Default  (Windows decides)
::      1           = Disabled (no steering, interrupts land anywhere)
::      2           = Force enabled (steer interrupts onto chosen cores)  <-- THIS SCRIPT
::    Note: undocumented by Microsoft, community-derived.
::
:: 2) Power: powercfg SUB_INTSTEER MODE
::      0 = Default
::      1 = Any processor (pairs with Disabled)
::      4 = Force / locked routing (pairs with Force enabled)            <-- THIS SCRIPT
::
:: Force only helps if you have ALSO reserved cores / set interrupt
:: affinity; otherwise prefer Default. Measure with LatencyMon and
:: 1%/0.1% frametimes before trusting it.
:: ============================================================

set krnl_key=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel

:: Force enabled
reg add "%krnl_key%" /v InterruptSteeringFlags /t reg_dword /d 2 /f >nul

:: lock Interrupt Routing
powercfg -setacvalueindex scheme_current SUB_INTSTEER MODE 4 >nul
powercfg -s scheme_current

exit
