# Install Windows on Surface Duo
## Files/Tools Needed 📃
- TWRP image: [twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows-Files/twrp.img)
- Parted: [parted](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows-Files/parted)
- Boot package: [DuoBoot.tar](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows-Files/DuoBoot.tar)
- Custom UEFI: [boot.img](https://github.com/WOA-Project/SurfaceDuoPkg/releases/)
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- An ARM64 Windows build of your choice (specifically the install.wim file). You can use [UUPMediaCreator](https://github.com/gus33000/UUPMediaCreator) for this. [Here's a guide on how to use it.](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/CreateWindowsISO.md)
- The driver set: [SurfaceDuo-Drivers-Full.zip](https://github.com/WOA-Project/SurfaceDuo-Drivers/releases/)
- A Windows PC to build the Windows ISO, apply it onto the phone from mass storage, add drivers to the installation, configure ESP

## Warnings ⚠️
Don't create partitions from Mass Storage Mode (because ABL will break with blank/spaces in names)

**THIS WILL WIPE ALL YOUR ANDROID DATA**

We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
but this is **AN EARLY PREVIEW** and things can go wrong.

As of now, the 256GB are not supported by the dev team, but testing has shown it is compatible. The size of the Windows system will be larger. 
128GB devices have full support.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

## What you'll get 🛒
You'll end up with both Android and Windows on your Duo. Android and Windows will both split the 128GB memory (64GB and 64GB). _For the 256GB Model, the 256GB storage will be split (128GB, 128GB)._

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
- _For 256GB devices, it will be 51.9MB -> 240GB_

- Run these commands for 128GB devices:
```
rm 6
mkpart esp fat32 51.9MB 300MB
mkpart win ntfs 300MB 57344MB
mkpart userdata ext4 57344MB 112GB
set 6 esp on
quit
```

- Run these commands for 256GB devices:

```
rm 6
mkpart esp fat32 51.9MB 300MB
mkpart win ntfs 300MB 114688MB
mkpart userdata ext4 114688MB 240GB
set 6 esp on
quit
```

This will get you out of parted.

We have deleted partition 6, which was the Android userdata partition, and created 3 partitions: an esp partition which will contain the Windows boot files, 
a win partition that will have Windows, and the last one is the new userdata partition for Android, just smaller. 

<details>
  <summary>About the partition sizes (technical info, not part of the guide)</summary>
  <p>
    The esp partition was originally set to be from 51.9MB to 180MB. Some devices seem to hit a problem while creating that partitions which say that there 
    aren't enough sectors to create the file system. While 300MB seems a good ending point for everyone, it can be surely be lowered as it probably only wants 256MB of 
    total size. Feel free to test and change the size accordingly if you understand what you're doing.
  </p>
</details>

Now let's make these partitions actually usable:

```
mkfs.fat -F32 -s1 /dev/block/sda6
mkfs.ntfs -f /dev/block/sda7
mke2fs -t ext4 /dev/block/sda8
mkdir /sdcard/espmnt && mount /dev/block/sda6 /sdcard/espmnt/
exit
```

- Let's load the files from duoboot.tar into the Duo, which will be needed to boot and reach Mass Storage Mode:

```
adb push <path to DuoBoot.tar> /sdcard/
adb shell "tar -xf /sdcard/DuoBoot.tar -C /sdcard/espmnt --no-same-owner" 
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
⚠️ THESE ARE NOT ALL COMMANDS. DISKPART COMMANDS VARY A LOT, SO THESE ARE SOME ROUGH INSTRUCTIONS. 
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

**_⚠️ WARNING: From now on we'll assume X: is the Win partition and that Y: is the ESP partition for all the commands. Replace them correctly or you'll lose data on your PC._**

- We'll need our install.wim file now. If you haven't it already, you can [use this guide](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/CreateWindowsISO.md). When you're ready, run these commands:

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

- Now we want to disable driver signature checks (otherwise Windows will throw a BSOD at boot) and enable the legacy boot manager:

```
bcdedit /store Y:\EFI\Microsoft\BOOT\BCD /set {default} testsigning on
bcdedit /store Y:\EFI\Microsoft\BOOT\BCD /set {bootmgr} displaybootmenu yes
```

### Enabling the Windows Bootmanager to access the Developer Menu

You might also want to add a boot entry to the Developer Menu, if you want it to be available when needed. You'll get the Windows Bootmanager to show up at boot, and you'll be able to choose if you want to boot Windows or the Developer Menu. This step is not required, but still highly recommended for now:

```
❕❕ THESE STEPS ARE NOT REQUIRED BUT HIGHLY RECOMMENDED ❕❕
bcdedit /store Y:\EFI\Microsoft\BOOT\BCD /create /application bootapp /d "Developer Menu"
# THE COMMAND ABOVE WILL PRINT A GUID, COPY IT
bcdedit /store Y:\EFI\Microsoft\BOOT\BCD /set <GUID> nointegritychecks on
bcdedit /store Y:\EFI\Microsoft\BOOT\BCD /set <GUID> path \Windows\System32\boot\developermenu.efi
bcdedit /store Y:\EFI\Microsoft\BOOT\BCD /set <GUID> inherit {bootloadersettings}
bcdedit /store Y:\EFI\Microsoft\BOOT\BCD /set <GUID> device boot
bcdedit /store Y:\EFI\Microsoft\BOOT\BCD /displayorder <GUID> /addlast
```

- Once it's done, you can reboot your phone. You'll be able to boot to Android and your phone will work normally. Set it up if you need it.

### Boot Windows 🚀

We're ready to boot!

- Reboot your phone manually to the bootloader (keep the power button + vol down pressed until the Microsoft logo appears, then stop pressing the power
  button but keep pressing the volume down button).

From a command prompt:

```
fastboot boot boot.img
```

If you did everything right, Windows will now boot! Enjoy!

### Known Issues:

- ⚠️ You'll get a BSOD on your first boot of Windows. This is normal, as the post-installation setup tries to reboot your phone, but reboots aren't supported yet.
  Just boot Windows again and it should work.
- The bootloader will show "Windows 10" instead of "Windows 11" if you install Windows 11.


## Enabling USB

Still assuming that X: is the mounted Duo Windows partiton, in a command prompt:

```
reg load RTS X:\Windows\System32\config\SYSTEM
```

Now open regedit.exe and edit this registry key:

```
HKEY_LOCAL_MACHINE\RTS\ControlSet001\Control\USB

OsDefaultRoleSwitchMode
```

- Set the key to value `1`

Close regedit, and back to the command prompt:

```
reg unload RTS
```
