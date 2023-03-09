# Reinstall Windows on Surface Duo 1

## Files/Tools Needed 📃

- TWRP image: [surfaceduo1-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo1-twrp.img)
- Mass Storage Shell Script: [surfaceduo1-msc.tar](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo1-msc.tar)
- Windows UEFI: [surfaceduo1-uefi.img](https://github.com/WOA-Project/SurfaceDuoPkg/releases/)
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- An ARM64 Windows build of your choice that meets the minimum system requirements (specifically the install.wim file). You can use [UUPMediaCreator](https://github.com/gus33000/UUPMediaCreator) for this. [Here's a guide on how to use it.](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/CreateWindowsISO.md)
- The driver set: [SurfaceDuo-Drivers-Full.zip](https://github.com/WOA-Project/SurfaceDuo-Drivers/releases/)
- DriverUpdater, to install the driver set: [DriverUpdater](https://github.com/WOA-Project/DriverUpdater/releases/)
- A Windows PC to build the Windows ISO, apply it onto the phone from mass storage, add drivers to the installation, configure ESP

## Warnings ⚠️

- Don't create partitions from Mass Storage Mode on Windows (because ABL will break with blank/spaces in names), your phone may be irrecoverable otherwise
- If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.
- Don't rerun the commands if you interrupt the process. You may break your partition table. 
- Do not run all commands at once.
- Do not commit *any* typo with *any* commands.
- Be familiar with command line interfaces.
- When using TWRP, it is normal and expected for the phone to be detected as a Xiaomi phone and for touch to not work.

**THIS WILL WIPE ALL YOUR WINDOWS DATA**

We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
but this is **STILL IN PREVIEW** and things can go wrong.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

# Steps 🛠️

## Getting to Mass Storage Mode

- Reboot into the bootloader menu by running this command while inside Android™:

```
adb reboot bootloader
```

- Now let's boot TWRP:

```
fastboot boot surfaceduo1-twrp.img
```

Once inside TWRP, touch will not be working and the device will say it is locked. This is completely normal.
- Let's load the mass storage shell script in order to boot into Mass Storage from TWRP

```
adb push <path to downloaded surfaceduo1-msc.tar> /sdcard/
adb shell "tar -xf /sdcard/surfaceduo1-msc.tar -C /sdcard --no-same-owner"
adb shell "chmod +x /sdcard/msc.sh"
adb shell "/sdcard/msc.sh"
```

Surface Duo should now be in USB 3 SuperSpeed (or what the USB-IF currently calls it) Mass Storage Mode.

## Formatting the existing Windows partition

- Mount the partitions you made when you first installed Windows and assign them some letters:

```
⚠️ THESE ARE NOT ALL COMMANDS. DISKPART COMMANDS VARY A LOT, SO THESE ARE SOME ROUGH INSTRUCTIONS.
ACTUAL COMMANDS START WITH AN HASHTAG (which you will need to remove)
YOU DO NOT HAVE TO USE Y or X, THEY ONLY NEED TO BE FREE LETTERS. IF LETTERS DON'T ASSIGN FINE, USE ANOTHER ONE.
IF ONE PARTITION IS ALREADY ASSIGNED, YOU ALSO DO NOT NEED TO ASSIGN IT AGAIN IF YOU DONT WANT TO.

# list disk
Find the Surface Duo Disk, and take note of the number.
# select disk <number>
# list partition
You will be able to recognize the partitions you made the first time you installed Windows by their size. 
Take note of the ESP and WIN partition numbers.
# select partition <esp-partition-number>
# assign letter=Y:
# select partition <win-partition-number>
# assign letter=X:
```

- You will have two partitions loaded, one is the ESP partition, and the other is the Win partition. Take note of the letters you've used.

**_⚠️ WARNING: From now on we will assume X: is the Win partition and that Y: is the ESP partition for all the commands. Replace them correctly with what you previously picked or you will lose data on your PC._**

- Now open the file explorer, find the just-mounted Windows drive. BE CAREFUL! If you choose the wrong device, you WILL LOSE IMPORTANT DATA ON YOUR PC! Check that the letter is the same one you've assigned before. In our case, it's X:\.
- Once you have made sure you have found the right partition, right click on it and select "Format".
- Make sure the selected file system is NTFS, that "Quick Format" is checked, and leave the rest as it is, and press "Start".

Now the Windows Partition on your Surface Duo should be empty. Let's go ahead and reinstall everything.

## Installing Windows

- We will need our install.wim file now. If you haven't it already, you can [use this guide](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/CreateWindowsISO.md). When you are ready, run these commands:

```
dism /apply-image /ImageFile:"<path to install.wim>" /index:1 /ApplyDir:X:\
```

This will take a bit of time. Go make some coffee ☕ or some tea 🍵.

- Once that is done:

```
bcdboot X:\Windows /s Y: /f UEFI
```

Windows is now installed but has no drivers.

## Installing the drivers

- Extract the drivers, Extract driver updater, and from the command prompt in the DriverUpdater.exe directory:

```
DriverUpdater.exe -d "<path to extracted drivers>\definitions\Desktop\ARM64\Internal\epsilon.txt" -r "<path to extracted drivers>" -p X:\
```

## [Temporary and Optional] Copy over calibration files/configuration files for the sensors

_These steps are temporary and will not be needed in future releases. These steps are also not as fully detailed as others and may get updated at a later time_

In order to get most sensors currently working, some manual steps are required.

You will need to backup from mass storage or twrp the following directory: /mnt/vendor/persist/sensors/ and copy over the contents to [Windows Drive Letter]\Windows\System32\Drivers\DriverData\QUALCOMM\fastRPC\persist\sensors (the following directory should already exist after booting Windows once, otherwise create it)

The ```persist``` partition should be accessible via mass storage but is formatted using ```EXT4```. In order to be able to read it from Windows without Linux, you may use ```7-zip```. Note down the disk number your device is using when connected in mass storage mode to your computer. You can also use TWRP or Android™ to get them if you find this easier or 7-zip does not work for you.

Start 7-zip as administrator.

In 7-zip, enter the following into the address bar: ```\\.\```

Now open the ```PhysicalDriveX``` file matching your phone, where X is your disk number. You should be able to see persist and browse through it from 7-zip.

If, however, the ```persists``` partition isn't available you can use ```adb pull``` to obtain sensor data. Here's how you can do that:

```
      adb shell "mkdir /mnt/vendor/persist && mount /dev/block/sda2 /mnt/vendor/persist"
      adb shell "tar -cf /tmp/vendor.tar /mnt/vendor/persist/sensors"
      adb pull /tmp/vendor.tar
```

## Boot Windows 🚀

We are ready to boot!
      
You'll have two methods of booting Windows. 
      
- Enabling Dual Boot
    - Pros: You'll be able to boot Windows directly from the device
    - Cons: Every time you update Android™, you'll have to follow [this guide](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/DualBoot.md)
      
- Manual booting with a PC
    - Pros: You can freely update Android™
    - Cons: You will need a PC to boot to Windows

In case you want the first option, then follow [this guide](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/DualBoot.md)

---
<details>
  <summary>In case you want to manually boot each time: (Click to expand)</summary>
  <p>

Reboot your device to fastboot, using adb or from the recovery.
      
Let's boot the custom UEFI, from a command prompt:

```
fastboot boot surfaceduo1-uefi.img
```

This step above will be needed every time you will want to boot Windows and needs to be done from the Bootloader mode.

You should be thrown in the Boot Manager.

- Navigate with the volume up/down buttons to Mass Storage Mode or Windows, and press the Power Button to confirm.

If you did everything right, Windows will now boot! Enjoy!

**Note:** If the Touch keyboard won't show up in OOBE, touch somewhere else (to let the text box loose focus) and then touch into the text box again. As an alternative, you can use the On-Screen Keyboard.
  </p>
</details>
