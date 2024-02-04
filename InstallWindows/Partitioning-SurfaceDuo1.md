# Partitioning Surface Duo (1st Gen)

## Files/Tools Needed 📃

- TWRP image: [surfaceduo1-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo1-twrp.img)
- Parted: [parted](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/parted)
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- A Windows PC
- The Partition Offsets Helper tool: [PartitionOffsetsHelperTool.exe](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/PartitionOffsetsHelperTool.exe)

> [!WARNING]
> - Don't create partitions from Mass Storage Mode on Windows (because ABL will break with blank/spaces in names), your phone may be irrecoverable otherwise
> - If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.
> - Don't rerun the commands if you interrupt the process. You may break your partition table. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.
> - Do not run all commands at once. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.
> - Do not commit *any* typo with *any* commands. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.
> - Be familiar with command line interfaces. Parted is a very *delicate* tool, anything you do may cause permanent damage to your device.
> - When using TWRP, it is normal and expected for the phone to be detected as a Xiaomi phone and for touch to not work.

> [!IMPORTANT]
> **THIS WILL WIPE ALL YOUR ANDROID™ DATA**
>
> We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
>
> but this is **STILL IN PREVIEW** and things can go wrong.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

## What you will get 🛒

You will end up with both Android™ and Windows on your Surface Duo. Android™ and Windows will both split the internal storage (64GB and 64GB or 128GB and 128GB).

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

- Go find the surfaceduo1-twrp.img file you downloaded earlier, right click it, click "Copy as path"

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

- Now, let's open a shell onto the device, by running the following command

```batch
adb shell
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/972acc7b-6d28-40eb-883e-81c70cf9ad43)

- Now we are issuing commands directly from inside Surface Duo using the PC.

## Making the partitions

### Dangerous section

> [!WARNING]
> This section if followed incorrectly could make your device unusable and require dedicated fixing steps that would be better given through assistance within our telegram channel.
>
> Please carefully follow every step, and try to not commit typos by missing numbers or characters, as those may make the device unusable.
>
> Further more, rerunning these commands after running them once ever can also damage your device, so do not refollow this section ever again.
>
> You can only refollow such instructions when you have followed our uninstall guide first.
>
> A warning or unexpected message is, well, unexpected, contact us if you see one, and do not attempt to fix anything by yourself.
>
> Flashing a Microsoft provided "recovery" package will not help you recover from such failures, and may even make matters worse. Contact us instead.

- Let's now run parted:

```bash
parted /dev/block/sda
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/94775441-8ffc-4fd5-bcdb-872704268078)

- Let's now run a specific unit command:

```bash
unit s
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/0fe3ffc5-6924-42fd-8a99-5a712c9d55cf)

- And let's execute parted's print command:

```bash
print
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/bc8e7c3a-a7e2-4fe0-8944-958b5c05ff1d)

You'll get a list of partitions.

**Make sure that the last partition listed is numbered 6. If it is not, below's commands may damahe your phone. Contact us if that's your case**

Take note of original sizing value of the userdata, we highlighted the given for you below, you will need it shortly.

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/f6024cc3-4ca7-4438-ac68-05ec76f5193c)

- Now run the Partition Offsets Helper Tool you downloaded earlier (PartitionOffsetsHelperTool.exe) by double clicking on it

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/67479178-3371-4b46-8f47-6047b77ad9d1)

- Answer whenever or not your device is a 128GB model or 256GB model (Y = 128GB, N = 256GB)

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/7816ca59-c604-49c0-8306-fbec383d939e)

- Answer which total storage capacity you want to give to Android

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/030c9802-cefc-4d4e-849a-2303d6dcbfb2)

- Now select with your mouse all 3 commands

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/f88f0ff5-88a2-4753-8424-f72235c0ec9c)

- Right click on the command prompt, the selection will vanish and no menu will show, this is expected

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/9c836619-ddd2-47d4-af4f-4c18d84d91cb)

- Open Notepad

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/0e8b297d-46d1-4630-b18c-179cbf59bac5)

- Paste all of them here

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/2ad6b7c1-3c9c-4f15-ab27-3de1b628195e)

- Edit the highlighted value below with the one you noted earlier, replacing it fully, here's a before for us:

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/537b6cce-4e83-4749-aeeb-6106281e10e3)

- And here's after the edit:

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/f1b31d9f-93c1-48b1-b57b-ea9b8feb8ffc)

It is possible both values are the same, do not worry about it if that's the case, above, we intentionally showed different values as well to illustrate

- Go back to the Partition Offsets Helper Tool window/command prompt

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/5698c1b9-2f2d-464c-bfc8-e6735781ba80)

- Press enter, the window will exit.

- Go back to the parted window/command prompt

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/b816c5d3-8f97-4e25-9e80-f89e37a8088f)

- Run the following command first

__This command removes the userdata partition__

```bash
rm 6
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/7fadcbe9-417f-4b1e-ad01-a327ad5549a5)

- Now come back to Notepad

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/004b0b9c-b787-4120-8e82-f9d34a4941ee)

- Copy the first command

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/262bc3c6-642f-435f-a5f7-83b72ac98341)

- Paste it with right click onto the parted window, and press enter

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/6b562673-4a63-4173-be65-576faba91465)

It is possible that parted says the partition is not aligned for best performance, if that's the case for you, ignore such warning by answering "i" like so:

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/c628c986-4961-4f4a-a9ba-c1b0c9020fe1)

- Copy the second command

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/f1866b37-796e-4197-b116-cd3b067eb76e)

- Paste it with right click onto the parted window, and press enter

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/6ca1e25c-cce5-474a-9383-5a837a2246f5)

- Copy the third command

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/e6141946-6515-42a4-9200-015c6faa619c)

- Paste it with right click onto the parted window, and press enter

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/a9b80c43-21fe-42bc-aab3-4c2cee0b48a2)

It is possible that parted says the partition is not aligned for best performance, if that's the case for you, ignore such warning by answering "i" again

- Run the following command

__This command sets the ESP partition created earlier as an EFI system partition type.__

```bash
set 7 esp on
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/544c0071-3c58-4e8b-94ad-134537b69945)

- Run the following command to sanity check what you did:

```bash
print
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/ed74fafd-509f-46d8-b8a5-4466b48bc0a2)

If this looks good, proceed to below's step, if something looks horribly wrong, contact us.

- Run the following command

__This command leaves parted.__

```bash
quit
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/89ebd6fe-bcd8-4e83-a5bf-1dec1a627e2d)

This will get you out of parted.

We have deleted partition 6, which was the Android™ userdata partition, and created 3 partitions: the new userdata partition for Android™, just smaller; an esp partition which will contain the Windows boot files; and the last one, a win partition that will have Windows.

Now let's make these partitions actually usable:

- Start with this command:

```bash
mke2fs -t ext4 /dev/block/sda6
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/d86116ef-710e-4082-8534-f7a4eee7f4bc)

- Then continue with this command:

```bash
mkfs.fat -F32 -s1 /dev/block/sda7
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/895da3c9-a86f-490e-9ca6-07b7a9bdd5d4)

- Then finish with this command:

```bash
mkfs.ntfs -f /dev/block/sda8
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/d7d76303-3a4c-4348-aee8-7da91623fadb)

- And let's exit the device shell

```bash
exit
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/05b8a148-f679-4832-9827-26131790868b)

### End of the Dangerous section

## Rebooting into Android

Now, reboot into Android again:

```batch
adb reboot
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/a0862e5e-8378-481e-929a-7d777d7978ec)

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

And we're done, please continue to [Installing Windows](InstallWindows-SurfaceDuo1.md)

---

<details>
  <summary>Additional Context and Notes</Summary>
  <p>

If you somehow break entirely your partition table, you might be interested in the original offsets of each partition in order to fix it.

```bash
mkpart ssd 6s 7s
```

```bash
mkpart persist ext4 8s 8199s
```

```bash
mkpart metadata ext4 8200s 12295s
```

```bash
mkpart frp 12296s 12423s
```

```bash
mkpart misc 12424s 12679s
```

The offsets are valid for both the Surface Duo (1st Gen) 128GB model, and the Surface Duo (1st Gen) 256GB model. They do not include userdata. You will have to recreate this yourself.

(NEVER RUN THESE COMMANDS IF YOU DO NOT NEED TO OR YOU ALREADY PARTITIONS IN PLACE, ADVANCED USERS ONLY, YOU MAY KILL YOUR PHONE HERE)

  </p>
</details>
