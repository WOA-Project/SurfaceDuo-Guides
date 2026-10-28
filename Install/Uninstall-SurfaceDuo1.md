# Uninstall Windows and revert your Surface Duo (1st Gen) to stock

This guide will help you go back to a normal Surface Duo, with Android™ only.

Just like you had it before installing Windows.

Android™ will have access to the whole memory back again.

Your data will be erased, please make backups if you need it before proceeding!

This guide works if you haven't broke anything else in the meantime.

If you broke anything, this guide wont help you and will likely make things worse.

Contact us instead for help!

## Files/Tools Needed

- A Surface Duo (1st Gen)
- [An Uninstall FFU file for your Surface Duo (1st Gen)](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/OEMEP_Uninstall.ffu)
- A Windows PC to flash the device

## Disclaimers

> [!IMPORTANT]
> **THIS WILL WIPE ALL YOUR ANDROID™ DATA**
>
> We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
>
> but this is **STILL IN PREVIEW** and things can go wrong.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

If you caused modifications to Android™ system partitions and are not knowingly using Custom Trusted Boot certificates or do not know what we're talking about here but flashed a dual boot image onto your device, you need to revert this. Please see the dual boot guide for assistance first and foremost. Otherwise below's steps will brick your device.

# Steps

## Make sure you have not done any dual boot guide!

If you have followed a guide to use dual boot, please first remove dual boot by following the uninstall section in the dual boot guide, this is important: [DualBoot](/Install/DualBoot.md)

## Acquiring all files

Acquire the Uninstall FFU file for Surface Duo (1st Gen):

[Uninstall FFU](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/OEMEP_Uninstall.ffu)

## Install WOA Device Manager

| Steps | Illustration |
|-|-|
| Visit WOA Device Manager in the Microsoft Store | <a href="https://apps.microsoft.com/detail/WOA%20Device%20Manager/9pf2xmfnsbmj?mode=direct"><img src="https://get.microsoft.com/images/en-us%20dark.svg" width="200"/></a> |
| Tap the View in Store button | <img align="right" width="425" alt="image"  src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/1be9c5fa-5434-4167-b23c-1899e0192134"> |
| Tap Install | <img align="right" width="425" alt="image"  src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/4ffe3b30-e8a7-44a4-a7a2-57e1f105a9ab"> |
| Wait til the installation is completed | <img align="right" width="425" alt="image"  src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/6c7ef3dd-13b3-4371-bae4-f6629a61cc71"> |
| And click open | <img align="right" width="425" alt="image"  src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/26e48e1b-96b8-4c87-a2a5-4d1e0049f7e9"> |
| WOA Device Manager should now open on your screen. | <img align="right" width="425" alt="Screenshot 2024-06-22 183133" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/ba7b4289-1c23-4138-9428-1d9e8c90af10"> |

Congratulations, you successfully installed WOA Device Manager.

## Getting to FFU Loader

> [!TIP]
> If you see no device listed, check for updates in Windows Update, you likely have a Driver Update pending so the phone is recognized, when you're good to go, you should see the following image below this notice.
> It is possible certain computers see no update offered (like Windows ARM64 Computers or other older machines with no functional Windows Update). If this is your case, we also provide Drivers for you to download
> at the following location, you will have to install them using Device Manager on your PC. [Download USB Drivers](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/USB-Drivers.zip)

| Steps | Illustration |
|-|-|
| Plug your device into your computer inside Android™ | <img align="right" width="425" alt="Screenshot 2024-06-22 183159" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/001215d0-4bbb-4ba1-839c-552890fbc1b7"> |
| Go into the Manual Mode Section of WOA Device Manager | <img align="right" width="425" alt="Screenshot 2024-06-22 183227" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/95732dc8-10c5-472f-b6ca-89c9ba8f0563"> |
| Click "Switch to Windows-mode" | <img align="right" width="425" alt="Screenshot 2024-06-22 183235" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/805dc2cc-0db2-472a-9f6d-7597b4336e77"> |
| When the device shows the //\ logo (Project Andromeda logo) on its screen, Press the Volume Up Key on the side of your device til you see something like shown below on screen: | <img align="right" width="425" alt="Surface Duo in FFU Loader mode" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/f35ba53d-70c6-41de-9cca-ad31368a35fb"> |
| WOA Device Manager will detect your device in UFP mode | <img align="right" width="425" alt="Screenshot 2024-06-22 183302" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/90c5d4a3-4b37-4486-8920-8b0e14e0b461"> |

> [!TIP]
> In case the PC complains the device was not found, try using an USB-2 port or cable that downgrades your connection to USB-2, there are known issues with the UEFI that prevent USB-3 from functioning properly at the moment, and will be addressed in a future update.

Congratulations, you're now in FFU Loader.

## Flashing the Uninstall FFU Image

| Steps | Illustration |
|-|-|
| Go to the Flash Section of WOA Device Manager | <img align="right" width="425" alt="Screenshot 2024-06-22 183326" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/6773ecbb-0de3-4cd4-9aa3-76ac02d7a273"> |
| Pick your FFU File, and click "Flash FFU Image" | <img align="right" width="425" alt="Screenshot 2024-06-22 183344" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/b6fd0499-0c34-410c-9e2d-25b331b7a2be"> |
| You should now see the device flashing on both your computer | <img align="right" width="425" alt="Screenshot 2024-06-22 183429" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/171d458f-5c89-4af8-86fd-06bfb59d4dd0"> |
| and on the device, wait til the process is complete. | <img align="right" width="425" alt="Surface Duo in FFU Loader mode, flashing" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/a0d8af6c-5b30-4afd-85d3-58249accde12"> |
| Wait til the process is finished, and you should be back into Android™ or a boot failure screen. | |

> [!TIP]
> If you are seeing a boot failure screen with as title "Android Recovery" and as description "Cannot load Android system.", see below section entitled "Factory Data Reset Android™"

<details>
  <summary>Factory Data Reset Android™ (Click to expand)</summary>
  <p>

If this is your first time flashing this FFU file, or you're flashing a different storage or layout configuration image, you will lose all of your Android™ data. Further more, you will also not have Android™ boot successfully.
If this isn't your case, feel free to ignore this section, Android™ should still boot fine.
If this is your case, when booting Android™, you will get notified Android™ cannot boot anymore. In this screen, you must select "Factory data reset" instead of "Try again" or else, Android™ will refuse to boot again.

You can skip ahead the below's "Resetting Android™ to restore all usable storage space" section alltogether and jump straight to the next one.

  </p>
</details>

## Resetting Android™ to restore all usable storage space

| Steps | Illustration |
|-|-|
| Assuming your Surface Duo is booted to Android™, plugged to your PC, Using the Microsoft Launcher, find the settings app | <img align="right" width="425" alt="A1 Android™ - Open Settings" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/36ef925c-fe98-4ec6-9861-c1037d8ced19"> |
| Open the Android™ Settings app | <img align="right" width="425" alt="A2 Android™ - Settings Opened" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/02b78630-d2b2-4211-abe1-c89255fe9bc6"> |
| Scroll down to the System section, and open it | |
| Open the Reset options section | |
| Tap on "Erase all data (factory reset)" | |
| Confirm by tapping on the bottom right "Erase all data" button. You do not have to erase downloaded SIMs (eSIMs) if asked. | |
| Android should now factory reset | |

- You should now be seeing the Android™ Out of Box Experience (OOBE). Setup your phone to confirm it works correctly if you need it.

![Android™ - OOBE](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/5f86cbbe-df08-4ba6-92aa-b7fd2a7f72b3)

- Once your phone is confirmed working, congratulations, you successfully uninstalled Windows from your device.

You may however want to also relock the bootloader of the device, please note that you cannot relock the bootloader of your device if you flashed a custom rom as well as installed Windows before, or modified the boot partition for dual boot, or other purposes. Please look into undoing such changes before proceeding forward.

## In order to relock the bootloader

Follow the [Restoring Bootloader](RestoringBootloader.md) Guide

---

_**© 2020-2026 The Duo WOA Authors**_

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

_**Limited emergency calling**_

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

_**Hello from Seattle (US), France, Italy.**_