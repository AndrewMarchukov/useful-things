https://www.youtube.com/watch?v=x0BN608Sd3Q

*IMPORTANT* Download PowerSettingsExplorer from here and run it as administrator. Then find the following 2 options: Processor Idle Demote Threshold and Processor Idle Promote Threshold, UNtick them both, then go to your power plan settings, find the new option under "Processor Power Management" and set both to 100%. That helps lower mostly all latencies

Subgroup / Setting GUIDs:
54533251-82be-4824-96c1-47b60b740d00 / 4b92d758-5a24-4851-a470-815d78aee119
54533251-82be-4824-96c1-47b60b740d00 / 7b224883-b3cc-4d79-819f-8374152cbe7c

Dubious / likely counterproductive. Per Microsoft's documented behavior: setting Promote to 100% disables Turbo Boost, and setting Promote ≤ Demote (both 100%) makes Windows whipsaw cores between C-states many times/second — increasing latency and causing audio underruns. That's the opposite of the stated goal.

Bottom line: The tool and GUIDs are fine, but the recommendation is wrong. Both thresholds at 100% hits the exact failure mode the docs warn about:

Promote=100% → Turbo Boost off (you lose your single-core boost clocks — a real performance hit).
Promote == Demote → C-state whipsawing → higher latency + audio dropouts.
The correct way to cut C-state latency is to stop the CPU entering deep idle states, not to fiddle demote/promote to 100%. That's done via:

"Processor idle disable" = Disable C-States (power setting 5d76a2ca-e8c0-402f-a133-2158492d58ad), or
the C-state limit in BIOS/UEFI, or
a high-performance/"ultimate" power plan.