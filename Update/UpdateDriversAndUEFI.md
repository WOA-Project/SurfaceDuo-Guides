# Updating Drivers and UEFI firmware

Table of Contents:

1. [Files/Tools needed 📃](#filestools-needed-📃)
2. [Steps 🛠️](#steps-🛠️)

## Files/Tools needed 📃

- You will need the following files from the [BSP Release page](https://github.com/WOA-Project/SurfaceDuo-Releases/releases/latest):

UEFI Image:

| File Name                              | Target Device         |
|----------------------------------------|-----------------------|
| Surface.Duo.1st.Gen.UEFI.Fast.Boot.zip | Surface Duo (1st Gen) |
| Surface.Duo.2.UEFI.Fast.Boot.zip       | Surface Duo 2         |

Windows Drivers:

| File Name                                       | Target Device         |
|-------------------------------------------------|-----------------------|
| SurfaceDuo-Drivers-v2XXX.XX-Desktop-Epsilon.zip | Surface Duo (1st Gen) |
| SurfaceDuo-Drivers-vXXXX.XX-Desktop-Zeta.zip    | Surface Duo 2         |

- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- Mass Storage Shell Script: [msc.tar](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/msc.tar)
- A Windows PC

- TWRP image:

| File Name                                       | Target Device         |
|-------------------------------------------------|-----------------------|
| [surfaceduo1-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/surfaceduo1-twrp.img) | Surface Duo (1st Gen) |
| [surfaceduo2-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/surfaceduo2-twrp.img) | Surface Duo 2         |

## Disclaimers

> [!WARNING]
> - ⚠️ If you use a Dual Boot Image preflashed onto the device, you will also need to follow this guide again: [Dual Boot](/Install/DualBoot.md)
> - ⚠️ If you are upgrading from a version older than 2301.93, you must reinstall using this guide:
>     - [Reinstall Windows (Surface Duo (1st Gen))](/Install/Client/ReinstallWindows-SurfaceDuo1.md)
>     - [Reinstall Windows (Surface Duo 2)](/Install/Client/ReinstallWindows-SurfaceDuo2.md)
> - ⚠️ If you are upgrading from a version older than 2301.93, you must also use version Driver Updater version 1.8.0.0 or higher
> - If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.
> - Do not run all commands at once.
> - When using TWRP, it is normal and expected for the phone to be detected as a Xiaomi phone or an Asus phone and for touch to not work.

# Steps 🛠️

## Acquiring all files

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

## Going to the Bootloader menu

- Start by turning on your Surface Duo into Android™, and unlock it

- Open a command prompt on your PC

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/ab36aa10-6617-4680-ac06-bb58b7a0c3bb)

- Go to the folder where you extracted the Google Android™ Platform tools using the CD command and the path of the folder, like so:

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/24760f21-dc1b-48e6-9ae3-0aeb16f8953c)

- Run the following command to ensure your phone is detected by your PC

```batch
adb devices
```

> [!TIP]
> If you see no device listed, check for updates in Windows Update, you likely have a Driver Update pending so the phone is recognized, when you're good to go, you should see the following image below this notice.
> It is possible certain computers see no update offered (like Windows ARM64 Computers or other older machines with no functional Windows Update). If this is your case, we also provide Drivers for you to download
> at the following location, you will have to install them using Device Manager on your PC. [Download USB Drivers](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/USB-Drivers.zip)

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/b3a8b091-1b34-47e4-bd6e-c286ee808f14)

- Run the following command now

```batch
adb reboot bootloader
```

You will be rebooted to Surface Duo's bootloader.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

---

## Booting to TWRP

- Start by booting TWRP:

For Surface Duo (1st Gen):

- Plug your phone to your PC, open a command prompt and start by typing the following text, but do not press enter just yet

```batch
fastboot boot
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/24c5ed51-4710-449d-a5dc-686f8da8ea47)

- Go find the surfaceduo1-twrp.img file you downloaded earlier, right click it, click "Copy as path"

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/3e8db3d5-44d0-4e6c-a7ef-674f86e82650)

- Then go back to the Command Prompt window we started writing text in previously, and simply, right click on it with your mouse (or long press if you're on a touch device), you should now see this:

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/e97d514b-a314-4faf-9622-75bdab066985)

- Now you can press enter

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/2e27f24c-5b12-476d-99d8-f11de5baa807)

You will now boot to TWRP. Reminder that touch doesn't work on TWRP for now, so you'll have to work through your PC.

For Surface Duo 2:

- Plug your phone to your PC, open a command prompt and start by typing the following text, but do not press enter just yet

```batch
fastboot boot
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/24c5ed51-4710-449d-a5dc-686f8da8ea47)

- Go find the surfaceduo2-twrp.img file you downloaded earlier, right click it, click "Copy as path"

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/3e8db3d5-44d0-4e6c-a7ef-674f86e82650)

- Then go back to the Command Prompt window we started writing text in previously, and simply, right click on it with your mouse (or long press if you're on a touch device), you should now see this:

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/e97d514b-a314-4faf-9622-75bdab066985)

- Now you can press enter

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/2e27f24c-5b12-476d-99d8-f11de5baa807)

You will now boot to TWRP. Reminder that touch doesn't work on TWRP for now, so you'll have to work through your PC.

---

## Switching to Mass Storage Mode

- Once inside TWRP, touch will not be working and the device will say it is locked. This is completely normal. Keep the phone plugged to your PC and do these commands ONE BY ONE WITH NO TYPO!:

```batch
adb shell "setenforce 0"
adb push <path to downloaded msc.tar> /sdcard/
adb shell "tar -xf /sdcard/msc.tar -C /sdcard --no-same-owner"
adb shell "sh /sdcard/msc.sh"
```

## Updating Drivers

> [!WARNING]
> From now on we will assume X: is the Win partition for all commands. Replace them correctly with what you previously picked or you will lose data on your PC.

- Download the latest driver package from https://github.com/WOA-Project/SurfaceDuo-Releases/releases/latest

Note: Here's a table of what to download if you're a bit lost:

| File Name                                      | Target Device         |
|------------------------------------------------|-----------------------|
| SurfaceDuo-Drivers-XXXX.XX-Desktop-Epsilon.zip | Surface Duo (1st Gen) |
| SurfaceDuo-Drivers-XXXX.XX-Desktop-Zeta.zip    | Surface Duo 2         |

- Extract the driver package, and go to the folder where you extracted it.

- Double click the ```OfflineUpdater.cmd``` file.

- Accept the User Account Control warning when prompted

- Enter the drive letter of the connected phone in mass storage, as we previously mentioned, for us it's currently ```X:```, but it may very well be different for you. In our example, we enter ```X:``` and then press enter.

- The process may take a while, once it is done, you will be prompted to press any key, press enter when that's the case.

Congratulations, you just updated your drivers!

- You can now reboot your phone using:

```batch
adb reboot bootloader
```

You will be back into Surface Duo's bootloader.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

## Updating UEFI

Simply use the latest UEFI image

- Assuming you are in Surface Duo's bootloader, run the following command to boot into Windows:

```batch
fastboot boot uefi.img
```

> [!TIP]
> You can setup dual boot again if you need it by using the latest UEFI files and following the dual boot guide again (in case of a manual file creation), or by flashing one of the prebuilt dual boot images (see UEFI release notes for more details on both).

---

_**© 2020-2024 The Duo WOA Authors**_

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

_**Limited emergency calling**_

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

_**Hello from Seattle (US), France, Italy.**_