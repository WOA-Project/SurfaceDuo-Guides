# Flashing a Full Flash Update Image (.FFU) on Surface Duo

Table of Contents:

* [Flashing a Full Flash Update Image (.FFU) on Surface Duo](#flashing-a-full-flash-update-image-ffu-on-surface-duo)
   * [Files/Tools Needed 📃](#filestools-needed-)
   * [What you will get 🛒](#what-you-will-get-)
* [Steps 🛠️](#steps-️)
   * [Unlocking the Bootloader](#unlocking-the-bootloader)
   * [Acquiring all files](#acquiring-all-files)
   * [Getting to FFU Loader](#getting-to-ffu-loader)
   * [Flashing the Windows FFU Image](#flashing-the-windows-ffu-image)
   * [Reset Android™](#reset-android)
   * [Boot Windows 🚀](#boot-windows-)
   * [Boot Windows again after initial installation](#boot-windows-again-after-initial-installation)

## Files/Tools Needed 📃

- A Surface Duo (1st Gen) or Surface Duo 2
- [An FFU file for your Surface Duo](https://fullflash.pvabel.net/DuoWOA/)
- A Windows PC to flash the device

## Disclaimers

> [!WARNING]
> - If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.

> [!IMPORTANT]
> **THIS WILL WIPE ALL YOUR ANDROID™ DATA AND WINDOWS DATA!**
>
> We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
>
> but this is **STILL IN PREVIEW** and things can go wrong.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

## What you will get 🛒

You will end up with both Android™ and Windows on your Surface Duo. Android™ and Windows will both split the internal storage.

Android™ will boot normally, and you will have to use a PC to boot Windows when needed, unless you create a dual boot image (explained later).

# Steps 🛠️

## Unlocking the Bootloader

If not already done, please first proceed with the [Unlocking the Bootloader](/Install/UnlockingBootloader.md)) guide for Surface Duo. Come back once you're done. If you already followed this guide, please skip the unlocking section.

## Acquiring all files

Here's how to acquire an FFU file for Surface Duo:

[FFU Files](https://fullflash.pvabel.net/DuoWOA/)

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
> If you see no device deected in WOA Device Manaer, check for updates in Windows Update, you likely have a Driver Update pending so the phone is recognized, when you're good to go, you should see the following image below this notice.
> It is possible certain computers see no update offered (like Windows ARM64 Computers or other older machines with no functional Windows Update). If this is your case, we also provide Drivers for you to download
> at the following location, you will have to install them using Device Manager on your PC. [Download USB Drivers](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/USB-Drivers.zip)

| Steps | Illustration |
|-|-|
| Plug your device into your computer inside Android™ | <img align="right" width="425" alt="Screenshot 2024-06-22 183159" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/001215d0-4bbb-4ba1-839c-552890fbc1b7"> |
| Go into the Switch Mode Section of WOA Device Manager | <img align="right" width="425" alt="Screenshot 2024-06-22 183227" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/95732dc8-10c5-472f-b6ca-89c9ba8f0563"> |
| Click "Switch to Windows-mode" | <img align="right" width="425" alt="Screenshot 2024-06-22 183235" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/805dc2cc-0db2-472a-9f6d-7597b4336e77"> |
| When the device shows the Andromeda Cat with Green Flag pole on its screen, Press the Volume Up Key on the side of your device til you see something like shown below on screen: | <img align="right" width="425" alt="Surface Duo in FFU Loader mode" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/f35ba53d-70c6-41de-9cca-ad31368a35fb"> |
| WOA Device Manager will detect your device in UFP mode | <img align="right" width="425" alt="Screenshot 2024-06-22 183302" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/90c5d4a3-4b37-4486-8920-8b0e14e0b461"> |

> [!TIP]
> In case the PC complains the device was not found, try using an USB-2 port or cable that downgrades your connection to USB-2, there are known issues with the UEFI that prevent USB-3 from functioning properly at the moment, and will be addressed in a future update.

Congratulations, you're now in FFU Loader.

## Flashing the Windows FFU Image

| Steps | Illustration |
|-|-|
| Go to the Flash Section of WOA Device Manager | <img align="right" width="425" alt="Screenshot 2024-06-22 183326" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/6773ecbb-0de3-4cd4-9aa3-76ac02d7a273"> |
| Pick your FFU File, and click "Flash FFU Image" | <img align="right" width="425" alt="Screenshot 2024-06-22 183344" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/b6fd0499-0c34-410c-9e2d-25b331b7a2be"> |
| You should now see the device flashing on both your computer | <img align="right" width="425" alt="Screenshot 2024-06-22 183429" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/171d458f-5c89-4af8-86fd-06bfb59d4dd0"> |
| and on the device, wait til the process is complete. | <img align="right" width="425" alt="Surface Duo in FFU Loader mode, flashing" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/a0d8af6c-5b30-4afd-85d3-58249accde12"> |
| Wait til the process is finished, and you should be back into Android™ or a boot failure screen. | |

> [!TIP]
> If you are seeing a boot failure option, see below section entitled "Reset Android™"

## Reset Android™

If this is your first time flashing this FFU file, or you're flashing a different storage or layout configuration image, you will lose all of your Android™ data. Further more, you will also not have Android boot successfully.
If this isn't your case, feel free to ignore this section, Android™ should still boot fine.
If this is your case, when booting Android™, you will get notified Android cannot boot anymore. In this screen, you must select "Factory Reset" instead of "Try again" or else, Android™ will refuse to boot again.

You should now be seeing the Android™ Out of Box Experience (OOBE).

| Steps | Illustration |
|-|-|
| Setup your phone to confirm it works correctly. | <img align="right" width="425" alt="Android™ - OOBE" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/5f86cbbe-df08-4ba6-92aa-b7fd2a7f72b3"> |
| Assuming your Surface Duo is booted to Android™, plugged to your PC, Using the Microsoft Launcher, find the settings app | <img align="right" width="425" alt="A1 Android™ - Open Settings" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/36ef925c-fe98-4ec6-9861-c1037d8ced19"> |
| Open the Android™ Settings app | <img align="right" width="425" alt="A2 Android™ - Settings Opened" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/02b78630-d2b2-4211-abe1-c89255fe9bc6"> |
| Scroll down to the about section, and open it | <img align="right" width="425" alt="A3 Android™ - Settings About" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/0dad0ac3-21f3-42fd-a02c-78e9eb399118"> |
| Scroll all the way down til you see the Build Number field | <img align="right" width="425" alt="A4 Android™ - Settings About Down" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/afac2404-9624-4298-9785-b6a21bc31699"> |
| Press the Build number field 7 times consecutively, you should first start to see a popup after 3 taps | <img align="right" width="425" alt="A5 Android™ - Settings About Down Tap Dev" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/b850bef7-2938-47a0-b781-c54178e3cf7d"> |
| Once done tapping 7 times, you should be seeing this popup instead | <img align="right" width="425" alt="A6 Android™ - Settings About Down Tap Dev Done" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/8afef456-00a4-41e7-9653-c91a901e16c1"> |
| Now go to the System section, you should see a new Developer options section like shown below | <img align="right" width="425" alt="A7 Android™ - Settings System with Dev" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/a2de44f2-b492-450a-830a-5e7141e232b7"> |
| Go to the Developer options section | <img align="right" width="425" alt="Android™ Settings System Dev Options" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/ffbbcee9-98ab-4b83-8eaa-57487c1c1cf0"> |
| Scroll all the way down til you see the "USB debugging" option | <img align="right" width="425" alt="Android™ Settings - Dev - Debugging Option" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/3847fdcb-c19c-4c5d-aa4c-00a60e85c2b0"> |
| And turn on the "USB debugging" option | <img align="right" width="425" alt="Android™ Settings - Dev - Debugging Option Confirmation" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/60b52b98-8c6a-4845-833d-470378206fb2"> |

## Boot Windows 🚀

We are ready to boot for the first time!

| Steps | Illustration |
|-|-|
| Inside WOA Device Manager, go to switch mode | <img align="right" width="425" alt="Screenshot 2024-06-22 183227" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/a5fb15b1-6a43-45b5-b440-df243b076b9c"> |
| and select "Switch to Windows-mode". | <img align="right" width="425" alt="Screenshot 2024-06-22 183235" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/bb4f618a-fa7c-4874-8dd6-f87181753be6"> | 

This step above will be needed every time you will want to boot Windows and needs to be done from the Bootloader mode.

If you did everything right, Windows will now boot! Enjoy!

Let Windows set itself up, and come back once you're on the Windows Desktop on your Surface Duo

> [!NOTE]
> If the Touch keyboard won't show up in OOBE, touch somewhere else (to let the text box loose focus) and then touch into the text box again. As an alternative, you can use the On-Screen Keyboard.

> [!NOTE]
> If you get a BSOD (bugcheck screen) during initial setup, you can try erasing both the esp and win partitions using "fastboot erase esp" and "fastboot erase win", and reflash the FFU file, then it should work. This issue will get fixed in later FFU revisions.

> [!NOTE]
> On second boot of Windows, you may be seeing "Just a moment" on both displays and then a black screen. To get out of this, unplug your USB-C cable and plug it back in.

## Boot Windows again after initial installation

You'll have two methods of booting Windows.

- Manual booting with a PC
    - Pros: You can freely update Android™
    - Cons: You will need a PC to boot to Windows

- Enabling Dual Boot
    - Pros: You'll be able to boot Windows directly from the device
    - Cons: Every time you update Android™, you'll have to follow [this guide](/Install/DualBoot.md)

In case you want the dual boot option, then follow [this guide](/Install/DualBoot.md)

<details>
  <summary>In case you want to manually boot each time: (<b>Click to expand</b>)</summary>
  <p>

| Steps | Illustration |
|-|-|
| Plug your phone into your computer, inside Android™ | <img align="right" width="425" alt="Screenshot 2024-06-22 183159" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/f66dfeff-f7c0-4c2f-a83a-ad103eae2003"> |
| Inside WOA Device Manager, go to switch mode | <img align="right" width="425" alt="Screenshot 2024-06-22 183227" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/a5fb15b1-6a43-45b5-b440-df243b076b9c"> |
| and select "Switch to Windows-mode". | <img align="right" width="425" alt="Screenshot 2024-06-22 183235" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/bb4f618a-fa7c-4874-8dd6-f87181753be6"> | 

This step above will be needed every time you will want to boot Windows and needs to be done from the Bootloader mode.

If you did everything right, Windows will now boot! Enjoy!

  </p>
</details>

---

_**© 2020-2024 The Duo WOA Authors**_

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

_**Limited emergency calling**_

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

_**Hello from Seattle (US), France, Italy.**_
