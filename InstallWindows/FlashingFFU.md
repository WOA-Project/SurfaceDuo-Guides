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

- You will need the following files from the [BSP Release page](https://github.com/WOA-Project/SurfaceDuo-Releases/releases/latest):

UEFI Image:

| File Name                              | Target Device         |
|----------------------------------------|-----------------------|
| Surface.Duo.1st.Gen.UEFI.Fast.Boot.zip | Surface Duo (1st Gen) |
| Surface.Duo.2.UEFI.Fast.Boot.zip       | Surface Duo 2         |

- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- [FFU Tools](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/FFU-Loader-Tools.zip)
- An FFU file for Surface Duo
- A Windows PC to flash the device

## Disclaimers

> [!WARNING]
> - If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.
> - Do not run all commands at once.
> - Do not commit *any* typo with *any* commands.
> - Be familiar with command line interfaces.

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

If not already done, please first proceed with the [Unlocking the Bootloader](UnlockingBootloader.md) guide for Surface Duo. Come back once you're done. If you already followed this guide, please skip the unlocking section.

## Acquiring all files

Here's how to acquire an FFU file and the matching UEFI image for Surface Duo:

### Surface Duo (1st Gen)

UEFI files:
- [Fast Boot](https://github.com/WOA-Project/SurfaceDuo-Releases/releases/download/2404.03C/Surface.Duo.1st.Gen.UEFI-v2406.36C.Fast.Boot.zip)
- [Dual Boot for FW 2022.902.48 (Latest OTA for Surface Duo (1st Gen) devices)](https://github.com/WOA-Project/SurfaceDuo-Releases/releases/download/2404.03C/Surface.Duo.1st.Gen.UEFI-v2406.36C.Dual.Boot.zip)
- [FD for making your own Dual Boot Image](https://github.com/WOA-Project/SurfaceDuo-Releases/releases/download/2404.03C/Surface.Duo.1st.Gen.UEFI-v2406.36C.FD.for.making.your.own.Dual.Boot.Image.zip)

FFU files:
<table>
<tr>
<td>FFU File</td>
<td>OS Version</td>
<td>Notes</td>
</tr>
<tr>
<td>
For 128GB variants

[OEMEP_128GB_HalfSplit.ffu](https://fullflash.pvabel.net/DuoWOA/v2406.36/OEMEP_128GB_HalfSplit.ffu)

Size: 6.54 GB

SHA1: `4DAC5BDF3CEAC91CF6CEC837C9E62124B294652E`
</td>
<td>Windows 11 Version 24H2 (26100.2) (en-US)</td>
<td><details>

Assumed Compatibility with 256gb variants (may have issues but should work, if issues arise we're not responsible and you should be able to recover either way, the main issue is more the split being 64(Windows)/192(Android) than anything else!).

1) After "Getting Ready" boot, on the second boot, the device may show a black screen, if this happens, press the power button once and it will continue to oobe after a minute. Be patient and don't press it more than once.
</details></td>
</tr>
<tr>
<td>
For 256GB variants

[OEMEP_256GB_HalfSplit.ffu](https://fullflash.pvabel.net/DuoWOA/v2406.36/OEMEP_256GB_HalfSplit.ffu)

Size: 6.48 GB

SHA1: `03823926295BCD8E0F62B450BAAE4D27C2BAD797`
</td>
<td>Windows 11 Version 24H2 (26100.2) (en-US)</td>
<td><details>

No Compatibility at all with 128GB, please do not flash on a 128GB Surface Duo!

1) After "Getting Ready" boot, on the second boot, the device may show a black screen, if this happens, press the power button once and it will continue to oobe after a minute. Be patient and don't press it more than once.
</details></td>
</tr>
<tr>
<td>
4GB Android, everything else for Windows

[OEMEP_MaximizedForWindows.ffu](https://fullflash.pvabel.net/DuoWOA/v2406.36/OEMEP_MaximizedForWindows.ffu)

Size: 6.49 GB

SHA1: `3E86F9EA584B363BC96DD6CADFFB6B212ADA702E`
</td>
<td>Windows 11 Version 24H2 (26100.2) (en-US)</td>
<td><details>

Official Variant: 4GB only for Android, everything else for Windows, 256GB users may have to expand the MainOS partition using Disk Management in windows by using the "Extend Partition" option.

1) After "Getting Ready" boot, on the second boot, the device may show a black screen, if this happens, press the power button once and it will continue to oobe after a minute. Be patient and don't press it more than once.
</details></td>
</tr>
</table>


### Surface Duo 2

UEFI Files:
- [Fast Boot](https://github.com/WOA-Project/SurfaceDuo-Releases/releases/download/2404.03C/Surface.Duo.2.UEFI-v2406.36C.Fast.Boot.zip)
- [Dual Boot for FW 2023.501.159 (February 2024 OTA for Surface Duo 2 devices)](https://github.com/WOA-Project/SurfaceDuo-Releases/releases/download/2404.03C/Surface.Duo.2.UEFI-v2406.36C.Dual.Boot.zip)
- [FD for making your own Dual Boot Image](https://github.com/WOA-Project/SurfaceDuo-Releases/releases/download/2404.03C/Surface.Duo.2.UEFI-v2406.36C.FD.for.making.your.own.Dual.Boot.Image.zip)

FFU Files
<table>
<tr>
<td>FFU File</td>
<td>OS Version</td>
<td>Notes</td>
</tr>
<tr>
<td>
For 128GB variants

[OEMZE_128GB_HalfSplit.ffu](https://fullflash.pvabel.net/DuoWOA/v2406.36/OEMZE_128GB_HalfSplit.ffu)

Size: 5.95 GB

SHA1: `16442384F00F7BA5D0B8C5E5C7B43F6A35A37A67`
</td>
<td>Windows 11 Version 24H2 (26100.2) (en-US)</td>
<td><details>

Assumed Compatibility with 256gb and 512gb variants (may have issues but should work, if issues arise we're not responsible and you should be able to recover either way, the main issue is more the split being 64(Windows)/192(Android) than anything else!).

1) After "Getting Ready" boot, on the second boot, the device may show a black screen, if this happens, press the power button once and it will continue to oobe after a minute. Be patient and don't press it more than once.
</details></td>
</tr>
<tr>
<td>
For 256GB variants

[OEMZE_256GB_HalfSplit.ffu](https://fullflash.pvabel.net/DuoWOA/v2406.36/OEMZE_256GB_HalfSplit.ffu)

Size: 5.95 GB

SHA1: `0A387D025EF300297E7897D1E79D3D9FA48D13CC`
</td>
<td>Windows 11 Version 24H2 (26100.2) (en-US)</td>
<td><details>

No Compatibility at all with 128GB, please do not flash on a 128GB Surface Duo! Assumed Compatibility with 512gb variants (may have issues but should work, if issues arise we're not responsible and you should be able to recover either way, the main issue is more the split being different than anything else!). 

1) After "Getting Ready" boot, on the second boot, the device may show a black screen, if this happens, press the power button once and it will continue to oobe after a minute. Be patient and don't press it more than once.
</details></td>
</tr>
<tr>
<td>
4GB Android, everything else for Windows

[OEMZE_MaximizedForWindows.ffu](https://fullflash.pvabel.net/DuoWOA/v2406.36/OEMZE_MaximizedForWindows.ffu)

Size: 5.95 GB

SHA1: `152DBA85BF29ABC8817F0DB5A1F9DAA546B8AA67`
</td>
<td>Windows 11 Version 24H2 (26100.2) (en-US)</td>
<td><details>

Official Variant: 4GB only for Android, everything else for Windows, 256GB/512GB users may have to expand the MainOS partition using Disk Management in windows by using the "Extend Partition" option.

1) After "Getting Ready" boot, on the second boot, the device may show a black screen, if this happens, press the power button once and it will continue to oobe after a minute. Be patient and don't press it more than once.
</details></td>
</tr>
</table>

<details>
    <summary>Here's how to acquire the Android SDK Platform Tools: <b>Click to expand</b></summary>
    <p>


First, start by going to the [Android Platform SDK download page](https://developer.android.com/studio/releases/platform-tools) on your computer.

![SDK-1-Top](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/4c1c3762-24d8-4150-ac69-670738eb62c1)

Once on the page, scroll a little bit down til you see the link to download the platform tools for Windows.

![SDK-2-Mid](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/cd14a232-4995-480f-a061-54507e83cf41)

Click on it, an EULA will open like below:

![SDK-3-EULA](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/16d6b7df-ab56-414c-b1a5-561ec6b3ae4e)

Scroll all the way down (after reading it if that's your thing)

![SDK-4-EULA-Bottom](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/1368b2b0-74b8-4a7c-9aff-df2ca25c2f42)

Tick "I have read and agree to above terms conditions"

![SDK-5-EULA-TICK (alt)](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/02905fa2-64b8-426b-b42f-c1bb88eaa88a)

And click download

![SDK-5-EULA-TICK](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/0983f27a-76e7-4fda-ac4d-adaa56702e90)

Save the file on your computer, and extract the zip file by opening it, and selecting extract all.

![SDK-6-DL](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/adc1bba0-6118-418e-9005-e2db12860893)

  </p>
</details>

## Getting to FFU Loader

- Reboot into the Bootloader mode by running this command while inside Android™:

```batch
adb reboot bootloader
```

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

- Start by booting the UEFI:

```batch
fastboot boot uefi.img
```

- Press the Volume Down Key on the side of your device til you see something like shown below on screen:

![Surface Duo in FFU Loader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/f35ba53d-70c6-41de-9cca-ad31368a35fb)

Congratulations, you're now in FFU Loader.

## Flashing the Windows FFU Image

- Open a command prompt where you extracted the FFU-Loader-Tools archive, and run the following commands:

```batch
ImageUtility.exe FlashDevice -Path <Path to the FFU File you downloaded>
```

![Surface Duo in FFU Loader mode, flashing](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/7770ef0a-62d9-49de-a9b0-f8e4f3a58933)

- You should now see the device flashing on both your computer and on the device, wait til the process is complete. In case the PC complains the device was not found, try using an USB-2 port or cable that downgrades your connection to USB-2, there are known issues with the UEFI that prevent USB-3 from functioning properly at the moment, and will be addressed in a future update.

- Once done you should be seeing the following screen:

![Surface Duo in FFU Loader mode, flashed](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/ba3c33df-9eb5-4b21-90da-7b8b0c3a5faf)

- Now reboot the device, you should be back to the bootloader menu:

```batch
ImageUtility.exe RebootDevice
```

- In case the bootloader menu does not automatically come up, press the volume down when running above command to be 100% sure you go into the bootloader menu.

- Run the following two commands:

```batch
fastboot set_active other
fastboot set_active other
```

And reboot your device
```batch
fastboot reboot
```

## Reset Android™

If this is your first time flashing this FFU file, or you're flashing a different storage or layout configuration image, you will lose all of your Android™ data. Further more, you will also not have Android boot successfully.
If this isn't your case, feel free to ignore this section, Android™ should still boot fine.
If this is your case, when booting Android™, you will get notified Android cannot boot anymore. In this screen, you must select "Factory Reset" instead of "Try again" or else, Android™ will refuse to boot again.

- You should now be seeing the Android™ Out of Box Experience (OOBE). Setup your phone to confirm it works correctly.

![Android™ - OOBE](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/5f86cbbe-df08-4ba6-92aa-b7fd2a7f72b3)

- Assuming your Surface Duo is booted to Android™, plugged to your PC

- Using the Microsoft Launcher, find the settings app

![A1 Android™ - Open Settings](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/36ef925c-fe98-4ec6-9861-c1037d8ced19)

- Open the Android™ Settings app

![A2 Android™ - Settings Opened](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/02b78630-d2b2-4211-abe1-c89255fe9bc6)

- Scroll down to the about section, and open it

![A3 Android™ - Settings About](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/0dad0ac3-21f3-42fd-a02c-78e9eb399118)

- Scroll all the way down til you see the Build Number field

![A4 Android™ - Settings About Down](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/afac2404-9624-4298-9785-b6a21bc31699)

- Press the Build number field 7 times consecutively, you should first start to see a popup after 3 taps

![A5 Android™ - Settings About Down Tap Dev](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/b850bef7-2938-47a0-b781-c54178e3cf7d)

- Once done tapping 7 times, you should be seeing this popup instead

![A6 Android™ - Settings About Down Tap Dev Done](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/8afef456-00a4-41e7-9653-c91a901e16c1)

- Now go to the System section, you should see a new Developer options section like shown below

![A7 Android™ - Settings System with Dev](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/a2de44f2-b492-450a-830a-5e7141e232b7)

- Go to the Developer options section

![Android™ Settings System Dev Options](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/ffbbcee9-98ab-4b83-8eaa-57487c1c1cf0)

- Scroll all the way down til you see the "USB debugging" option

![Android™ Settings - Dev - Debugging Option](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/3847fdcb-c19c-4c5d-aa4c-00a60e85c2b0)

- And turn on the "USB debugging" option

![Android™ Settings - Dev - Debugging Option Confirmation](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/60b52b98-8c6a-4845-833d-470378206fb2)

- Reboot into the Bootloader mode by running this command while inside Android™:

```batch
adb reboot bootloader
```

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

## Boot Windows 🚀

We are ready to boot for the first time!

Let's boot the UEFI, from a command prompt:

```batch
fastboot boot uefi.img
```

This step above will be needed every time you will want to boot Windows and needs to be done from the Bootloader mode.

If you did everything right, Windows will now boot! Enjoy!

**Note:** If the Touch keyboard won't show up in OOBE, touch somewhere else (to let the text box loose focus) and then touch into the text box again. As an alternative, you can use the On-Screen Keyboard.

Let Windows set itself up, and come back once you're on the Windows Desktop on your Surface Duo

**Note 2:** If you get a BSOD (bugcheck screen) during initial setup, you can try erasing both the esp and win partitions using "fastboot erase esp" and "fastboot erase win", and reflash the FFU file, then it should work. This issue will get fixed in later FFU revisions.

## Boot Windows again after initial installation

You'll have two methods of booting Windows.

- Manual booting with a PC
    - Pros: You can freely update Android™
    - Cons: You will need a PC to boot to Windows

- Enabling Dual Boot
    - Pros: You'll be able to boot Windows directly from the device
    - Cons: Every time you update Android™, you'll have to follow [this guide](/InstallWindows/DualBoot.md)

In case you want the dual boot option, then follow [this guide](/InstallWindows/DualBoot.md)

---
<details>
  <summary>In case you want to manually boot each time: (<b>Click to expand</b>)</summary>
  <p>

Reboot your device to the Bootloader mode, using adb or from the recovery.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

Let's boot the UEFI, from a command prompt:

```batch
fastboot boot uefi.img
```

This step above will be needed every time you will want to boot Windows and needs to be done from the Bootloader mode.

If you did everything right, Windows will now boot! Enjoy!

**Note:** If the Touch keyboard won't show up in OOBE, touch somewhere else (to let the text box loose focus) and then touch into the text box again. As an alternative, you can use the On-Screen Keyboard.
  </p>
</details>

---

_**© 2020-2024 The Duo WOA Authors**_

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

_**Limited emergency calling**_

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

_**Hello from Seattle (US), France, Italy.**_
