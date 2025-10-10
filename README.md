## Sources (researched)
- https://github.com/djdallmann/GamingPCSetup
- https://github.com/AlchemyTweaks/Verified-Tweaks/tree/main
- https://github.com/BoringBoredom/PC-Optimization-Hub
- https://github.com/valleyofdoom/PC-Tuning
- https://docs.google.com/document/d/1c2-lUJq74wuYK1WrA_bIvgb89dUN0sj8-hO3vqmrau4/edit?tab=t.0

## Questionable / use with caution
- https://github.com/Hyyote/files-/tree/main
- https://github.com/shoober420/windows11-scripts/tree/main
- https://sites.google.com/view/melodystweaks/basictweaks

## Videos
- https://youtu.be/sbXzM60ad8I
- https://www.youtube.com/watch?v=x0BN608Sd3Q

## Tweaks / tuning resources
- Forum discussion (HPET / bcdedit tweaks):  
  https://www.techpowerup.com/forums/threads/revisiting-hpet-bcdedit-tweaks-what-are-your-timer-bench-results-and-settings.326187/page-5
- Savitarax (YouTube channel):  
  https://www.youtube.com/@Savitarax/videos
- Video: https://youtu.be/UFv4kkz__6I

## Question (Microsoft Answers)
- https://answers.microsoft.com/en-us/windows/forum/all/why-does-this-happen-in-24h2/7e8145b4-f56c-452f-8bba-7da58614d6f7

## “Crap-free Windows”
- AtlasOS: https://atlasos.net/

---

## TODO
- (Add items here)

---

## Commands / Notes
Enabling AL HRTF (writes to alsoft.ini):

```bat
ECHO Enabling AL HRTF...
ECHO hrtf ^= true > "%appdata%\alsoft.ini"
ECHO hrtf ^= true > "C:\ProgramData\alsoft.ini"
```