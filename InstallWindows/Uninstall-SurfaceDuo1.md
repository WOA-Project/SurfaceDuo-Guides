# Uninstall Windows and revert your Surface Duo (1st Gen) to stock

## Files/Tools Needed 📃
- TWRP image: [surfaceduo1-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo1-twrp.img)
- Parted: [parted](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/parted)
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- A PC.

> [!IMPORTANT]
> **THIS WILL WIPE ALL YOUR ANDROID™ DATA**
>
> We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
>
> but this is **STILL IN PREVIEW** and things can go wrong.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

If you caused modifications to Android™ system partitions and are not knowingly using Custom Trusted Boot certificates or do not know what we're talking about here but flashed a dual boot image onto your device, you need to revert this. Please see the dual boot guide for assistance first and foremost. Otherwise below's steps will brick your device.

## What you'll get 🛒

A normal Surface Duo, with Android™ only. Just like you had it before installing Windows. If you haven't broke anything else in the meantime.

Android™ will have access to the whole memory back again.

## Steps 🛠️

### Make sure you have not done any dual boot guide!

If you have followed a guide to use dual boot, please first remove dual boot by following the uninstall section in the dual boot guide, this is important: [DualBoot](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/InstallWindows/DualBoot-SurfaceDuo.md)

### Booting to TWRP

- Reboot your phone to Surface Duo Bootloader: Press Volume Down + Power until the Microsoft Corporation logo appears on the left, then release the power
  button and keep pressing the volume down button until the bootloader appears.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

- Plug your phone to your PC, open a command prompt and run the following command:

```batch
fastboot boot surfaceduo1-twrp.img
```

You will now boot to TWRP. Reminder that touch doesn't work on TWRP for now, so you'll have to work through your PC.

### Restoring the original partitions

- Let's copy and run parted:

```batch
adb shell "setenforce 0"
adb push <path to parted that was downloaded earlier> /sdcard/
adb shell "mv /sdcard/parted /sbin/parted && chmod 755 /sbin/parted"
adb shell
```

```bash
setenforce 0
parted /dev/block/sda
print
```

You'll get a list of partitions.

- Make sure that partitions 6, 7 and 8 are your ESP, Windows and userdata partitions. We'll assume they are for this guide.
  If they aren't, take note of these numbers and use them in the next steps. Please make sure these are right, or you'll end up
  bricking your Surface Duo.
- Note: you may also see Windows Recovery Partitions, you can also delete those, but nothing else.

⚠️ The next command will wipe all your data. Please make sure that you have backed everything up. ⚠️

```bash
rm 6
rm 7
rm 8

# FOR 128GB DEVICES ONLY: ---
mkpart userdata ext4 51.9MB 112GB

# FOR 256GB DEVICES ONLY: ---
mkpart userdata ext4 51.9MB 240GB
```

__This command leaves parted.__

```bash
quit
```

This will get you out of parted.

Now let's make the userdata partition actually usable:

```bash
setenforce 0
mke2fs -t ext4 /dev/block/sda6
exit
```

- Once it is done, you can reboot your phone using ```adb reboot bootloader```. You will be able to boot to Android™ and your phone should work normally. In case it doesn't you likely messed up something above.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

- Once Android™ is confirmed booting, reboot back into the bootloader using ```adb reboot bootloader``` or by pressing Volume Down right at boot.

You will be back into Surface Duo's bootloader.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

### Relocking the Bootloader

⚠️⚠️⚠️ If you caused modifications to Android™ system partitions and are not knowingly using Custom Trusted Boot certificates or do not know what we're talking about here but flashed a dual boot image onto your device, you need to revert this. Please see the dual boot guide for assistance first and foremost. Otherwise below's steps will brick your device. ⚠️⚠️⚠️

- Reboot your Surface Duo to the Bootloader: Press Volume Down + Power until the Microsoft Corporation logo appears on the left, then release the power
  button and keep pressing the volume down button until the bootloader appears.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

- Run this command:

```batch
fastboot flashing lock
```

- Reboot your Surface Duo, and Android™ should boot.
