# 🛠️ **Windows Optimization Tools / Инструменты для оптимизации Windows**  

## 🔵 **Blue Screen Analyzers / Анализаторы синих экранов**  
- [**BlueScreenView (NirSoft)**](https://www.nirsoft.net/utils/bluescreenview-x64.zip)  
  View minidump files from Windows BSOD crashes.  
  Просмотр файлов minidump из синих экранов Windows.  

---

## 📦 **File Compression Tools / Утилиты сжатия файлов**  
- [**CompactGUI**](https://github.com/IridiumIO/CompactGUI/releases/)  
  Reduce game/file sizes via NTFS compression (GUI for `compact.exe`).  
  Уменьшение размеров игр/файлов через сжатие NTFS (графический интерфейс).  

---

## 🚫 **Debloating & Privacy / Удаление телеметрии**  
- [**Win11Debloat**](https://github.com/Raphire/Win11Debloat)  
  Remove telemetry/bloatware from Windows 10/11.  
  Удаление телеметрии и ненужных компонентов Windows.  
- [**O&O ShutUp10++**](https://www.oo-software.com/en/shutup10)  
  Disable 50+ privacy-invasive Windows features.  
  Отключение 50+ функций слежения в Windows.  
- [**W10Privacy**](https://www.w10privacy.de/english-home/)  
  GUI to manage 100+ Windows privacy settings.  
  Графический интерфейс для настроек конфиденциальности.  
 - **Запускать от имени администратора, удаляет "шпионские" функции и задания**
   [telemetrystop.cmd](https://github.com/AndrewMarchukov/useful-things/blob/main/telemetrystop.cmd)

---

## 🔑 **Windows Activation / Активация Windows**  
- [**MAS (Microsoft Activation Scripts)**](https://github.com/massgravel/Microsoft-Activation-Scripts)  
  HWID/KMS activation for Windows/Office (used even by MS support).  
  Активация через HWID/KMS (используется даже поддержкой Microsoft).  

---

## ⚙️ **System Optimizers / Оптимизация системы**  
- [**Chris Titus Tech's WinUtil**](https://github.com/ChrisTitusTech/winutil)  
  All-in-one tweaking/optimization tool.  
  Комплексная оптимизация Windows.  
- [**Winhance**](https://github.com/memstechtips/Winhance)  
  PowerShell GUI for Windows customization.  
  Графический интерфейс для тонкой настройки.  
- [**CrapFixer**](https://github.com/builtbybel/CrapFixer)  
  Removes preinstalled Windows "junk".  
  Удаление предустановленного "мусора".  

---

## 🎛️ **Power Management / Управление питанием**  
- [**AutoPowerOptionsOK**](https://softwareok.com/?seite=Microsoft/AutoPowerOptionsOK)  
  Auto-sleep PC on inactivity + power plan tweaks.  
  Авторежим сна при бездействии и настройки электропитания.  

---

## 🧰 **Bonus Utilities / Дополнительные утилиты**  
- [**Microsoft PowerToys**](https://remontka.pro/microsoft-powertoys-windows-10/)  
  FancyZones, Awake, Color Picker, and other productivity tools.  
  Набор полезных инструментов для Windows (управление окнами, пипетка и др.).  
- [**GTweak**](https://github.com/Greedeks/GTweak)  
  Preconfigured optimizations for Windows 10/11.  
  Готовые настройки для максимальной производительности.  

#### Unnecessary app

```get-appxpackage -allusers Microsoft.PowerAutomateDesktop | remove-appxpackage -allusers```

#### BIOS shortcut

Create yourself a shortcut instead with right click > new > shortcut

C:\Windows\System32\shutdown.exe /r /fw /T 5

/r - restart
/fw - will drop you to EUFI
/T (number of seconds after which restart will trigger)
