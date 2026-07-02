# BIOS checklist (gaming / latency)

The largest remaining wins live here, not in the registry. Verify from Windows first:
`Diag\Check BIOS From Windows.ps1` (RAM speed, Secure Boot, TPM, boost mode) and
`Diag\Check ReBAR.bat` (Resizable BAR).

## Do

- **EXPO/XMP profile ON** - the single biggest free performance win. If
  `Check BIOS From Windows.ps1` shows ConfiguredClockSpeed below rated Speed, it is off.
- **Resizable BAR + Above 4G Decoding ON** - required for the ReBAR force in
  `GPU\README.md` to do anything. Verify with `Diag\Check ReBAR.bat` (BAR1 total ~= VRAM size).
- **Keep Secure Boot + fTPM ON if you play Vanguard/FACEIT titles** (VAN9001/9003
  otherwise) - see the anti-cheat warning in `README.md`.
- **Keep BIOS/AGESA current** - fixes the fTPM stutter (AGESA 1.2.0.7+), boost behavior,
  memory compatibility.
- **PBO / Curve Optimizer** - real gains, per-CPU tuning; tooling in `Latency\CPU`.

## Do NOT

- **Do NOT disable C-states ("Global C-state Control")** - measured to hard-cap boost
  clocks (Ryzen 7000: 5.5 GHz limit):
  https://skatterbencher.com/2022/10/26/update-on-ryzen-7000-c-state-boost-limit/
  The milder OS-side alternative already lives in `System\Optional\Power Settings`.
- **Do NOT disable SMT for "latency" without measuring** - modern titles usually lose
  more than they gain; test per game, keep the receipt.
- **HPET on/off ritual** - leave BIOS default; timer policy is handled by bcdedit
  (see `README.md`). The "disable HPET" advice is from a different hardware era.
