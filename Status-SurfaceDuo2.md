# Status

## Surface Duo 2

### Keep up with the development in real time

Most updates are given first and foremost via our dedicated Announcement Telegram Channel. We try our best to also announce things elsewhere, but telegram remains our primary way of interfacing with the community at the moment. You can find the channel at https://t.me/DuoWOA_Announcements

### Notes about the Development Schedule

__Note: This note is provided for informational purposes only, it does not in any way represent any commitment from any entity working towards the development of the Windows port on Surface Duo and does not mean that all functionality will be available or the development will ever finish, you should not buy the device for the sole purpose of using Windows on it with hopes of it eventually being fully functional or having XYZ hardware feature working in the supposed future. What is available today is what should be considered as the most you can get. Purchase with this in mind, and don't assume we will get everything working. We may, but don't impulse buy with this thought. In either case, we cannot be taken responsible nor accountable for functionality we never promised to you. The device is sold as a fully working Android™ Device, not fully working Windows device from Microsoft.__

The development for the Windows Port is currently scheduled as follows:

- ~~Milestone #0: Early UEFI/OS bring up, proof of concept~~ Completed!
- Milestone #1: SoC hardware bringup in Windows OS, end goal is to have all hardware blocks/components of the SoC in a functional or communicating state by the end of the milestone, but not have it interface with the OS if it isn't already done. **In progress!**
- Milestone #2: Bug fixes, this is where we will fix major issues like crashes, etc
- Milestone #3: Calibration/Tuning, calibrate everything to work as it should be.
- Milestone #4: To be defined?

_No ETA will be provided for **any** of these development phases_

---

| Feature                | Description                                                                                                               | Working state |
|------------------------|---------------------------------------------------------------------------------------------------------------------------|-----------------|
| ⌨️ Side buttons        |                                                                                                                           | ✅             |
| 🌡️ Thermal sensors     |                                                                                                                           | ✅             |
| 💤 Modern Standby      |                                                                                                                           | ✅             |
| 💻 Lid Hall sensor     |                                                                                                                           | ✅             |
| 📦 UFS                 |                                                                                                                           | ✅             |
| 📲 Left Display Panel  |                                                                                                                           | ✅             |
| 🔋 Battery 1           |                                                                                                                           | ❌ (Errata with latest update) |
| 🔋 Battery 2           |                                                                                                                           | ❌ (Errata with latest update) |
| 🔌 Charger             |                                                                                                                           | ❌ (Errata with latest update) |
| 🪵 USB C               |                                                                                                                           | ❌ (Errata with latest update) |
| ✏️ Left Pen Digitizer  | Requires disabling one of the Touch Pen processors for now because the GPU driver is unavailable (requires Windows vNext) | ⚠️             |
| ✏️ Right Pen Digitizer | Requires disabling one of the Touch Pen processors for now because the GPU driver is unavailable (requires Windows vNext) | ⚠️             |
| 👆 Left Multi Touch    | Requires disabling one of the Touch Pen processors for now because the GPU driver is unavailable (requires Windows vNext) | ⚠️             |
| 👆 Right Multi Touch   | Requires disabling one of the Touch Pen processors for now because the GPU driver is unavailable (requires Windows vNext) | ⚠️             |
| 🧭 Sensors             | Not all sensors are available                                                                                             | ❌ (Errata with latest update) |
| 🧮 SoC Cores           | Prime core frequency isn't scaled up                                                                                      | ⚠️             |
| ♋ Cellular Calls      | Requires Modem Processor Subsystem                                                                                        | ❌             |
| ♋ Cellular Data       | Requires Modem Processor Subsystem                                                                                        | ❌             |
| ♋ Cellular eSIM       | Requires Modem Processor Subsystem                                                                                        | ❌             |
| ♋ Cellular Texts      | Requires Modem Processor Subsystem                                                                                        | ❌             |
| ♋ Cellular VoLTE      | Requires Modem Processor Subsystem                                                                                        | ❌             |
| ♋ WiFi                | Requires PCIe                                                                                                             | ❌             |
| 🎆 GPU                 | Requires Clock Controller fixes                                                                                           | ❌             |
| 🏷️ NFC                 | Requires Secure NFC Applet Interface                                                                                      | ❌             |
| 📌 GPS                 | Requires Modem Processor Subsystem                                                                                        | ❌             |
| 📲 Right Display Panel | Requires GPU                                                                                                              | ❌             |
| 📳 Vibration motor     | Requires PMIC Driver for Haptics                                                                                          | ❌             |
| 📸 Camera Flash        | Requires Camera Subsystem                                                                                                 | ❌             |
| 📸 Camera Sensors      | Requires Camera Subsystem                                                                                                 | ❌             |
| 📸 ToF Sensor          | Requires Camera Subsystem                                                                                                 | ❌             |
| 📺 HDMI / DP out       | Requires GPU                                                                                                              | ❌             |
| 📽️ Miracast            | Requires GPU and requires WiFi                                                                                            | ❌             |
| 🔊 Audio               | Requires Board Database file and Speaker Ic driver                                                                        | ❌             |
| 🔵 Bluetooth           | Requires Clock Controller fixes                                                                                           | ❌             |
| 🧬 Fingerprint scanner | Requires Secure FPC Applet Interface                                                                                      | ❌             |

## Surface Accessory Compatibility

### ✏️ Surface Pens

| Name                    | Model | Supported? | Firmware Updatable? | Pairable?       | Auto Pairable? | Pressure Sensitivity | Tilt Sensitivity | Hover | Eraser         | Side Button | Secondary Side Button | Zero force inking | Pressure Configurable? | Tactile signals | Notes |
|-------------------------|-------|------------|---------------------|-----------------|----------------|----------------------|------------------|-------|----------------|-------------|-----------------------|-------------------|------------------------|-----------------|-------|
| Surface Pen V2          | 1616  | ✅          | ❌                   | ✅               | ❌              | 256 levels           | Not applicable   | ✅     | Not applicable | ✅           | ✅                     | ❌                 | ✅ (Surface App)        | Not applicable  | N/A   |
| Surface Pen V3          | 1710  | ✅          | ❌                   | ✅               | ❌              | 4096 levels          | Not applicable   | ✅     | ✅              | ✅           | Not applicable        | ❌                 | ✅ (Surface App)        | Not applicable  | N/A   |
| Surface Pen V4          | 1776  | ✅          | ✅                   | ✅               | ✅              | 4096 levels          | 1024             | ✅     | ✅              | ✅           | Not applicable        | ❌                 | ✅ (Surface App)        | Not applicable  | N/A   |
| Surface Slim Pen        | 1853  | ✅          | ✅                   | ✅               | ✅              | 4096 levels          | 1024             | ✅     | ✅              | ✅           | Not applicable        | ❌                 | ✅ (Surface App)        | Not applicable  | N/A   |
| Surface Slim Pen 2      | 1962  | ✅          | ✅                   | ✅               | ✅              | 4096 levels          | 1024             | ✅     | ✅              | ✅           | Not applicable        | ✅                 | ✅ (Surface App)        | ✅               | N/A   |
| Surface Hub 2 Pen       | 1865  | ✅          | ✅                   | ✅               | ✅              | 4096 levels          | 1024             | ✅     | ✅              | ✅           | Not applicable        | ✅                 | ✅ (Surface App)        | Not applicable  | N/A   |
| Surface Classroom Pen   | 1896/NWH-00001  | ✅          | Not applicable      | Not applicable  | Not applicable | 1024 levels          | Not applicable   | ✅     | Not applicable | ✅           | ✅                     | ❌                 | ✅ (Surface App)        | Not applicable  | N/A   |
| Surface Classroom Pen 2 | 1896/8U3-00001  | ✅          | Not applicable      | Not applicable  | Not applicable | 4096 levels          | Not applicable   | ✅     | Not applicable | ✅           | ✅                     | ❌                 | ✅ (Surface App)        | Not applicable  | N/A   |

The following Surface Pens are not compatible due to their use of a different technology than N-Trig:

- Surface Pro Pen (Original Pen Launched with Surface Pro (1st Gen) and Surface Pro 2) (5PT-00001)
- Surface Hub Pen (Original Pen Launched with Surface Hub (1st Gen)) (Model 1640)

### Others

| Accessory Model                   | Description                                                                                                    | Working state |
|-----------------------------------|----------------------------------------------------------------------------------------------------------------|---------------|
| 🔌 Surface Slim Pen Charger       | Firmware Updates available within Windows (Unlike in Android) (Can be used to enable charging Surface Slim Pen 2 or newer pens on outdated charging cradles), Automatic Bluetooth Pairing, Automatic Device wakeup on pen removal from the cradle. | ✅           |
| 🛞 Surface Dial                   | No support for on screen radial ui yet.                                                                        | ✅           |
| 🎧 Surface USB-C Audio Adapter    |                                                                                                                | ✅           |
| 🅿️ Surface Thunderbolt 4 Dock     | No thunderbolt 4 support (unsupported by the hardware itself), USB 3 supported, Firmware updates available in the Surface App, Display out not functional due to USB C Video out not being functional. | ✅           |
| 🅿️ Microsoft HD500 Continuum Dock | Untested, Display out not functional due to USB C Video out not being functional.                              | ❓           |
| 🧳 Surface Travel Hub             | USB 3 supported, Firmware updates available via drivers, Display out not functional due to USB C Video out not being functional. | ✅           |
| 🔈 Microsoft Audio Dock           | USB 3 supported, Firmware updates available via drivers, Display out not functional due to USB C Video out not being functional. | ✅           |
| 📔 Surface Pen Cover              |                                                                                                                | ❌           |
| 🔈 Microsoft Modern USB-C Speaker | Untested                                                                                                       | ❓           |
| 📺 Microsoft Presenter+           | Untested                                                                                                       | ❓           |

---

_**© 2020-2026 The Duo WOA Authors**_

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

_**Limited emergency calling**_

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

_**Hello from Seattle (US), France, Italy.**_
