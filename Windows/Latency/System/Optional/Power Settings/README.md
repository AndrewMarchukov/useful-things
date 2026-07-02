https://www.youtube.com/watch?v=x0BN608Sd3Q

*IMPORTANT* Download PowerSettingsExplorer from here and run it as administrator. Then find the following 2 options: Processor Idle Demote Threshold and Processor Idle Promote Threshold, UNtick them both, then go to your power plan settings, find the new option under "Processor Power Management" and set both to 100%. That helps lower mostly all latencies

Subgroup / Setting GUIDs:
54533251-82be-4824-96c1-47b60b740d00 / 4b92d758-5a24-4851-a470-815d78aee119
54533251-82be-4824-96c1-47b60b740d00 / 7b224883-b3cc-4d79-819f-8374152cbe7c

## Assessment (verified against Microsoft docs)

The GUIDs and mechanism are real, but "lowers mostly all latencies" oversells it. Per the MS docs
(IdlePromoteThreshold / IdleDemoteThreshold - hidden settings, percentage 0-100):

- Promote threshold = idleness required to move to a DEEPER idle state; demote = idleness below it moves lighter.
- At 100/100, idleness can never exceed the promote threshold, so cores get pinned to the shallowest
  idle state (C1) and never reach deep C-states. That removes deep C-state wake latency
  (microsecond scale, visible as DPC spikes in LatencyMon) - and nothing else.
- The docs use strict above/below conditions: there is no documented "whipsaw" at 100/100,
  and the setting does not literally disable Turbo (that claim confuses C-states with P-states).
- The REAL cost: cores held in C1 burn more power than C6, shrinking Precision Boost / Turbo
  headroom, so single-core boost clocks can drop. Verify with HWiNFO after applying; revert if they do.
- Do NOT use "Processor idle disable" (IDLEDISABLE, 5d76a2ca-e8c0-402f-a133-2158492d58ad) instead:
  it forces C0 busy-spin (worse than C1 halt), and C-state disabling is measured to hard-cap
  Ryzen 7000 boost at 5.5 GHz: https://skatterbencher.com/2022/10/26/update-on-ryzen-7000-c-state-boost-limit/
- PowerSettingsExplorer is not needed: "Apply CState Tweaks.bat" in this folder does
  apply / revert / status natively via powercfg.

Docs:
https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/options-for-perf-state-engine-idlepromotethreshold
https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/options-for-perf-state-engine-idledemotethreshold