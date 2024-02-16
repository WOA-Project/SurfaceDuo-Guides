# Partitioning Surface Duo 2

## Files/Tools Needed 📃

- TWRP image: [surfaceduo2-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo2-twrp.img)
- Parted: [parted](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/parted)
- File System Support Package for TWRP image: [surfaceduo2-twrp-fssupport.tar](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo2-twrp-fssupport.tar)
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- A Windows PC

> [!WARNING]
> - Don't create partitions from Mass Storage Mode on Windows (because ABL will break with blank/spaces in names), your phone may be irrecoverable otherwise
> - If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.
> - Don't rerun the commands if you interrupt the process. You may break your partition table. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.
> - Do not run all commands at once. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.
> - Do not commit *any* typo with *any* commands. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.
> - Be familiar with command line interfaces. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.
> - When using TWRP, it is normal and expected for the phone to be detected as an Asus phone and for touch to not work.

> [!IMPORTANT]
> **THIS WILL WIPE ALL YOUR ANDROID™ DATA**
>
> We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
>
> but this is **STILL IN PREVIEW** and things can go wrong.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

## What you will get 🛒

You will end up with both Android™ and Windows on your Surface Duo. Android™ and Windows will both split the internal storage (64GB and 64GB or 128GB and 128GB or 256GB and 256GB).

Android™ will boot normally, and you will have to use a PC to boot Windows when needed, unless you create a dual boot image (explained later).

# Steps 🛠️

## Going to the Bootloader menu

- Start by turning on your Surface Duo into Android™, and unlock it

- Open a command prompt on your PC

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/ab36aa10-6617-4680-ac06-bb58b7a0c3bb)

- Go to the folder where you extracted the Google Android™ Platform tools using the CD command and the path of the folder, like so:

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/24760f21-dc1b-48e6-9ae3-0aeb16f8953c)

- Run the following command to ensure your phone is detected by your PC

```batch
adb devices
```

> [!TIP]
> If you see no device listed, check for updates in Windows Update, you likely have a Driver Update pending so the phone is recognized, when you're good to go, you should see the following image below this notice.
> It is possible certain computers see no update offered (like Windows ARM64 Computers or other older machines with no functional Windows Update). If this is your case, we also provide Drivers for you to download
> at the following location, you will have to install them using Device Manager on your PC. [Download USB Drivers](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/USB-Drivers.zip)

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/b3a8b091-1b34-47e4-bd6e-c286ee808f14)

- Run the following command now

```batch
adb reboot bootloader
```

You will be rebooted to Surface Duo's bootloader.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

## Booting to TWRP

- Plug your phone to your PC, open a command prompt and start by typing the following text, but do not press enter just yet

```batch
fastboot boot
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/24c5ed51-4710-449d-a5dc-686f8da8ea47)

- Go find the surfaceduo2-twrp.img file you downloaded earlier, right click it, click "Copy as path"

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/3e8db3d5-44d0-4e6c-a7ef-674f86e82650)

- Then go back to the Command Prompt window we started writing text in previously, and simply, right click on it with your mouse (or long press if you're on a touch device), you should now see this:

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/e97d514b-a314-4faf-9622-75bdab066985)

- Now you can press enter

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/2e27f24c-5b12-476d-99d8-f11de5baa807)

You will now boot to TWRP. Touch will not be working and the device will say it is locked. This is completely normal. Keep the phone plugged to your PC and continue along.

## Preparing TWRP

- Once booted into TWRP, start by running the following command to make sure everything we do is accepted by the device:

```batch
adb shell "setenforce 0"
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/80cd7c2f-e6e0-4078-9445-3fe245c5d0ca)

- Now, let's copy parted onto the device, first, start by typing the following text, but do not press enter just yet

```batch
adb push
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/e318851b-aac0-460b-be26-d5d40f4dfb67)

- Go find the parted file you downloaded earlier, right click it, click "Copy as path"

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/947f8fc2-4d55-4fad-8507-615e8257b537)

- Then go back to the Command Prompt window we started writing text in previously, and simply, right click on it with your mouse (or long press if you're on a touch device), you should now see this:

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/d422e848-fbcc-4871-85b2-db64b3347cf3)

- And now, continue to write the rest of the command, like so:

```batch
 /sdcard/
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/75736db7-475f-4c3d-94af-d7d3ac5e3b5a)

- Now you can press enter

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/fe732f9b-d5fd-4049-863b-047a94013e31)

- Now let's install parted correctly onto the TWRP image, by running the following command

```batch
adb shell "mv /sdcard/parted /sbin/parted && chmod 755 /sbin/parted"
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/787b7ae3-8fdf-43cd-9d06-341c5615f930)

- Now, let's install some support files we'll need:

```batch
adb push <path to downloaded surfaceduo2-twrp-fssupport.tar> /sdcard/
adb shell "tar -xf /sdcard/surfaceduo2-twrp-fssupport.tar -C /sdcard/fssupport --no-same-owner"
adb shell "chmod 755 /sdcard/fssupport/*"
adb shell "mv /sdcard/fssupport/* /sbin/"
```

- Now, let's open a shell onto the device, by running the following command

```batch
adb shell
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/972acc7b-6d28-40eb-883e-81c70cf9ad43)

- Now we are issuing commands directly from inside Surface Duo using the PC.

## Making the partitions

### Dangerous section

Anything in this section is DANGEROUS and may PERMANENTLY damage your phone if you do any step wrong. Please carefully read all warnings and all instructions and make NO MISTAKE. Do not proceed if late at night or tired or drunk (yes, we're serious).

> [!WARNING]
> !!!! Warning reminder !!!!
>
> ⚠️ Do not run all commands at once, instead run them one by one
>
> ⚠️ DO NOT MAKE ANY TYPO! Parted is a *very* delicate tool, you MAY BREAK YOUR DEVICE PERMANENTLY WITH BELOW COMMANDS IF YOU DO THEM WRONG!
>
> ⚠️ If you see any warning, or error, it is not normal. Contact us on telegram
>
> ⚠️ You can kill your phone permanently if you do below's steps wrong, for real.
>
> ⚠️ DO NOT, UNDER ANY CIRCUMSTANCES, RERUN, ANY, OF BELOW'S COMMANDS, EVEN IF A SINGLE ONE. DOING THIS WILL PERMANENTLY CAUSE HAVOC TO YOUR DEVICE. DO. NOT. RERUN. ANY. OF. THESE. COMMANDS. AFTER. RUNNING. ANY. SINGLE. ONE. OF. THEM. ONCE. You can rerun them __only__ if you completed the installation, and followed the uninstall guide, never if you messed up anything, or didn't proceed with the uninstall guide yet.
>
> ⚠️ If you end up messing up, or "forgetting" to run a command, DO NOT RERUN ANYTHING. CONTACT US IMMEDIATELY ON TELEGRAM. EXPLAIN WHAT YOU DID. POST A SCREENSHOT OF THE "print" PARTED COMMAND OUTPUT DONE LAST TO KNOW THE CURRENT STATUS AND NOT THE ONE PRIOR TO 20 OTHER COMMANDS.

---

- Let's run parted and make the partitions (ONE BY ONE WITH NO TYPO!):

```bash
setenforce 0
parted /dev/block/sda
print
```

**Make sure that the last partition listed is numbered 8. If it is not, below's commands may DESTROY your phone in a permanent manner**

Take note of original sizing, here it was 401MB -> 110GB (256GB variant: 401MB -> XXXGB TODO (Please file an issue so we know!)) (512GB variant: 401MB -> XXXGB TODO (Please file an issue so we know!)) and replace every occurence of 401MB and 110GB with your original sizing that *you noted down* (these may not differ, but if they do, replace them)

---

<details>
  <summary>Run these commands one by one for 128GB devices (Click to expand)</summary>
  <p>

__This command removes the userdata partition__

```bash
rm 8
```

__This command creates the EFI system partition for Windows. It is possible parted shows a warning message at this step saying the partition is not properly aligned for best performance. It is safe to ignore such warning. (Note: to ignore in parted, just type 'i' (without the quotes))__

```bash
mkpart esp fat32 401MB 674MB
```

__This command creates the Windows partition.__

```bash
mkpart win ntfs 674MB 69394MB
```

__This command creates the Android™ data partition back.__

```bash
mkpart userdata ext4 69394MB 110GB
```

__This command sets the ESP partition created earlier as an EFI system partition type.__

```bash
set 8 esp on
```

__This command leaves parted.__

```bash
quit
```

  </p>
</details>

---

<details>
  <summary>Run these commands one by one for 256GB devices (Click to expand)</summary>
  <p>

__This command removes the userdata partition__

```bash
rm 8
```

__This command creates the EFI system partition for Windows. It is possible parted shows a warning message at this step saying the partition is not properly aligned for best performance. It is safe to ignore such warning. (Note: to ignore in parted, just type 'i' (without the quotes))__

```bash
mkpart esp fat32 401MB 674MB
```

__This command creates the Windows partition.__

```bash
mkpart win ntfs 674MB 138113MB
```

__This command creates the Android™ data partition back.__

```bash
mkpart userdata ext4 138113MB 238GB
```

__This command sets the ESP partition created earlier as an EFI system partition type.__

```bash
set 8 esp on
```

__This command leaves parted.__

```bash
quit
```

  </p>
</details>

---

<details>
  <summary>Run these commands one by one for 512GB devices (Click to expand)</summary>
  <p>

TODO: Please file an issue to help us!

  </p>
</details>

---

This will get you out of parted.

We have deleted partition 8, which was the Android™ userdata partition, and created 3 partitions: an esp partition which will contain the Windows boot files,
a win partition that will have Windows, and the last one is the new userdata partition for Android™, just smaller.

Now let's make these partitions actually usable:

```bash
setenforce 0
mkfs.fat -F32 -s1 /dev/block/sda8
mkfs.ntfs -f /dev/block/sda9
mke2fs -t ext4 /dev/block/sda10
exit
```

### End of the Dangerous section

## Rebooting into Android

Now, reboot into Android again:

```batch
adb reboot
```

- You should now be seeing the Android™ Out of Box Experience (OOBE). Setup your phone to confirm it works correctly.

![Android™ - OOBE](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/5f86cbbe-df08-4ba6-92aa-b7fd2a7f72b3)

Congratulations, you successfully partitioned your device.

- Assuming your Surface Duo is booted to Android™, plugged to your PC

- Using the Microsoft Launcher, find the settings app

![A1 Android™ - Open Settings](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/36ef925c-fe98-4ec6-9861-c1037d8ced19)

- Open the Android™ Settings app

![A2 Android™ - Settings Opened](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/02b78630-d2b2-4211-abe1-c89255fe9bc6)

- Scroll down to the about section, and open it

![A3 Android™ - Settings About](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/0dad0ac3-21f3-42fd-a02c-78e9eb399118)

- Scroll all the way down til you see the Build Number field

![A4 Android™ - Settings About Down](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/afac2404-9624-4298-9785-b6a21bc31699)

- Press the Build number field 7 times consecutively, you should first start to see a popup after 3 taps

![A5 Android™ - Settings About Down Tap Dev](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/b850bef7-2938-47a0-b781-c54178e3cf7d)

- Once done tapping 7 times, you should be seeing this popup instead

![A6 Android™ - Settings About Down Tap Dev Done](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/8afef456-00a4-41e7-9653-c91a901e16c1)

- Now go to the System section, you should see a new Developer options section like shown below

![A7 Android™ - Settings System with Dev](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/a2de44f2-b492-450a-830a-5e7141e232b7)

- Go to the Developer options section

![Android™ Settings System Dev Options](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/ffbbcee9-98ab-4b83-8eaa-57487c1c1cf0)

- Scroll all the way down til you see the "USB debugging" option

![Android™ Settings - Dev - Debugging Option](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/3847fdcb-c19c-4c5d-aa4c-00a60e85c2b0)

- And turn on the "USB debugging" option

![Android™ Settings - Dev - Debugging Option Confirmation](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/60b52b98-8c6a-4845-833d-470378206fb2)

## The End

And we're done, please continue to [Installing Windows](InstallWindows-SurfaceDuo2.md)

---

<details>
  <summary>Additional Context and Notes</Summary>
  <p>

If you somehow break entirely your partition table, you might be interested in the original offsets of each partition in order to fix it.

```bash
mkpart ssd 6s 7s
mkpart persist 8s 8199s
mkpart metadata 8200s 12295s
mkpart frp 12296s 12423s
mkpart misc 12424s 12679s
mkpart rawdump 12680s 89479s
mkpart vm-data 89480s 97835s
```

The offsets are valid for both the Surface Duo 2 128GB model, and the Surface Duo 2 256GB model, and the Surface Duo 2 512GB model. They do not include userdata. You will have to recreate this yourself.

(NEVER RUN THESE COMMANDS IF YOU DO NOT NEED TO OR YOU ALREADY PARTITIONS IN PLACE, ADVANCED USERS ONLY, YOU MAY KILL YOUR PHONE HERE)

  </p>
</details>

---

_**© 2020-2024 The Duo WOA Authors**_

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

_**Limited emergency calling**_

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

_**Hello from Seattle (US), France, Italy.**_