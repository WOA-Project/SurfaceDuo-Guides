# Compatibility

## Windows Client

Surface Duo (1st Gen) and Surface Duo 2 currently supports the following Windows Client OS versions:

| Operating System                   | Build Number | Codebase/Semester        | Windows Display Driver Model | Windows Driver Framework | Surface Duo (1st Gen) Supported? | Surface Duo 2 Supported? | Notes for Surface Duo (1st Gen) | Notes for Surface Duo 2 |
|------------------------------------|--------------|--------------------------|------------------------------|--------------------------|----------------------------------|--------------------------|---------------------------------|-------------------------|
| Windows 10 Version 1709            | 16299        | Redstone 3               | WDDM 2.3                     | 1.23                     | ❌                               | ❌                      | While this version fully supports the SoC Core hardware (Timer, Interrupt Controller etc...), the WDF versions supported predate 2.25. Therefore, drivers built using newer WDF versions (like the current ones) will not run on this version without severe modifications. Versions higher fully work due to the "build on older, run on newer" principle. For more information, read [this documentation](https://learn.microsoft.com/en-us/windows-hardware/drivers/wdf/building-a-wdf-driver-for-multiple-versions-of-windows) on the subject. | This version of Windows does not support the System on Chip (SoC) |
| Windows 10 Version 1803            | 17134        | Redstone 4               | WDDM 2.4                     | 1.25                     | ⚠️                               | ❌                      | This version of Windows uses the Windows Display Driver Model version 2.4. The current GPU driver supports WDDM 2.6 as a strict minimum. So GPU acceleration, and both displays will not be working. Only the left display will be working thanks to the UEFI framebuffer support. Some issues are presents in regards to subsystems and cellular as well. | This version of Windows does not support the System on Chip (SoC) |
| Windows 10 Version 1809            | 17763        | Redstone 5/Calcium       | WDDM 2.5                     | 1.27                     | ⚠️                               | ❌                      | This version of Windows uses the Windows Display Driver Model version 2.5. The current GPU driver supports WDDM 2.6 as a strict minimum. So GPU acceleration, and both displays will not be working. Only the left display will be working thanks to the UEFI framebuffer support. Some issues are presents in regards to subsystems and cellular as well. | This version of Windows does not support the System on Chip (SoC) |
| Windows 10 Version 1903            | 18362        | Redstone 6/Titanium/19H1 | WDDM 2.6                     | 1.29                     | ⚠️                               | ❌                      | This version of Windows is not actively tested or developped against anymore and may suffer from some intermittent compatibility issues with newer Driver Releases. It is however meant to have the same hardware support as newer versions of Windows. It can also be used to reieve the ICan0 value to setup phone / cellular call binding on newer versions of Windows. | This version of Windows does not support the System on Chip (SoC) |
| Windows 10 Version 1909            | 18363        | Redstone 6/Vanadium/19H2 | WDDM 2.6                     | 1.29                     | ⚠️                               | ❌                      | This version of Windows is not actively tested or developped against anymore and may suffer from some intermittent compatibility issues with newer Driver Releases. It is however meant to have the same hardware support as newer versions of Windows. It can also be used to reieve the ICan0 value to setup phone / cellular call binding on newer versions of Windows. | This version of Windows does not support the System on Chip (SoC) |
| Windows 10 Version 2004            | 19041        | Vibranium                | WDDM 2.7                     | 1.31                     | ✅                               | ❌                      |                                 | This version of Windows does not support the System on Chip (SoC) |
| Windows 10 Version 20h2            | 19042        | Vibranium                | WDDM 2.7                     | 1.31                     | ✅                               | ❌                      |                                 | This version of Windows does not support the System on Chip (SoC) |
| Windows 10 Version 21h1            | 19043        | Vibranium                | WDDM 2.7                     | 1.31                     | ✅                               | ❌                      |                                 | This version of Windows does not support the System on Chip (SoC) |
| Windows 10 Version 21h2            | 19044        | Vibranium                | WDDM 2.7                     | 1.31                     | ✅                               | ❌                      |                                 | This version of Windows does not support the System on Chip (SoC) |
| Windows 11 Version 21h2            | 22000        | Cobalt                   | WDDM 3.0                     | 1.33                     | ✅                               | ❌                      |                                 | This version of Windows does not support the System on Chip (SoC) |
| Windows 10 Version 22h1            | 19045        | Vibranium                | WDDM 2.7                     | 1.31                     | ✅                               | ❌                      |                                 | This version of Windows does not support the System on Chip (SoC) |
| Windows 10 Version 22h2            | 19046        | Vibranium                | WDDM 2.7                     | 1.31                     | ✅                               | ❌                      |                                 | This version of Windows does not support the System on Chip (SoC) |
| Windows 11 Version 22h2            | 22621        | Nickel                   | WDDM 3.1                     | 1.33                     | ✅                               | ❌                      |                                 | This version of Windows does not support the System on Chip (SoC) |
| Windows 11 Version 23h1            | 22621        | Nickel                   | WDDM 3.1                     | 1.33                     | ✅                               | ❌                      |                                 | This version of Windows does not support the System on Chip (SoC) |
| Windows 11 Version 23h2            | 22631        | Nickel                   | WDDM 3.2                     | 1.33                     | ✅                               | ❌                      |                                 | This version of Windows does not support the System on Chip (SoC) |
| Windows vNext (Germanium Semester) | TBR          | Germanium                | WDDM vNext                   | WDF vNext                | ✅                               | ✅                      |                                 |                         |

❌: Not supported, important issues present

⚠️: Not supported, minor issues present, not actively maintained anymore

✅: Fully supported, known issues present but nothing impactful, actively maintained

---

It should be noted that development primarly is ongoing with the vNext release of Windows 11, and lower versions may be more broken than newer ones. Above table lists all Operating System versions ever released for ARM64 Processors. 1709, 1803 and 1809 are not supported due to being too old to support the Snapdragon™ 855 System on a Chip (SoC).

---

_**© 2020-2024 The Duo WOA Authors**_

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

_**Limited emergency calling**_

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

_**Hello from Seattle (US), France, Italy.**_