# Install Windows on Surface Duo 2

![Surface Duo 2 Dual Screen Windows](https://user-images.githubusercontent.com/3755345/197421028-afa8109a-ead9-46c9-985f-d0fac9e342ca.png)

## Table of Contents
1. [Files/Tools Needed](#filestools-needed-)
2. [Warnings ⚠️](#warnings-%EF%B8%8F)
3. [What you will get 🛒](#what-youll-get-)
4. [Steps 🛠️](#steps-%EF%B8%8F)

## Files/Tools Needed 📃
- A linux virtual machine with parted installed
- Expert knowledge of what you're doing (this is even more susceptible to bricks than the duo 1 guide, do not follow for now if you are not comfortable, this is very advanced still)
- Your stock boot image (from ota recovery package)
- Early Boot package: [surfaceduo2-bootpkg.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows-Files/surfaceduo2-bootpkg.img)
- Boot package: [surfaceduo2-boot.tar](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows-Files/surfaceduo1-boot.tar)
- Windows UEFI: [surfaceduo2-uefi.img](https://github.com/WOA-Project/SurfaceDuoPkg/releases/)
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- An ARM64 Windows build of your choice that meets the minimum system requirements (specifically the install.wim file). You can use [UUPMediaCreator](https://github.com/gus33000/UUPMediaCreator) for this. [Here's a guide on how to use it.](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/CreateWindowsISO.md)
- A Windows PC to build the Windows ISO, apply it onto the phone from mass storage, configure ESP

## Warnings ⚠️
- Don't create partitions from Mass Storage Mode on Windows (because ABL will break with blank/spaces in names), your phone may be irrecoverable otherwise
- If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.
- Don't rerun the commands if you interrupt the process. You may break your partition table. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.
- Do not run all commands at once. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.
- Do not commit *any* typo with *any* commands. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.
- Be familiar with command line interfaces. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.

**THIS WILL WIPE ALL YOUR ANDROID DATA**

We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
but this is **STILL IN PREVIEW** and things can go wrong.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

## What you will get 🛒
You will end up with both Android and Windows on your Surface Duo 2. Android and Windows will both split the internal storage (64GB and 64GB or 128GB and 128GB or 256GB and 256GB).

Android will boot normally, and you will have to use a PC to boot Windows when needed.

# Steps 🛠️
## Unlocking the bootloader
- Backup all your data. **_You will lose everything you have on Android and will start from scratch_**.

- In Android settings, enable the Developer Settings menu (7 consecutive taps on Build Number), and turn on "OEM Unlock" inside it.

Assuming your Surface Duo 2 is booted to Android, plugged to your PC:

- Open a command prompt on your PC and run this command:
```
adb reboot bootloader
```
- You will be rebooted to Surface Duo 2's bootloader. From there:
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

- Start by getting your current active slot:

```
fastboot getvar current-slot
```

Depending on your current device state, you will either get ```current-slot: a``` or ```current-slot: b```. For the rest of the guide, we will consider the current slot as "X" and the alternate slot as "!X"

- Flash the previously downloaded mass storage boot package to the opposite slot:

```
fastboot flash boot_<!X> surfaceduo2-bootpkg.img
```

### Booting the Custom UEFI

Let's boot the custom UEFI:

```
fastboot boot surfaceduo2-uefi.img
```

This step above will be needed every time you'll want to boot Windows.

You should be thrown in Developer Menu.

- Navigate with the volume up/down buttons to Mass Storage Mode, and press the Power Button to confirm. Once you're in Mass Storage Mode, we're ready to continue.

- From now, connect your Surface Duo 2 to your linux machine with parted

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

- Let's run parted and make the partitions (ONE BY ONE WITH NO TYPO!): (replace [Y] with the right sd file on your linux system for the LUN with userdata (the biggest one))

```
parted /dev/block/sd<Y>
print
```

**Make sure you do not have existing windows partitions or esp, or you will break things**

Take note of original sizing and create partitions with a 50% split of userdata as follows:

- Gather the id of the userdata partition (we'll refer to it now as [userdata id])

- Note down the userdata boundaries using ```print``` (we'll refer to them now as [start] and [stop])

__This command removes the userdata partition__

```
rm <userdata id>
```

__This command creates the EFI system partition for Windows. It is possible parted shows a warning message at this step saying the partition is not properly aligned for best performance. It is safe to ignore such warning__

```
mkpart esp fat32 <start in mb>MB <start in mb + 512>MB
```

__This command creates the Windows partition.__

```
mkpart win ntfs <start in mb + 512>MB <stop in mb divided in half>MB
```

__This command creates the Android data partition back.__

```
mkpart userdata ext4 <stop in mb divided in half>MB <stop in GB>GB
```

__This command sets the ESP partition created earlier as an EFI system partition type.__
Note: below's userdata id is the original one, now mapping to the esp partition

```
set <userdata id> esp on
```

__This command leaves parted.__

```
quit
```

---

This will get you out of parted.

We have deleted the Android userdata partition, and created 3 partitions: an esp partition which will contain the Windows boot files, 
a win partition that will have Windows, and the last one is the new userdata partition for Android, just smaller. 

Now let's make these partitions actually usable:

```
mkfs.fat -F32 -s1 /dev/block/sd<Y><userdata id>
mkfs.ntfs -f /dev/block/sd<Y><userdata id + 1>
mke2fs -t ext4 /dev/block/sd<Y><userdata id + 2>
mkdir /sdcard/espmnt && mount /dev/block/sd<Y><userdata id> /sdcard/espmnt/
exit
```

- Let's load the files from DuoBoot.tar into Surface Duo 2, which will be needed to boot and reach Mass Storage Mode from the UEFI:

```
tar -xf <path to downloaded surfaceduo2-boot.tar> -C /sdcard/espmnt --no-same-owner
mv /sdcard/espmnt/Windows/System32/Boot/ffuloader.efi /sdcard/espmnt/Windows/System32/Boot/ffuloader.efi.bak
cp /sdcard/espmnt/Windows/System32/Boot/developermenu.efi /sdcard/espmnt/Windows/System32/Boot/ffuloader.efi
```

### End of the Dangerous section

## Installing Windows

- Now plug back Surface Duo 2 into your Windows machine
- Mount the partitions you have created using diskpart and assign them some letters:

```
⚠️ THESE ARE NOT ALL COMMANDS. DISKPART COMMANDS VARY A LOT, SO THESE ARE SOME ROUGH INSTRUCTIONS. 
ACTUAL COMMANDS START WITH AN HASHTAG (which you will need to remove)
YOU DO NOT HAVE TO USE Y or X, THEY ONLY NEED TO BE FREE LETTERS. IF LETTERS DONT ASSIGN FINE, USE ANOTHER ONE.
IF ONE PARTITION IS ALREADY ASSIGNED, YOU ALSO DO NOT NEED TO ASSIGN IT AGAIN IF YOU DONT WANT TO.

# list disk
Find the Surface Duo 2 Disk, and take note of the number.
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
DriverUpdater.exe -d "<path to extracted drivers>\definitions\Desktop\ARM64\Internal\zeta.txt" -r "<path to extracted drivers>" -p X:\
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
bcdedit /store "Y:\EFI\Microsoft\BOOT\BCD" /set "<GUID>" inherit {bootloadersettings}
bcdedit /store "Y:\EFI\Microsoft\BOOT\BCD" /set "<GUID>" device boot
bcdedit /store "Y:\EFI\Microsoft\BOOT\BCD" /displayorder "<GUID>" /addlast
bcdedit /store "Y:\EFI\Microsoft\BOOT\BCD" /set "{bootmgr}" displaybootmenu yes
```

- Once it is done, you can reboot your phone by pressing the power button for a few seconds. You will be able to boot to Android and your phone will work normally. Set it up if you need it.

You will be back into Surface Duo 2's bootloader. 

## Restore original boot partition on the alternative slot

- Flash the stock boot.img to the opposite slot:

```
fastboot flash boot_<!X> boot.img
```

You will be back into Surface Duo 2's bootloader. 

## [Temporary and Optional] Copy over calibration files/configuration files for the sensors

_These steps are temporary and will not be needed in future releases. These steps are also not as fully detailed as others and may get updated at a later time_

In order to get most sensors currently working, some manual steps are required.

You will need to backup from mass storage or twrp the following directory: /mnt/vendor/persist/sensors/ and copy over the contents to [Windows Drive Letter]\Windows\System32\Drivers\DriverData\QUALCOMM\fastRPC\persist\sensors (the following directory should already exist after booting Windows once, otherwise create it)

The ```persist``` partition should be accessible via mass storage but is formatted using ```EXT4```. In order to be able to read it from Windows without Linux, you may use ```7-zip```. Note down the disk number your device is using when connected in mass storage mode to your computer. You can also use TWRP or Android to get them if you find this easier or 7-zip does not work for you.

Start 7-zip as administrator.

In 7-zip, enter the following into the address bar: ```\\.\```

Now open the ```PhysicalDriveX``` file matching your phone, where X is your disk number. You should be able to see persist and browse through it from 7-zip.

## Boot Windows 🚀

We are ready to boot!

Let's boot the custom UEFI, from a command prompt:

```
fastboot boot surfaceduo2-uefi.img
```

This step above will be needed every time you will want to boot Windows and needs to be done from the Bootloader mode.

You should be thrown in the Boot Manager.

- Navigate with the volume up/down buttons to Mass Storage Mode or Windows, and press the Power Button to confirm.

If you did everything right, Windows will now boot! Enjoy!

## Enabling USB (Only if you get issues!)

The device can currently only be controlled using an USB keyboard/mouse. An ethernet or WLAN USB device can also be connected to Surface Duo using USB. While USB-C is meant to be working properly by now, you might still need to force an override in case of issues. You can either use an USB-C hub, or an USB A hub provided you use a dongle. To force USB host mode on Surface Duo 2 regardless of USB detection follow the instructions below.

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

