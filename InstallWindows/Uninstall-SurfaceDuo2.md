# Uninstall Windows and revert your Surface Duo 2 to stock

## Files/Tools Needed 📃
- TWRP image: [surfaceduo2-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo2-twrp.img)
- Parted: [parted](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/parted)
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- A PC.

> [!IMPORTANT]
> **THIS WILL WIPE ALL YOUR ANDROID™ DATA**
>
> We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
>
> but this is **STILL IN PREVIEW** and things can go wrong.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

If you caused modifications to Android™ system partitions and are not knowingly using Custom Trusted Boot certificates or do not know what we're talking about here but flashed a dual boot image onto your device, you need to revert this. Please see the dual boot guide for assistance first and foremost. Otherwise below's steps will brick your device.

## What you'll get 🛒

A normal Surface Duo, with Android™ only. Just like you had it before installing Windows. If you haven't broke anything else in the meantime.

Android™ will have access to the whole memory back again.

## Steps 🛠️

### Make sure you have not done any dual boot guide!

If you have followed a guide to use dual boot, please first remove dual boot by following the uninstall section in the dual boot guide, this is important: [DualBoot](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/InstallWindows/DualBoot-SurfaceDuo.md)

### Going to the Bootloader menu

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

### Booting to TWRP

- Plug your phone to your PC, open a command prompt and start by typing the following text, but do not press enter just yet

```batch
fastboot boot
```

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/24c5ed51-4710-449d-a5dc-686f8da8ea47)

- Go find the surfaceduo2-twrp.img file you downloaded earlier, right click it, click "Copy Path"

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/3e8db3d5-44d0-4e6c-a7ef-674f86e82650)

- Then go back to the Command Prompt window we started writing text in previously, and simply, right click on it with your mouse (or long press if you're on a touch device), you should now see this:

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/e97d514b-a314-4faf-9622-75bdab066985)

- Now you can press enter

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/2e27f24c-5b12-476d-99d8-f11de5baa807)

You will now boot to TWRP. Reminder that touch doesn't work on TWRP for now, so you'll have to work through your PC.

### Restoring the original partitions

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

- Go find the parted file you downloaded earlier, right click it, click "Copy Path"

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
> Make sure that partitions 8, 9 and the last one are your esp, win and userdata partitions.
> If they aren't, you will end up damaging your device (potentially in a permanent manner), please contact us on telegram for assistance in such case.
> It is possible for you to see more partitions than esp, win, and userdata. Typically, some devices may have partitions for the Windows Recovery Environment after the win partition and then userdata.
> The following guidelines cover even above scenario, and can be followed safely, on both devices with just esp, win, and userdata, and the other devices, with esp, win, some recovery partitions, and userdata.
> What remains important is that these partitions start at index 8, and you see no other partition than the aforementioned esp, win, recovery environement or userdata partitions. If you do, please reach out to us on telegram for assistance.

> [!WARNING]
> The next command will wipe all your windows and Android™ data. Before continuing, if you have important documents, please make sure that you have backed everything up on both Android™ and Windows.

```bash
rm 8
rm 9
rm 10

# FOR 128GB DEVICES ONLY: ---
mkpart userdata ext4 401MB 110GB

# FOR 256GB DEVICES ONLY: ---
TODO: Please file an issue to help us!

# FOR 512GB DEVICES ONLY: ---
TODO: Please file an issue to help us!
```

__This command leaves parted.__

```bash
quit
```

This will get you out of parted.

Now let's make the userdata partition actually usable:

```bash
setenforce 0
mke2fs -t ext4 /dev/block/sda8
exit
```

- Once it is done, you can reboot your phone using ```adb reboot bootloader```. You will be able to boot to Android™ and your phone should work normally. In case it doesn't you likely messed up something above.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

- Once Android™ is confirmed booting, reboot back into the bootloader using ```adb reboot bootloader``` or by pressing Volume Down right at boot.

You will be back into Surface Duo's bootloader.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

### Relocking the Bootloader

⚠️⚠️⚠️ If you caused modifications to Android™ system partitions and are not knowingly using Custom Trusted Boot certificates or do not know what we're talking about here but flashed a dual boot image onto your device, you need to revert this. Please see the dual boot guide for assistance first and foremost. Otherwise below's steps will brick your device. ⚠️⚠️⚠️

- Reboot your Surface Duo to the Bootloader: Press Volume Down + Power until the Microsoft Corporation logo appears on the left, then release the power
  button and keep pressing the volume down button until the bootloader appears.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

- Run this command:

```batch
fastboot flashing lock
```

- Reboot your Surface Duo, and Android™ should boot.
