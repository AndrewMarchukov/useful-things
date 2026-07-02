# Experimental

Staged/insider Windows features enabled ahead of Microsoft's controlled rollout.

Bar for this folder: **documented feature ID or KB, known purpose, clean revert path.**

Rules: apply one at a time, measure (see `..\APPLY-ORDER.md`), expect behavior to change
between builds, re-verify after every feature update.

## Contents

- **Enable Low Latency Profile.bat** — "Race to Sleep" CPU frequency boost for interactive
  actions (June 2026, KB5094126 wave): up to 40% faster app launches, up to 70% faster
  shell interactions, small input-lag gains alongside overlays/voice chat. Pairs with the
  LowLatency-event extension already in `..\Latency\System\Main-Latency-Tweaks.bat`.
  Needs Build 26200.8524+ and ViVeTool.exe next to the script:
  https://github.com/thebookisclosed/ViVe/releases
- **Enable Xbox Mode.bat** — the handheld Full Screen Experience on desktop ahead of the
  July 14 rollout: Xbox shell as a console-like gaming mode with fewer background
  processes (feature IDs 58989070, 59765208; toggle appears in Settings > Gaming >
  Xbox mode after reboot). Controller-first by design — desktop keyboard+mouse benefit
  unproven, measure before keeping. Re-evaluate the Game Mode guidance in
  `..\Diag\Check VBS.ps1` after trying it.

## Watchlist

- **System-wide low-latency audio profile** (26H2 preview, Build 26220.8690): a native
  Settings toggle (System > Sound > Advanced) that bypasses audio processing/buffer
  stages — 4-8 ms lower round-trip latency in DAWs, 10-15% on USB headsets. Insider-only
  for now, no public feature ID; when 26H2 ships, compare against the LAL tool
  (`..\Latency\System\LAL`) and keep whichever measures better.
- **Update currency as a tweak**: KB5074109 (early 2026) fixed a scheduler regression
  causing GPU micro-stutter invisible to FPS counters; DirectStorage streaming also improved.
  Staying current has delivered more real gaming gains in 2026 than any registry value —
  verify the DirectStorage path with `..\Diag\Check BypassIO.bat` after storage changes.
