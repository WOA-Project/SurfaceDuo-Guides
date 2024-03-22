# Compatibility

## Windows Client

Surface Duo (1st Gen) and Surface Duo 2 currently supports the following Windows Client OS versions:

| Operating System                                                          | Surface Duo (1st Gen) Supported? | Surface Duo 2 Supported? |
|---------------------------------------------------------------------------|----------------------------------|--------------------------|
| Windows 10 Build 16299 (1709) (Redstone 3)                                | ❌ While this version fully supports the SoC Core hardware (Timer, Interrupt Controller etc...), the WDF versions supported predate 2.25. Therefore, drivers built using newer WDF versions (like the current ones) will not run on this version without severe modifications. Versions higher fully work due to the "build on older, run on newer" principle. For more information, read [this documentation](https://learn.microsoft.com/en-us/windows-hardware/drivers/wdf/building-a-wdf-driver-for-multiple-versions-of-windows) on the subject. | ❌                      |
| Windows 10 Build 17134 (1803) (Redstone 4)                                | ⚠️ This version of Windows uses the Windows Display Driver Model version 2.3. The current GPU driver supports WDDM 2.6 as a strict minimum. So GPU acceleration, and both displays will not be working. Only the left display will be working thanks to the UEFI framebuffer support. Some issues are presents in regards to subsystems and cellular as well. | ❌                      |
| Windows 10 Build 17763 (1809) (Calcium Semester)                          | ⚠️ This version of Windows uses the Windows Display Driver Model version 2.3. The current GPU driver supports WDDM 2.6 as a strict minimum. So GPU acceleration, and both displays will not be working. Only the left display will be working thanks to the UEFI framebuffer support. Some issues are presents in regards to subsystems and cellular as well. | ❌                      |
| Windows 10 Build 18362 (1903) (Titanium Semester)                         | ⚠️ This version of Windows is not actively tested or developped against anymore and may suffer from some intermittent compatibility issues with newer Driver Releases. It is however meant to have the same hardware support as newer versions of Windows. It can also be used to reieve the ICan0 value to setup phone / cellular call binding on newer versions of Windows. | ❌                      |
| Windows 10 Build 18363 (1909) (Vanadium Semester)                         | ⚠️ This version of Windows is not actively tested or developped against anymore and may suffer from some intermittent compatibility issues with newer Driver Releases. It is however meant to have the same hardware support as newer versions of Windows. It can also be used to reieve the ICan0 value to setup phone / cellular call binding on newer versions of Windows. | ❌                      |
| Windows 10 Build 19041 (2004) (Vibranium Semester)                        | ✅                               | ❌                      |
| Windows 10 Build 19042 (20h2) (Vibranium Semester)                        | ✅                               | ❌                      |
| Windows 10 Build 19043 (21h1) (Vibranium Semester)                        | ✅                               | ❌                      |
| Windows 10 Build 19044 (21h2) (Vibranium Semester)                        | ✅                               | ❌                      |
| Windows 10 Build 19045 (22h1) (Vibranium Semester)                        | ✅                               | ❌                      |
| Windows 10 Build 19046 (22h2) (Vibranium Semester)                        | ✅                               | ❌                      |
| Windows 11 Build 22000 (21h2) (Cobalt Semester)                           | ✅                               | ❌                      |
| Windows 11 Build 22621 (22h2) (Nickel Semester)                           | ✅                               | ❌                      |
| Windows 11 Build 22621 (23h1) (Nickel Semester)                           | ✅                               | ❌                      |
| Windows 11 Build 22631 (23h2) (Nickel Semester)                           | ✅                               | ❌                      |
| Windows vNext (Germanium Semester)                                        | ✅                               | ✅                      |

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