# Install Windows on Surface Duo (128GB)
## Files Needed 📃
- TWRP image: [twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows-Files/twrp.img)
- Parted: [parted](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows-Files/parted)
- Boot package: [DuoBoot.tar](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows-Files/twrp.img)
- Custom UEFI: [boot.img](https://github.com/WOA-Project/SurfaceDuoPkg/releases/)
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- An ARM64 Windows build of your choice (specifically the install.wim file). You can use [UUPMediaCreator](https://github.com/gus33000/UUPMediaCreator) for this
- The driver set: [SurfaceDuo-Drivers-Full.zip](https://github.com/WOA-Project/SurfaceDuo-Drivers/releases/)

## Warnings ⚠️
Don't create partitions from Mass Storage Mode (because ABL will break with blank/spaces in names)

**THIS WILL WIPE ALL YOUR ANDROID DATA**

We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
but this is **AN EARLY PREVIEW** and things can go wrong.

This hasn't been tested on 256GB devices. This guide only targets 128GB devices.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

## What you'll get 🛒
You'll end up with both Android and Windows on your Duo. Android and Windows will both split the 128GB memory (64GB and 64GB)

Android will boot normally, and you'll have to use a PC to boot Windows when needed.

## Steps 🛠️
### Unlocking the bootloader
- Backup all your data. **_You'll lose everything you have on Android and will start from scratch_**.

Assuming your Duo is booted to Android and plugged to your PC:

- Open a command prompt on your PC and run this command:
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

- Let's load the files from duoboot.tar into the Duo, which will be needed to boot and reach Mass Storage Mode:

```
adb push <path to DuoBoot.tar> /sdcard/
adb shell "tar -xf /sdcard/DuoBoot.tar -C /sdcard/espmnt"
adb shell "mv /sdcard/espmnt/Windows/System32/Boot/ffuloader.efi /sdcard/espmnt/Windows/System32/Boot/ffuloader.efi.bak"
adb shell "cp /sdcard/espmnt/Windows/System32/Boot/developermenu.efi /sdcard/espmnt/Windows/System32/Boot/ffuloader.efi"
adb reboot bootloader
```

You'll be back into the Duo's bootloader. 

### Booting the Custom UEFI

Let's boot the custom UEFI:

```
fastboot boot boot.img
```

This step above will be needed every time you'll want to boot Windows.

You should be thrown in Developer Menu. 

- Navigate with the volume up/down buttons to Mass Storage Mode, and press the Power Button to confirm. Once you're in Mass Storage Mode, we're ready to continue.

### Installing Windows

- Make sure you are in Mass Storage Mode, that your Duo is plugged into your PC
- Mount the partitions you have created using diskpart and assign them some letters:

```
THESE ARE NOT ALL COMMANDS. DISKPART COMMANDS VARY A LOT, SO THESE ARE SOME ROUGH INSTRUCTIONS. 
ACTUAL COMMANDS START WITH AN HASHTAG (which you'll need to remove)

# list disk
Find the Duo Disk, and take note of the number.
# select disk <number>
# list partition
You'll be able to recognize the partitions we made earlier by their size. take note of the ESP and WIN partition numbers.
# select partition <esp-partition-number>
# assign letter=Y:
# select partition <win-partition-number>
# assign letter=X:
```

- You'll have two partitions loaded, one is the ESP partition, and the other is the Win partition. Take note of the letters you've used.

**_WARNING: We'll assume X: is the Win partition and that Y: is the ESP partition from the next commands. Replace them correctly or you'll lose data on your PC._**

- Run these commands:

```
dism /apply-image /ImageFile:"<path to install.wim>" /index:1 /ApplyDir:X:\
```

This will take a bit of time. Go make some coffee ☕ or some tea 🍵.

- Once that's done:

```
bcdboot X:\Windows /s Y: /f UEFI
```

Windows is now installed but has no drivers.

### Installing the drivers

- Extract the drivers, and from the command prompt:

```
dism /image:X:\ /add-driver /driver:"<path to extracted drivers>" /recurse
```

- Once it's done, you can reboot your phone. You'll be able to Android and your phone will work normally. Set it up if you need it.

### Boot Windows 🚀

We're ready to boot!

- Reboot your phone manually to the bootloader (keep the power button + vol down pressed until the Microsoft logo appears, then stop pressing the power
  button but keep pressing the volume down button).

From a command prompt:

```
fastboot boot boot.img
```

If you did everything right, Windows will now boot! Enjoy!

## Enabling USB

Still assuming that X: is the mounted Duo Windows partiton:

```
reg load RTS X:\Windows\System32\config\SYSTEM
```

Now open regedit.exe and edit this registry key:

```
HKEY_LOCAL_MACHINE\RTS\ControlSet001\Control\USB

OsDefaultRoleSwitchMode
```

Set the key to value 1 and you're done.
