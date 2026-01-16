# PC Optimization & Tuning and so on... / Оптимизация и настройка ПК и не только...

This repository contains a collection of resources, scripts, and guides for optimizing Windows and tuning PC hardware.

Этот репозиторий содержит коллекцию ресурсов, скриптов и руководств по оптимизации Windows и настройке оборудования ПК.

---

## Verified & Researched Sources / Проверенные и изученные источники

The following repositories provide tested configuration guides and tweaks.

Следующие репозитории содержат проверенные руководства по конфигурации и твики.

* **GamingPCSetup:** https://github.com/djdallmann/GamingPCSetup
* **AlchemyTweaks (Verified):** https://github.com/AlchemyTweaks/Verified-Tweaks/tree/main
* **PC Optimization Hub:** https://github.com/BoringBoredom/PC-Optimization-Hub
* **ValleyOfDoom PC Tuning:** https://github.com/valleyofdoom/PC-Tuning
* **Google Docs Guide:** https://docs.google.com/document/d/1c2-lUJq74wuYK1WrA_bIvgb89dUN0sj8-hO3vqmrau4/edit?tab=t.0
* **Opendows Tweakers:** https://github.com/MarcoRavich/Opendows/blob/main/Tweakers.md#-

---

## Windows Debloating Tools / Инструменты для очистки Windows

Resources for removing telemetry and unnecessary bloatware.

Ресурсы для удаления телеметрии и ненужного предустановленного ПО.

* **AtlasOS (Modified ISO/Playbook):** https://atlasos.net/
* **ChrisTitusTech WinUtil:** https://github.com/ChrisTitusTech/winutil
* **RemoveWindowsAI:** https://github.com/zoicware/RemoveWindowsAI

---

## Experimental & Unverified / Экспериментальные и непроверенные

**Warning:** Use these resources with caution. They may contain unstable tweaks or aggressive modifications.

**Внимание:** Используйте эти ресурсы с осторожностью. Они могут содержать нестабильные твики или агрессивные модификации.

* **Hyyote Files:** https://github.com/Hyyote/files-/tree/main
* **Windows 11 Scripts (shoober420):** https://github.com/shoober420/windows11-scripts/tree/main
* **Melody's Tweaks:** https://sites.google.com/view/melodystweaks/basictweaks

---

## Multimedia & Discussions / Видео и обсуждения

Video guides and forum discussions regarding HPET, latency, and general tuning.

Видеогайды и обсуждения на форумах касательно HPET, задержек и общей настройки.

### Videos / Видео
* https://youtu.be/sbXzM60ad8I
* https://www.youtube.com/watch?v=x0BN608Sd3Q
* https://youtu.be/UFv4kkz__6I
* **Savitarax Channel:** https://www.youtube.com/@Savitarax/videos

### Forum Discussions / Обсуждения на форумах
* **TechPowerUp (HPET/bcdedit benchmarks):** https://www.techpowerup.com/forums/threads/revisiting-hpet-bcdedit-tweaks-what-are-your-timer-bench-results-and-settings.326187/page-5

---

## Troubleshooting / Устранение неполадок

Specific fixes for known Windows issues.

Специфические исправления известных проблем Windows.

* **Windows 11 24H2 Issues:** https://answers.microsoft.com/en-us/windows/forum/all/why-does-this-happen-in-24h2/7e8145b4-f56c-452f-8bba-7da58614d6f7

---

## Configuration Commands / Команды конфигурации

### Enable AL HRTF (OpenAL Soft) / Включение AL HRTF
Writes configuration to `alsoft.ini`.
Записывает конфигурацию в `alsoft.ini`.

```bat
ECHO Enabling AL HRTF...
ECHO hrtf ^= true > "%appdata%\alsoft.ini"
ECHO hrtf ^= true > "C:\ProgramData\alsoft.ini"