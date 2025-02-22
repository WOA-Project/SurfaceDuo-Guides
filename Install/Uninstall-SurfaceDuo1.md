# Uninstall Windows and revert your Surface Duo (1st Gen) to stock

This guide will help you go back to a normal Surface Duo, with Android™ only.

Just like you had it before installing Windows.

Android™ will have access to the whole memory back again.

Your data will be erased, please make backups if you need it before proceeding!

This guide works if you haven't broke anything else in the meantime.

If you broke anything, this guide wont help you and will likely make things worse.

Contact us instead for help!

## Files/Tools Needed

- TWRP image:

| File Name                                       | Target Device         |
|-------------------------------------------------|-----------------------|
| [surfaceduo1-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/surfaceduo1-twrp.img) | Surface Duo (1st Gen) |

- Parted: [parted](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/parted)
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- A PC.

## Disclaimers

> [!IMPORTANT]
> **THIS WILL WIPE ALL YOUR ANDROID™ DATA**
>
> We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
>
> but this is **STILL IN PREVIEW** and things can go wrong.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

If you caused modifications to Android™ system partitions and are not knowingly using Custom Trusted Boot certificates or do not know what we're talking about here but flashed a dual boot image onto your device, you need to revert this. Please see the dual boot guide for assistance first and foremost. Otherwise below's steps will brick your device.

# Steps

## Acquiring all files

<details>
    <summary>Here's how to acquire the Android SDK Platform Tools: <b>Click to expand</b></summary>
    <p>


First, start by going to the [Android Platform SDK download page](https://developer.android.com/studio/releases/platform-tools) on your computer.

![SDK-1-Top](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/4c1c3762-24d8-4150-ac69-670738eb62c1)

Once on the page, scroll a little bit down til you see the link to download the platform tools for Windows.

![SDK-2-Mid](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/cd14a232-4995-480f-a061-54507e83cf41)

Click on it, an EULA will open like below:

![SDK-3-EULA](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/16d6b7df-ab56-414c-b1a5-561ec6b3ae4e)

Scroll all the way down (after reading it if that's your thing)

![SDK-4-EULA-Bottom](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/1368b2b0-74b8-4a7c-9aff-df2ca25c2f42)

Tick "I have read and agree to above terms conditions"

![SDK-5-EULA-TICK (alt)](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/02905fa2-64b8-426b-b42f-c1bb88eaa88a)

And click download

![SDK-5-EULA-TICK](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/0983f27a-76e7-4fda-ac4d-adaa56702e90)

Save the file on your computer, and extract the zip file by opening it, and selecting extract all.

![SDK-6-DL](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/adc1bba0-6118-418e-9005-e2db12860893)

  </p>
</details>

## Make sure you have not done any dual boot guide!

If you have followed a guide to use dual boot, please first remove dual boot by following the uninstall section in the dual boot guide, this is important: [DualBoot](/Install/DualBoot.md)

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
> at the following location, you will have to install them using Device Manager on your PC. [Download USB Drivers](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/USB-Drivers.zip)

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

You will now boot to TWRP. Reminder that touch doesn't work on TWRP for now, so you'll have to work through your PC.

## Restoring the original partitions

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

- Let's now run parted:

```bash
parted /dev/block/sda
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/94775441-8ffc-4fd5-bcdb-872704268078)

- And let's execute parted's print command:

```bash
print
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/34483136-05a4-4235-9fe4-347ec4da6ef1)

You'll get a list of partitions.

> [!CAUTION]
> Make sure that partitions 6, 7 and the last one are your esp, win and userdata partitions.
> If they aren't, you will end up damaging your device (potentially in a permanent manner), please contact us on telegram for assistance in such case.
> It is possible for you to see more partitions than esp, win, and userdata. Typically, some devices may have partitions for the Windows Recovery Environment after the win partition and then userdata.
> The following guidelines cover even above scenario, and can be followed safely, on both devices with just esp, win, and userdata, and the other devices, with esp, win, some recovery partitions, and userdata.
> What remains important is that these partitions start at index 6, and you see no other partition than the aforementioned esp, win, recovery environement or userdata partitions. If you do, please reach out to us on telegram for assistance.

> [!WARNING]
> The next command will wipe all your windows and Android™ data. Before continuing, if you have important documents, please make sure that you have backed everything up on both Android™ and Windows.

- First, in above print command, locate every partition that exist after the "misc" partition, as we can see, for us, they are esp, win, and userdata, you may have the same ones, but you may also see, esp, win, "other partitions", and userdata. These other partitions can be the windows recovery environement, but please make sure they aren't anything else. You should not be seeing partitions named "ssd", "persist", "metadata", "frp", or "misc" starting from index 6 all the way to the end. If you do, please reach out and do not continue with this guide.

Here's an example of what we're keeping an eye on here for our example (remember, for you it may be different but likely not) highlited inside a red rectangle:

![Image Of win/esp/userdata](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/47bd99c0-bfa9-46b7-994c-139bcc6224ae)

All partitions from index 6, to the end here, must be removed, so let's proceed with removing each, in our case, we want to remove the esp partition (number 6), the win partition (number 7), and the userdata partition (number 8).

- Let's start from number 6 (esp)

```bash
rm 6
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/399d5c05-87c9-4e63-a019-ad66ab3df6a8)

- Then number 7 (win)

```bash
rm 7
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/ad669d20-598e-4057-ada3-4bb4e8a5d312)

- And lastly, for us, the last index, number 8 (userdata)

```bash
rm 8
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/07107d91-387e-47ee-8759-50b4b3431644)

- Now that we have removed all partitions from index 6 to the last one, let's recreate user data.

- If you have a 128GB Surface Duo model, run the following command:

```bash
mkpart userdata ext4 51.9MB 112GB
```

- If you have a 256GB Surface Duo model, run the following command:

```bash
mkpart userdata ext4 51.9MB 240GB
```

In our case we have a 256GB Surface Duo model, so we're running the second command, like so:

![Image Of userdata creation](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/e174eee8-6dde-41b6-b5d0-d45afffba0a0)

As you can see, parted notifies us the partition may not be aligned for best performance, if you get such warning as well, simply enter i like so:

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/024ccc49-f51d-4e56-a897-e26be304720b)

- Let's now run the print command:

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/9a48aac1-9e7a-4925-ad3c-855aefbc35a9)

Please confirm that you see the exact same thing as we do above, except the total storage capacity. If you do not, your device may permanently be damaged if you reboot or turn it off now. Please reach out as soon as you can to prevent rendering your device a paper weight to telegram for assistance, and remain calm and patient.

- Let's now leave parted after confirming we did well previously:

```bash
quit
```

This will get you out of parted and back to the device shell.

![Image Of device shell after parted quit](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/486b864f-5754-4dcd-8fdc-b0570576908e)

- Now let's make the userdata partition actually usable:

```bash
mke2fs -t ext4 /dev/block/sda6
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/db1a81de-db10-4912-87f2-c639c5abcaa2)

- As you can see, mke2fs notifies us, the previous partitions (esp) is here, simply confirm by answering "y" like so:

 ![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/ff4941d5-3566-4514-8826-c2640f957655)

- And leave the device shell

```bash
exit
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/ba4bd37e-a8c8-4f08-9d50-026c11ebd740)

- Once it is done, you can reboot your phone using ```adb reboot```. You will be able to boot to Android™ and your phone should work normally. In case it doesn't you likely messed up something above.

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/b29403a5-3dbf-4151-91cf-467dcc4e5c54)

- You should now be seeing the Android™ Out of Box Experience (OOBE). Setup your phone to confirm it works correctly if you need it.

![Android™ - OOBE](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/5f86cbbe-df08-4ba6-92aa-b7fd2a7f72b3)

- Once your phone is confirmed working, congratulations, you successfully uninstalled Windows from your device.

You may however want to also relock the bootloader of the device, please note that you cannot relock the bootloader of your device if you flashed a custom rom as well as installed Windows before, or modified the boot partition for dual boot, or other purposes. Please look into undoing such changes before proceeding forward.

## In order to relock the bootloader

Follow the [Restoring Bootloader](RestoringBootloader.md) Guide

---

_**© 2020-2025 The Duo WOA Authors**_

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

_**Limited emergency calling**_

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

_**Hello from Seattle (US), France, Italy.**_