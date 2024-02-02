# How to recreate the ESP partition for Windows 

## Files/Tools Needed 📃 

- Mass Storage Shell Script: [msc.tar](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/msc.tar)
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- A Windows PC

### For Surface Duo (1st Gen)

- TWRP image for Surface Duo (1st Gen): [surfaceduo1-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo1-twrp.img)

### For Surface Duo 2

- TWRP image for Surface Duo 2: [surfaceduo2-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo2-twrp.img)
- File System Support Package for TWRP image: [surfaceduo2-twrp-fssupport.tar](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo2-twrp-fssupport.tar)

> [!WARNING]
> - Don't create partitions from Mass Storage Mode on Windows (because ABL will break with blank/spaces in names), your phone may be irrecoverable otherwise
> - Read the entire guide before starting. Make sure you understand all of what you're going to do!
> - If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.
> - Don't rerun the commands if you interrupt the process. You may break your partition table.
> - Do not run all commands at once.
> - Do not commit *any* typo with *any* commands.
> - Be familiar with command line interfaces.
> - When using TWRP, it is normal and expected for the phone to be detected as a Xiaomi phone or an Asus phone and for touch to not work.

# Steps 🛠️

## Getting to TWRP

- Reboot into the Bootloader mode by running this command while inside Android™:

```batch
adb reboot bootloader
```

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

Start by booting TWRP:

- Plug your phone to your PC, open a command prompt and start by typing the following text, but do not press enter just yet

```batch
fastboot boot
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/24c5ed51-4710-449d-a5dc-686f8da8ea47)

- Go find the surfaceduo1-twrp.img file you downloaded earlier, right click it, click "Copy Path"

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/3e8db3d5-44d0-4e6c-a7ef-674f86e82650)

- Then go back to the Command Prompt window we started writing text in previously, and simply, right click on it with your mouse (or long press if you're on a touch device), you should now see this:

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/e97d514b-a314-4faf-9622-75bdab066985)

- Now you can press enter

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/2e27f24c-5b12-476d-99d8-f11de5baa807)

You will now boot to TWRP. Reminder that touch doesn't work on TWRP for now, so you'll have to work through your PC.

- Once inside TWRP, touch will not be working and the device will say it is locked. This is completely normal.

## Format the Windows EFI System Partition in TWRP

- Format the esp partition again with the mkfs.fat tool in TWRP:

> [!WARNING]
>THIS COMMAND MUST NEVER BE RAN IF THE ESP PARTITION IS NOT PRESENT AND ONLY ANDROID IS ON THE DEVICE!

### For Surface Duo (1st Gen)

```bash
adb shell "setenforce 0"
adb shell "mkfs.fat -F32 -s1 /dev/block/sda6"
```

### For Surface Duo 2

```bash
adb shell "setenforce 0"
adb push <path to downloaded surfaceduo2-twrp-fssupport.tar> /sdcard/
adb shell "tar -xf /sdcard/surfaceduo2-twrp-fssupport.tar -C /sdcard/fssupport --no-same-owner"
adb shell "chmod 755 /sdcard/fssupport/*"
adb shell "mv /sdcard/fssupport/* /sbin/"
adb shell "mkfs.fat -F32 -s1 /dev/block/sda8"
```

## Going to Mass Storage

- Let's load the mass storage shell script in order to boot into Mass Storage from TWRP

```batch
adb shell "setenforce 0"
adb push <path to downloaded msc.tar> /sdcard/
adb shell "tar -xf /sdcard/msc.tar -C /sdcard --no-same-owner"
adb shell "sh /sdcard/msc.sh"
```

Surface Duo should now be in USB 3 SuperSpeed (or what the USB-IF currently calls it) Mass Storage Mode.

## Rebuilding Windows EFI System Partition

- Assign only one drive letter to the esp partition (can be anything from A to Z as long as it's free)

```batch
⚠️ THESE ARE NOT ALL COMMANDS. DISKPART COMMANDS VARY A LOT, SO THESE ARE SOME ROUGH INSTRUCTIONS.
ACTUAL COMMANDS START WITH AN HASHTAG (which you will need to remove)
YOU DO NOT HAVE TO USE THE LETTERS WE USE AT ALL!!!, THEY ONLY NEED TO BE FREE LETTERS. IF LETTERS DONT ASSIGN FINE, USE ANOTHER ONE.
IF ONE PARTITION IS ALREADY ASSIGNED, YOU ALSO DO NOT NEED TO ASSIGN IT AGAIN IF YOU DONT WANT TO.

# list disk
Find the Surface Duo Disk, and take note of the number.
# select disk <number>
# list partition
You will be able to recognize the partitions we made earlier by their size. take note of the ESP and WIN partition numbers.
# select partition <esp-partition-number>
# assign letter=<the drive letter you chose>:
```

- Rerun the bcdboot command:

```batch
bcdboot <Windows Partition drive letter>:\Windows /s <ESP DRIVE LETTER>: /f UEFI
```

- Once it is done, you can reboot your phone using ```adb reboot bootloader```. You will be able to boot to Android™ and your phone will work normally. Set it up if you need it.

You will be back into Surface Duo's bootloader.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_