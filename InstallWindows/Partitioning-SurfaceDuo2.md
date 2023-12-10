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

## Making the partitions

- Reboot into the Bootloader mode by running this command while inside Android™:

```batch
adb reboot bootloader
```

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

## Making the partitions

- Start by booting TWRP:

```batch
fastboot boot surfaceduo2-twrp.img
```

- Once inside TWRP, touch will not be working and the device will say it is locked. This is completely normal. Keep the phone plugged to your PC and do these commands ONE BY ONE WITH NO TYPO!:

```batch
adb shell "setenforce 0"
adb push <path to parted that was downloaded earlier> /sdcard/
adb push <path to downloaded surfaceduo2-twrp-fssupport.tar> /sdcard/
adb shell "mv /sdcard/parted /sbin/parted && chmod 755 /sbin/parted"
adb shell "tar -xf /sdcard/surfaceduo2-twrp-fssupport.tar -C /sdcard/fssupport --no-same-owner"
adb shell "chmod 755 /sdcard/fssupport/*"
adb shell "mv /sdcard/fssupport/* /sbin/"
adb shell
```

- Now we are issuing commands directly from inside Surface Duo using the PC.

### Dangerous section

Anything in this section is DANGEROUS and may PERMANENTLY damage your phone if you do any step wrong. Please carefully read all warnings and all instructions and make NO MISTAKE. Do not proceed if late at night or tired.

> [!WARNING]
> !!!! Warning reminder !!!!
>
> ⚠️ Do not run all commands at once, instead run them one by one
>
> ⚠️ DO NOT MAKE ANY TYPO! Parted is a *very* delicate tool, you MAY BREAK YOUR DEVICE PERMANENTLY WITH BELOW COMMANDS IF YOU DO THEM WRONG!
>
> ⚠️ If you see any warning, or error, it is not normal. Contact us on telegram
>
> ⚠️ You can kill things if you do below's steps wrong

---

<details>
  <summary>If you want a different allocation split between Windows and Android™, you can do so. Just be aware of the following:</summary>
  <p>

```bash
notmkpart win ntfs <REDACTED FOR EXAMPLE PURPOSES> 57693MB
notmkpart userdata ext4 57693MB <REDACTED FOR EXAMPLE PURPOSES>
```

The commands above work like this:

[tool name] [partition name in gpt] [file system] [starting offset in disk] [ending offset in disk]

So if you want to change the split, all you have to do is to change the "57693MB" in above's example in both commands.

  </p>
</details>

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

__This command creates the EFI system partition for Windows. It is possible parted shows a warning message at this step saying the partition is not properly aligned for best performance. It is safe to ignore such warning__

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

__This command creates the EFI system partition for Windows. It is possible parted shows a warning message at this step saying the partition is not properly aligned for best performance. It is safe to ignore such warning__

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

Your phone will reboot to the Out of Box Experience in Android™ (OOBE). Set it up. From there:

- In Android™ settings, enable the Developer Settings menu (7 consecutive taps on Build Number), and turn on "USB debugging" inside it.

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