# Updating Drivers and UEFI firmware

## Table of contents
1. [Files/Tools needed 📃](#filestools-needed-📃)
2. [Warnings ⚠️](#warnings-⚠️)
4. [Steps 🛠️](#steps-🛠️)

## Files/Tools needed 📃
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)

- TWRP image: [surfaceduo1-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo1-twrp.img)

- Windows UEFI: [SM8150.UEFI.Surface.Duo.1.zip/uefi.img](https://github.com/WOA-Project/SurfaceDuoPkg/releases/)

- Mass Storage Shell Script: [surfaceduo1-msc.tar](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo1-msc.tar)

- The driver set: [SurfaceDuo-Drivers-Full.zip](https://github.com/WOA-Project/SurfaceDuo-Drivers/releases/)

- DriverUpdater, to install the driver set: [DriverUpdater](https://github.com/WOA-Project/DriverUpdater/releases/)

- A Windows PC

## Warnings ⚠️

- ⚠️ If you use a Dual Boot Image preflashed onto the device, you will also need to follow this guide again: [Dual Boot](../InstallWindows/DualBoot-SurfaceDuo1.md)

- ⚠️ If you are upgrading from a version older than 2301.93, you must also follow this guide: [Migration Guidance for Secure Boot](MigrationGuidanceForSecureBoot.md)

- ⚠️ If you are upgrading from a version older than 2301.93, you must also use version Driver Updater version 1.8.0.0 or higher

- If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.

- Do not run all commands at once.

- When using TWRP, it is normal and expected for the phone to be detected as a Xiaomi phone and for touch to not work.

## Steps 🛠️

### Switching to Mass Storage Mode

- Start by booting TWRP:

```batch
fastboot boot surfaceduo1-twrp.img
```

- Once inside TWRP, touch will not be working and the device will say it is locked. This is completely normal. Keep the phone plugged to your PC and do these commands ONE BY ONE WITH NO TYPO!:

```batch
adb push <path to downloaded surfaceduo1-msc.tar> /sdcard/
adb shell "tar -xf /sdcard/surfaceduo1-msc.tar -C /sdcard --no-same-owner"
adb shell "chmod +x /sdcard/msc.sh"
adb shell "/sdcard/msc.sh"
```

## Updating Drivers

**_⚠️ WARNING: From now on we will assume X: is the Win partition for all commands. Replace them correctly with what you previously picked or you will lose data on your PC._**

- Extract the driver package, extract the driver updater zip, and open a command prompt in the directory containing DriverUpdater.exe:

```batch
DriverUpdater.exe -d "<path to extracted drivers>\definitions\Desktop\ARM64\Internal\epsilon.txt" -r "<path to extracted drivers>" -p X:\
```

- Once it is done, you can reboot your phone using:

```batch
adb reboot bootloader
```

You will be back into Surface Duo's bootloader. 

## Updating UEFI

Simply use the latest UEFI image

- Assuming you are in Surface Duo´s bootloader, run the following command to boot into Windows:

```batch
fastboot boot uefi.img
```

- If you are in Android, boot into Surface Duo´s bootloader using the following command:


```batch
adb reboot bootloader
```