# Updating Drivers and UEFI firmware

## Table of contents
1. [Files/Tools needed 📃](#filestools-needed-📃)
2. [Warnings ⚠️](#warnings-⚠️)
4. [Steps 🛠️](#steps-🛠️)

## Files/Tools needed 📃
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)

- Mass Storage Shell Script: [msc.tar](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/msc.tar)

- The driver set: [SurfaceDuo-Drivers-Full.zip](https://github.com/WOA-Project/SurfaceDuo-Drivers/releases/latest)

- DriverUpdater, to install the driver set: [DriverUpdater](https://github.com/WOA-Project/DriverUpdater/releases/latest)

- A Windows PC

### For Surface Duo (First Gen)

- TWRP image for Surface Duo (First Gen): [surfaceduo1-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo1-twrp.img)

- Windows UEFI for Surface Duo (First Gen): [SM8150.UEFI.Surface.Duo.1.zip/uefi.img](https://github.com/WOA-Project/SurfaceDuoPkg/releases/latest)

### For Surface Duo 2

- TWRP image for Surface Duo 2: [surfaceduo2-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo2-twrp.img)

- Windows UEFI for Surface Duo 2: [SM8350.UEFI.Surface.Duo.2.zip/uefi.img](https://github.com/WOA-Project/SurfaceDuoPkg/releases/latest)

## Warnings ⚠️

- ⚠️ If you use a Dual Boot Image preflashed onto the device, you will also need to follow this guide again: [Dual Boot](../InstallWindows/DualBoot-SurfaceDuo.md)

- ⚠️ If you are upgrading from a version older than 2301.93, you must reinstall using this guide:

    - [Reinstall Windows (Surface Duo (First Gen))](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/InstallWindows/ReinstallWindows-SurfaceDuo1.md)

    - [Reinstall Windows (Surface Duo 2)](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/InstallWindows/ReinstallWindows-SurfaceDuo2.md)

- ⚠️ If you are upgrading from a version older than 2301.93, you must also use version Driver Updater version 1.8.0.0 or higher

- If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.

- Do not run all commands at once.

- When using TWRP, it is normal and expected for the phone to be detected as a Xiaomi phone or an Asus phone and for touch to not work.

## Steps 🛠️

### Switching to Mass Storage Mode

- Start by booting TWRP:

For Surface Duo (First Gen):

```batch
fastboot boot surfaceduo1-twrp.img
```

For Surface Duo 2:

```batch
fastboot boot surfaceduo2-twrp.img
```

---

- Once inside TWRP, touch will not be working and the device will say it is locked. This is completely normal. Keep the phone plugged to your PC and do these commands ONE BY ONE WITH NO TYPO!:

```batch
adb shell "setenforce 0"
adb push <path to downloaded msc.tar> /sdcard/
adb shell "tar -xf /sdcard/msc.tar -C /sdcard --no-same-owner"
adb shell "sh /sdcard/msc.sh"
```

## Updating Drivers

**_⚠️ WARNING: From now on we will assume X: is the Win partition for all commands. Replace them correctly with what you previously picked or you will lose data on your PC._**

- Extract the driver package, extract the driver updater zip, and open a command prompt in the directory containing DriverUpdater.exe:

For Surface Duo (First Gen):

```batch
DriverUpdater.exe -d "<path to extracted drivers>\definitions\Desktop\ARM64\Internal\epsilon.txt" -r "<path to extracted drivers>" -p X:\
```

For Surface Duo 2:

```batch
DriverUpdater.exe -d "<path to extracted drivers>\definitions\Desktop\ARM64\Internal\zeta.txt" -r "<path to extracted drivers>" -p X:\
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