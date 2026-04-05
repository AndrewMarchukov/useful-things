# Audio Optimization & Tools / Аудио оптимизация и инструменты

This repository contains tools and guides for 3D audio virtualization, microphone noise suppression, and latency reduction.

Этот репозиторий содержит инструменты и руководства по виртуализации 3D звука, шумоподавлению микрофона и уменьшению задержек.

---

## 3D Audio & Virtualization / 3D звук и виртуализация

Tools for enabling virtual surround sound and modded audio drivers.

Инструменты для включения виртуального объемного звука и модифицированные аудиодрайверы.

* **HeSuvi (Free 3D Audio):** https://sourceforge.net/projects/hesuvi/
* **Virtual Sound Profiles Database:** https://airtable.com/appayGNkn3nSuXkaz/shruimhjdSakUPg2m/tbloLjoZKWJDnLtTc
* **AAF Optimus (Modded Realtek Drivers):** https://github.com/AAFOptimus/AAFFamilyDCHAudio/releases
* **AAF Optimus Discussion:** https://www.techpowerup.com/forums/threads/aaf-optimus-modded-driver-for-windows-10-windows-11-only-for-realtek-hdaudio-chips.327318/

---

## Equalization & Calibration / Эквалайзеры и калибровка

Resources for headphone calibration to achieve neutral sound. Use the **GraphicEQ** format for HeSuvi.

Ресурсы для калибровки наушников для достижения идеального звучания основанное на исследованиях Harman. Используйте формат **GraphicEQ** для HeSuvi.

* **AutoEq Results:** https://github.com/jaakkopasanen/AutoEq/tree/master/results
* **Pragmaticaudio:** https://www.pragmaticaudio.com/headphones/

---

## Microphone Noise Suppression / Шумоподавление микрофона

Software and guides for removing background noise from microphone input for free.

Программное обеспечение и руководства для бесплатного удаления фонового шума с микрофона.

* **Guide (Medium):** https://medium.com/@bssankaran/free-and-open-source-software-noise-cancelling-for-working-from-home-edb1b4e9764e
* **Noise Suppression Plugin (Werman):** https://github.com/werman/noise-suppression-for-voice
* **Equalizer APO:** https://equalizerapo.com/download.html

---

## Volume Control & Protection / Контроль громкости и защита

Utilities to limit maximum volume output to prevent sudden loud noises.

Утилиты для ограничения максимальной громкости во избежание резких громких звуков.

* **Sound Lock:** https://www.3appes.com/sound-lock/
    * Sets a specific volume limit. Unexpectedly loud sounds (e.g., game intros) will not exceed the set comfortable threshold.
    * Устанавливает определенный предел громкости. Неожиданно громкие звуки (например, заставки игр) не превысят установленный комфортный порог.

---

## Latency & System Tuning / Задержка и системная настройка

Fixes for audio latency and process prioritization.

Исправления задержки звука и приоритезация процессов.

* **Low Audio Latency:** https://github.com/spddl/LowAudioLatency#readme
* **Audiodg.exe Configuration Discussion:** https://www.reddit.com/r/PowerShell/comments/p0wma3/where_to_begin_change_settings_in_audiodgexe/

### Audiodg Priority / Приоритет Audiodg
Set `audiodg.exe` to High or Realtime priority using Process Lasso or the registry to reduce stuttering.
Установите для `audiodg.exe` высокий приоритет или приоритет реального времени с помощью Process Lasso или реестра для уменьшения заиканий звука.