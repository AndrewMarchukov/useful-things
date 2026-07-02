# Apply order + measurement loop

Fresh Windows 11 install -> low-latency gaming box, in order.
One batch at a time. Measure between. Keep receipts.

## 0. Baseline (before ANY tweak)

- GPU driver (NVCleanstall), chipset driver, EXPO/XMP in BIOS (`Latency/BIOS.md`).
- Smart App Control: fresh 24H2/25H2 installs run SAC in evaluation mode. It blocks
  unsigned tools (half this repo's toolkit), and turning it off is PERMANENT until a
  reinstall - decide here in step 0, deliberately, not mid-setup.
- Pagefile: keep a small fixed pagefile (4-8 GB) even with 32 GB+ RAM. Fully disabling
  it crashes commit-heavy titles (UE5 games, Star Citizen); "no pagefile = faster" is
  folklore. `Diag/Check Pagefile...ps1` reports the current state.
- Capture the baseline numbers first - see "Measurement loop" below. A tweak without
  a baseline is a belief, not a result.

## 1. Verify platform (`Diag/`)

| Script | Confirms |
|---|---|
| `Check BIOS From Windows.ps1` | RAM at rated speed, Secure Boot, TPM, boost mode/EPP |
| `Check ReBAR.bat` | BAR1 ~= VRAM size (ReBAR actually active) |
| `Check Bcdedit.bat` | timer/kernel boot flags as intended |
| `Check BypassIO.bat` | DirectStorage fast path intact |
| `Check Overlays and Startup.ps1` | nothing injecting that you did not choose |

## 2. Safe batch

- Run `All-in-one-AMD-safe.bat` (or Intel variant). Reboot.
- `Diag/Check VBS.ps1` - confirm VBS actually off, Game Mode still on.
- Re-measure. This is the new reference point.

## 3. Optional tweaks - ONE AT A TIME

- `Latency/System/Optional/`, `Network/Optional/`, `Latency/GPU/Optional/`
- Apply one -> reboot -> measure -> keep only if the numbers improve.
- Measures neutral? Revert it. Fewer moving parts always wins at 3 a.m.

## Measurement loop (the receipts)

- **LatencyMon**: 10 min idle + 10 min in-game; highest ISR/DPC + per-CPU view.
- **CapFrameX**: 3 x 5 min on a fixed, repeatable scene; compare avg / 1% / 0.1% lows.
- **FrameView**: PC latency (PCL) in Reflex-capable games.
- **MouseTester**: polling interval plot after any USB/input change.

One variable per experiment. Change nothing else while capturing.

## When updates land

- **Windows feature update**: re-run ALL Diag checks - updates silently re-enable VBS,
  reset power settings and service start types.
- **New GPU driver**: re-check NVCP settings (Vulkan/OpenGL present method, Reflex) -
  installers like to reset them.
