# Install Windows on Surface Duo (128GB)
## Files Needed
- TWRP image: twrp.img
- Parted: parted
- Boot package: DuoBoot.tar
- Custom UEFI: boot.img
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)

## Warnings
Don't create partitions from Mass Storage Mode (because ABL will break with blank/spaces in names)

**THIS WILL WIPE ALL YOUR ANDROID DATA**

We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
but this is **AN EARLY PREVIEW** and things can go wrong.

This hasn't been tested on 256GB devices. This guide only targets 128GB devices.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

## What you'll get
You'll end up with both Android and Windows on your Duo. Android and Windows will both split the 128GB memory (64GB and 64GB)

Android will boot normally, and you'll have to use a PC to boot Windows when needed.

## Steps
### Unlocking the bootloader
- Backup all your data. **_You'll lose everything you have on Android and will start from scratch_**.
- From inside Android:
```
adb reboot bootloader
```
- You'll be rebooted to the Duo's bootloader. From there:
```
fastboot flashing unlock
```

### Making the partitions
- Start by booting TWRP:

```
fastboot boot twrp.img
```

- Once inside TWRP, touch will not be working. Keep the phone plugged to your PC and do these commands:

```
adb push <path to parted> /sdcard/
adb shell "cp /sdcard/parted /sbin/ && chmod 755 /sbin/parted"
adb shell
```

- Now we're issuing commands directly from inside the Duo using the PC. Let's run parted and make the partitions:

```
parted /dev/block/sda
print
```

- **Make sure that the last partition listed is numbered 6.**
- Take note of original sizing, here it was 51.9MB -> 112GB
- Run these commands:

```
rm 6
mkpart esp fat32 51.9MB 180MB
mkpart win ntfs 180MB 57344MB
mkpart userdata ext4 57344MB 112GB
set 6 esp on
quit
```

This will get you out of parted.

We have deleted partition 6, which was the Android userdata partition, and created 3 partitions: an esp partition which will contain the Windows boot files, 
a win partition that will have Windows, and the last one is the new userdata partition for Android, just smaller. Now let's make them actually usable:

```
mkfs.fat -F32 -s1 /dev/block/sda6
mkfs.ntfs -f /dev/block/sda7
mke2fs -t ext4 /dev/block/sda8
mkdir /sdcard/espmnt && mount /dev/block/sda6 /sdcard/espmnt/
quit
```

Let's load the files from duoboot.tar, which will be needed to boot and reach Mass Storage Mode.

```
adb push <path to duoboot.tar> /sdcard/
adb shell "tar -xf /sdcard/DuoBoot3.tar -C /sdcard/espmnt"
adb shell "mv /sdcard/espmnt/Windows/System32/Boot/ffuloader.efi /sdcard/espmnt/Windows/System32/Boot/ffuloader.efi.bak"
adb shell "cp /sdcard/espmnt/Windows/System32/Boot/developermenu.efi /sdcard/espmnt/Windows/System32/Boot/ffuloader.efi"
adb reboot bootloader
```

You'll be back into the Duo's bootloader. 

### Booting the Custom UEFI

Let's boot the custom UEFI:

```
- fastboot boot boot.img
```

This step above will be needed every time you'll want to boot Windows.

You should be thrown in Developer Menu. 

Navigate with the volume up/down buttons to Mass Storage Mode, and press the Power Button to confirm. Once you're in Mass Storage Mode, we're ready to continue.

### Installing Windows
[WORK IN PROGRESS]

(summary) From now on apply windows to the windows ntfs partition, bcdboot in esp, you might want to use an unattend to configure oobe given no input for now.
