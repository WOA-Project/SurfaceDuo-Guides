# Updating Drivers and UEFI firmware

## Table of contents
1. [Files/Tools needed 📃](#filestools-needed-📃)
4. [Steps 🛠️](#steps-🛠️)

## Files/Tools needed 📃

- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- Mass Storage Shell Script: [msc.tar](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/msc.tar)
- The driver set: [SurfaceDuo-Drivers-2XXX.XX-Full.zip](https://github.com/WOA-Project/SurfaceDuo-Drivers/releases/latest)
- DriverUpdater, to install the driver set: [DriverUpdater](https://github.com/WOA-Project/DriverUpdater/releases/latest)
- A Windows PC

### For Surface Duo (1st Gen)

- TWRP image for Surface Duo (1st Gen): [surfaceduo1-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo1-twrp.img)
- Windows UEFI for Surface Duo (1st Gen): [Surface.Duo.1st.Gen.UEFI.Fast.Boot.zip/uefi.img](https://github.com/WOA-Project/SurfaceDuoPkg/releases/latest)

### For Surface Duo 2

- TWRP image for Surface Duo 2: [surfaceduo2-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo2-twrp.img)
- Windows UEFI for Surface Duo 2: [Surface.Duo.2.UEFI.Fast.Boot.zip/uefi.img](https://github.com/WOA-Project/SurfaceDuoPkg/releases/latest)

> [!WARNING]
> - ⚠️ If you use a Dual Boot Image preflashed onto the device, you will also need to follow this guide again: [Dual Boot](../InstallWindows/DualBoot-SurfaceDuo.md)
> - ⚠️ If you are upgrading from a version older than 2301.93, you must reinstall using this guide:
>     - [Reinstall Windows (Surface Duo (1st Gen))](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/InstallWindows/ReinstallWindows-SurfaceDuo1.md)
>     - [Reinstall Windows (Surface Duo 2)](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/InstallWindows/ReinstallWindows-SurfaceDuo2.md)
> - ⚠️ If you are upgrading from a version older than 2301.93, you must also use version Driver Updater version 1.8.0.0 or higher
> - If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.
> - Do not run all commands at once.
> - When using TWRP, it is normal and expected for the phone to be detected as a Xiaomi phone or an Asus phone and for touch to not work.

## Steps 🛠️

### Switching to Mass Storage Mode

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

- Extract the driver package, extract the driver updater zip, and open a command prompt in the directory containing DriverUpdater.exe:

For Surface Duo (1st Gen):

```batch
DriverUpdater.exe -d "<path to extracted drivers>\definitions\Desktop\ARM64\Internal\epsilon.xml" -r "<path to extracted drivers>" -p X:\
```

For Surface Duo 2:

```batch
DriverUpdater.exe -d "<path to extracted drivers>\definitions\Desktop\ARM64\Internal\zeta.xml" -r "<path to extracted drivers>" -p X:\
```

---

- Once it is done, you can reboot your phone using:

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

- If you are in Android™, boot into Surface Duo's bootloader using the following command:

```batch
adb reboot bootloader
```

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

---

_**© 2020-2024 The Duo WOA Authors**_

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

_**Limited emergency calling**_

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

_**Hello from Seattle (US), France, Italy.**_