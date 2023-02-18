# Updating Drivers and UEFI firmware

⚠️ If you use a Dual Boot Image preflashed onto the device, you will also need to follow this guide again: [Dual Boot](../DualBoot.md)

⚠️ If you are upgrading from a version older than 2301.93, you must also follow this guide: [Migration Guidance for Secure Boot](MigrationGuidanceForSecureBoot.md)

⚠️ If you are upgrading from a version older than 2301.93, you must also use version Driver Updater version 1.8.0.0 or higher

## Switching to Mass Storage Mode

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

- Extract the drivers, Extract driver updater, and from the command prompt in the DriverUpdater.exe directory:

```batch
DriverUpdater.exe -d "<path to extracted drivers>\definitions\Desktop\ARM64\Internal\epsilon.txt" -r "<path to extracted drivers>" -p X:\
```

- Once it is done, you can reboot your phone using ```adb reboot bootloader```. You will be able to boot to Android™ and your phone will work normally. Set it up if you need it.

You will be back into Surface Duo's bootloader. 

## Updating UEFI

- Simply use the latest UEFI image

Reboot your device to fastboot, using adb or from the recovery.
      
Let's boot the custom UEFI, from a command prompt:

```batch
fastboot boot surfaceduo1-uefi.img
```