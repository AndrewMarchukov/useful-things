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

## Watchlist

- **Xbox mode** (July 14, 2026 update): the handheld Full Screen Experience comes to
  desktop — Xbox shell as the gaming mode with fewer background processes, a Windows-native
  version of what this repo approximates by hand. Re-evaluate the Game Mode guidance in
  `..\Diag\Check VBS.ps1` after it lands.
- **Update currency as a tweak**: KB5074109 (early 2026) fixed a scheduler regression
  causing GPU micro-stutter invisible to FPS counters; DirectStorage streaming also improved.
  Staying current has delivered more real gaming gains in 2026 than any registry value —
  verify the DirectStorage path with `..\Diag\Check BypassIO.bat` after storage changes.
