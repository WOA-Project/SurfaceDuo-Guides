# Install Windows on Surface Duo 1

![Surface Duo Dual Screen Windows](https://user-images.githubusercontent.com/3755345/170788230-a42e624a-d2ed-4070-b289-a9b34774bcd0.png)

## Table of Contents
1. [Files/Tools Needed](#filestools-needed-)
2. [Warnings ⚠️](#warnings-%EF%B8%8F)
3. [What you will get 🛒](#what-youll-get-)
4. [Steps 🛠️](#steps-%EF%B8%8F)
    1. [Unlocking the bootloader](#unlocking-the-bootloader)
    2. [Making the partitions](#making-the-partitions)
    3. [Going to Mass Storage](#going-to-mass-storage)
    4. [Installing Windows](#installing-windows)
    5. [Installing the drivers](#installing-the-drivers)
    6. [Enabling the Windows Bootmanager to access the Developer Menu](#enabling-the-windows-bootmanager-to-access-the-developer-menu)
    7. [Boot Windows 🚀](#boot-windows-)
    8. [Known Issues](#known-issues)
5. [Enabling USB (Only if you get issues!)](#enabling-usb-only-if-you-get-issues)

## Files/Tools Needed 📃
- TWRP image: [surfaceduo1-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows-Files/surfaceduo1-twrp.img)
- Parted: [surfaceduo1-parted](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows-Files/surfaceduo1-parted)
- Boot package: [surfaceduo1-boot.tar](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows-Files/surfaceduo1-boot.tar)
- Mass Storage Shell Script: [surfaceduo1-msc.tar](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows-Files/surfaceduo1-msc.tar)
- Windows UEFI: [surfaceduo1-uefi.img](https://github.com/WOA-Project/SurfaceDuoPkg/releases/)
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- An ARM64 Windows build of your choice that meets the minimum system requirements (specifically the install.wim file). You can use [UUPMediaCreator](https://github.com/gus33000/UUPMediaCreator) for this. [Here's a guide on how to use it.](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/CreateWindowsISO.md)
- The driver set: [SurfaceDuo-Drivers-Full.zip](https://github.com/WOA-Project/SurfaceDuo-Drivers/releases/)
- DriverUpdater, to install the driver set: [DriverUpdater](https://github.com/WOA-Project/DriverUpdater/releases/)
- A Windows PC to build the Windows ISO, apply it onto the phone from mass storage, add drivers to the installation, configure ESP

## Warnings ⚠️
- Don't create partitions from Mass Storage Mode on Windows (because ABL will break with blank/spaces in names), your phone may be irrecoverable otherwise
- If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.
- Don't rerun the commands if you interrupt the process. You may break your partition table. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.
- Do not run all commands at once. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.
- Do not commit *any* typo with *any* commands. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.
- Be familiar with command line interfaces. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.
- When using TWRP, it is normal and expected for the phone to be detected as a Xiaomi phone and for touch to not work.

**THIS WILL WIPE ALL YOUR ANDROID DATA**

We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
but this is **STILL IN PREVIEW** and things can go wrong.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

## What you will get 🛒
You will end up with both Android and Windows on your Surface Duo. Android and Windows will both split the internal storage (64GB and 64GB or 128GB and 128GB).

Android will boot normally, and you will have to use a PC to boot Windows when needed.

# Steps 🛠️
## Unlocking the bootloader
- Backup all your data. **_You will lose everything you have on Android and will start from scratch_**.

- In Android settings, enable the Developer Settings menu (7 consecutive taps on Build Number), and turn on "OEM Unlock" inside it.

Assuming your Surface Duo is booted to Android, plugged to your PC:

- Open a command prompt on your PC and run this command:
```
adb reboot bootloader
```
- You will be rebooted to Surface Duo's bootloader. From there:
```
fastboot flashing unlock
```

Your phone will wipe itself and reboot to the Out of Box Experience in Android (OOBE). From then:

- In Android settings, enable the Developer Settings menu (7 consecutive taps on Build Number), and turn on "OEM Unlock" inside it.

- Reboot back into the bootloader menu by running this command:

```
adb reboot bootloader
```

## Making the partitions
- Start by booting TWRP:

```
fastboot boot surfaceduo1-twrp.img
```

- Once inside TWRP, touch will not be working and the device will say it is locked. This is completely normal. Keep the phone plugged to your PC and do these commands ONE BY ONE WITH NO TYPO!:

```
adb push <path to surfaceduo1-parted that was downloaded earlier> /sdcard/
adb shell "mv /sdcard/surfaceduo1-parted /sbin/parted && chmod 755 /sbin/parted"
adb shell
```

- Now we are issuing commands directly from inside Surface Duo using the PC.

### Dangerous section

Anything in this section is DANGEROUS and may PERMANENTLY damage your phone if you do any step wrong. Please carefully read all warnings and all instructions and make NO MISTAKE. Do not proceed if late at night or tired.

!!!! Warning reminder !!!!

⚠️ Do not run all commands at once, instead run them one by one

⚠️ DO NOT MAKE ANY TYPO! Parted is a *very* delicate tool, you MAY BREAK YOUR DEVICE PERMANENTLY WITH BELOW COMMANDS IF YOU DO THEM WRONG!

⚠️ If you see any warning, or error, it is not normal. Contact us on telegram

⚠️ You can kill things if you do below's steps wrong

---

<details>
  <summary>If you want a different allocation split between Windows and Android, you can do so. Just be aware of the following:</summary>
  <p>

```
notmkpart win ntfs <REDACTED FOR EXAMPLE PURPOSES> 57344MB
notmkpart userdata ext4 57344MB <REDACTED FOR EXAMPLE PURPOSES>
```

The commands above work like this:

[tool name] [partition name in gpt] [file system] [starting offset in disk] [ending offset in disk]

So if you want to change the split, all you have to do is to change the "57344MB" in above's example in both commands.

  </p>
</details>

---

- Let's run parted and make the partitions (ONE BY ONE WITH NO TYPO!):

```
parted /dev/block/sda
print
```

**Make sure that the last partition listed is numbered 6. If it is not, below's commands may DESTROY your phone in a permanent manner**

Take note of original sizing, here it was 51.9MB -> 112GB (256GB variant: 51.9MB -> 240GB) and replace every occurence of 51.9MB and 112GB with your original sizing that *you noted down* (these may not differ, but if they do, replace them)

---

<details>
  <summary>Run these commands one by one for 128GB devices (Click to expand)</summary>
  <p>

__This command removes the userdata partition__

```
rm 6
```

__This command creates the EFI system partition for Windows. It is possible parted shows a warning message at this step saying the partition is not properly aligned for best performance. It is safe to ignore such warning__

```
mkpart esp fat32 51.9MB 564MB
```

__This command creates the Windows partition.__

```
mkpart win ntfs 564MB 57344MB
```

__This command creates the Android data partition back.__

```
mkpart userdata ext4 57344MB 112GB
```

__This command sets the ESP partition created earlier as an EFI system partition type.__

```
set 6 esp on
```

__This command leaves parted.__

```
quit
```

  </p>
</details>

---

<details>
  <summary>Run these commands one by one for 256GB devices (Click to expand)</summary>
  <p>

__This command removes the userdata partition__

```
rm 6
```

__This command creates the EFI system partition for Windows. It is possible parted shows a warning message at this step saying the partition is not properly aligned for best performance. It is safe to ignore such warning. (Note: to ignore in parted, just type 'i' (without the quotes))__

```
mkpart esp fat32 51.9MB 564MB
```

__This command creates the Windows partition.__

```
mkpart win ntfs 564MB 114688MB
```

__This command creates the Android data partition back.__

```
mkpart userdata ext4 114688MB 240GB
```

__This command sets the ESP partition created earlier as an EFI system partition type.__

```
set 6 esp on
```

__This command leaves parted.__

```
quit
```

  </p>
</details>

---

This will get you out of parted.

We have deleted partition 6, which was the Android userdata partition, and created 3 partitions: an esp partition which will contain the Windows boot files, 
a win partition that will have Windows, and the last one is the new userdata partition for Android, just smaller. 

Now let's make these partitions actually usable:

```
mkfs.fat -F32 -s1 /dev/block/sda6
mkfs.ntfs -f /dev/block/sda7
mke2fs -t ext4 /dev/block/sda8
mkdir /sdcard/espmnt && mount /dev/block/sda6 /sdcard/espmnt/
exit
```

- Let's load the files from DuoBoot.tar into Surface Duo, which will be needed to boot and reach Mass Storage Mode from the UEFI:

```
adb push <path to downloaded surfaceduo1-boot.tar> /sdcard/
adb shell "tar -xf /sdcard/surfaceduo1-boot.tar -C /sdcard/espmnt --no-same-owner" 
adb shell "mv /sdcard/espmnt/Windows/System32/Boot/ffuloader.efi /sdcard/espmnt/Windows/System32/Boot/ffuloader.efi.bak"
adb shell "cp /sdcard/espmnt/Windows/System32/Boot/developermenu.efi /sdcard/espmnt/Windows/System32/Boot/ffuloader.efi"
```

### End of the Dangerous section

## Going to Mass Storage

- Let's load the mass storage shell script in order to boot into Mass Storage from TWRP

```
adb push <path to downloaded surfaceduo1-msc.tar> /sdcard/
adb shell "tar -xf /sdcard/surfaceduo1-msc.tar -C /sdcard --no-same-owner" 
adb shell "chmod +x /sdcard/msc.sh" 
adb shell "/sdcard/msc.sh"
```

Surface Duo should now be in USB 3 SuperSpeed (or what the USB-IF currently calls it) Mass Storage Mode.

## Installing Windows

- Make sure you are in Mass Storage Mode, that your Surface Duo is plugged into your PC
- Mount the partitions you have created using diskpart and assign them some letters:

```
⚠️ THESE ARE NOT ALL COMMANDS. DISKPART COMMANDS VARY A LOT, SO THESE ARE SOME ROUGH INSTRUCTIONS. 
ACTUAL COMMANDS START WITH AN HASHTAG (which you will need to remove)
YOU DO NOT HAVE TO USE Y or X, THEY ONLY NEED TO BE FREE LETTERS. IF LETTERS DONT ASSIGN FINE, USE ANOTHER ONE.
IF ONE PARTITION IS ALREADY ASSIGNED, YOU ALSO DO NOT NEED TO ASSIGN IT AGAIN IF YOU DONT WANT TO.

# list disk
Find the Surface Duo Disk, and take note of the number.
# select disk <number>
# list partition
You will be able to recognize the partitions we made earlier by their size. take note of the ESP and WIN partition numbers.
# select partition <esp-partition-number>
# assign letter=Y:
# select partition <win-partition-number>
# assign letter=X:
```

- You will have two partitions loaded, one is the ESP partition, and the other is the Win partition. Take note of the letters you've used.

**_⚠️ WARNING: From now on we will assume X: is the Win partition and that Y: is the ESP partition for all the commands. Replace them correctly with what you previously picked or you will lose data on your PC._**

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

- Now we want to disable driver signature checks (otherwise Windows will throw a BSOD at boot) and enable the legacy boot manager:

```
bcdedit /store "Y:\EFI\Microsoft\BOOT\BCD" /set "{default}" testsigning on
```

## Optional: Enabling the Windows Bootmanager to access the Developer Menu

You might also want to add a boot entry to the Developer Menu, if you want it to be available when needed. You will get the Windows Bootmanager to show up at boot, and you will be able to choose if you want to boot Windows or the Developer Menu. This step is not required, but still highly recommended for now:

```
❕❕ THESE STEPS ARE NOT REQUIRED BUT HIGHLY RECOMMENDED ❕❕
bcdedit /store "Y:\EFI\Microsoft\BOOT\BCD" /create /application bootapp /d "Developer Menu"
# THE COMMAND ABOVE WILL PRINT A GUID, COPY IT
bcdedit /store "Y:\EFI\Microsoft\BOOT\BCD" /set "<GUID>" nointegritychecks on
bcdedit /store "Y:\EFI\Microsoft\BOOT\BCD" /set "<GUID>" path \Windows\System32\boot\developermenu.efi
bcdedit /store "Y:\EFI\Microsoft\BOOT\BCD" /set "<GUID>" inherit "{bootloadersettings}"
bcdedit /store "Y:\EFI\Microsoft\BOOT\BCD" /set "<GUID>" device boot
bcdedit /store "Y:\EFI\Microsoft\BOOT\BCD" /displayorder "<GUID>" /addlast
bcdedit /store "Y:\EFI\Microsoft\BOOT\BCD" /set "{bootmgr}" displaybootmenu yes
```

- Once it is done, you can reboot your phone using ```adb reboot bootloader```. You will be able to boot to Android and your phone will work normally. Set it up if you need it.

You will be back into Surface Duo's bootloader. 

## [Temporary and Optional] Copy over calibration files/configuration files for the sensors

_These steps are temporary and will not be needed in future releases. These steps are also not as fully detailed as others and may get updated at a later time_

In order to get most sensors currently working, some manual steps are required.

You will need to backup from mass storage or twrp the following directory: /mnt/vendor/persist/sensors/ and copy over the contents to [Windows Drive Letter]\Windows\System32\Drivers\DriverData\QUALCOMM\fastRPC\persist\sensors (the following directory should already exist after booting Windows once, otherwise create it)

The ```persist``` partition should be accessible via mass storage but is formatted using ```EXT4```. In order to be able to read it from Windows without Linux, you may use ```7-zip```. Note down the disk number your device is using when connected in mass storage mode to your computer. You can also use TWRP or Android to get them if you find this easier or 7-zip does not work for you.

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

Let's boot the custom UEFI, from a command prompt:

```
fastboot boot surfaceduo1-uefi.img
```

This step above will be needed every time you will want to boot Windows and needs to be done from the Bootloader mode.

You should be thrown in the Boot Manager.

- Navigate with the volume up/down buttons to Mass Storage Mode or Windows, and press the Power Button to confirm.

If you did everything right, Windows will now boot! Enjoy!

## Enabling USB (Only if you get issues!)

The device can be controlled using an USB keyboard/mouse. An ethernet or WLAN USB device can also be connected to Surface Duo using USB. While USB-C is meant to be working properly by now, you might still need to force an override in case of issues. You can either use an USB-C hub, or an USB A hub provided you use a dongle. To force USB host mode on Surface Duo regardless of USB detection follow the instructions below.

Still assuming that X: is the mounted Surface Duo Windows partition, in a command prompt:

```
reg load HKLM\RTS X:\Windows\System32\config\SYSTEM
```

Now open regedit.exe and go to this registry key:

```
HKEY_LOCAL_MACHINE\RTS\ControlSet001\Control\USB

OsDefaultRoleSwitchMode
```

- Set the registry value to `1`

Close regedit, and back to the command prompt:

```
reg unload HKLM\RTS
```

If USB still doesn't appear to work, reboot the device, remount the registry hive and see if `RoleSwitchMode` is present, if it is, set it to `1`.

## Additional Context and Notes

If you somehow break entirely your partition table, you might be interested in the original offsets of each partition in order to fix it.

```
mkpart ssd 6s 7s
mkpart persist ext4 8s 8199s
mkpart metadata ext4 8200s 12295s
mkpart frp 12296s 12423s
mkpart misc 12424s 12679s
```

The offsets are valid for both the Surface Duo 1 128GB model, and the Surface Duo 1 256GB model. They do not include userdata. You will have to recreate this yourself.

(NEVER RUN THESE COMMANDS IF YOU DO NOT NEED TO OR YOU ALREADY PARTITIONS IN PLACE, ADVANCED USERS ONLY, YOU MAY KILL YOUR PHONE HERE)
