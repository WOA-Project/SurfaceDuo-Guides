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

![image](TODO)

You'll get a list of partitions.

> [!CAUTION]
> Make sure that partitions 8, 9 and the last one are your esp, win and userdata partitions.
> If they aren't, you will end up damaging your device (potentially in a permanent manner), please contact us on telegram for assistance in such case.
> It is possible for you to see more partitions than esp, win, and userdata. Typically, some devices may have partitions for the Windows Recovery Environment after the win partition and then userdata.
> The following guidelines cover even above scenario, and can be followed safely, on both devices with just esp, win, and userdata, and the other devices, with esp, win, some recovery partitions, and userdata.
> What remains important is that these partitions start at index 8, and you see no other partition than the aforementioned esp, win, recovery environement or userdata partitions. If you do, please reach out to us on telegram for assistance.

> [!WARNING]
> The next command will wipe all your windows and Android™ data. Before continuing, if you have important documents, please make sure that you have backed everything up on both Android™ and Windows.

- First, in above print command, locate every partition that exist after the "misc" partition, as we can see, for us, they are esp, win, and userdata, you may have the same ones, but you may also see, esp, win, "other partitions", and userdata. These other partitions can be the windows recovery environement, but please make sure they aren't anything else. You should not be seeing partitions named "ssd", "persist", "metadata", "frp", or "misc" starting from index 8 all the way to the end. If you do, please reach out and do not continue with this guide.

Here's an example of what we're keeping an eye on here for our example (remember, for you it may be different but likely not) highlited inside a red rectangle:

![Image Of win/esp/userdata](TODO)

All partitions from index 8, to the end here, must be removed, so let's proceed with removing each, in our case, we want to remove the esp partition (number 8), the win partition (number 9), and the userdata partition (number 10).

- Let's start from number 8 (esp)

```bash
rm 8
```

![image](TODO)

- Then number 9 (win)

```bash
rm 9
```

![image](TODO)

- And lastly, for us, the last index, number 10 (userdata)

```bash
rm 10
```

![image](TODO)

- Now that we have removed all partitions from index 8 to the last one, let's recreate user data.

- If you have a 128GB Surface Duo model, run the following command:

```bash
mkpart userdata ext4 401MB 110GB
```

- If you have a 256GB Surface Duo model, run the following command:

```bash
TODO: Please file an issue to help us!
```

- If you have a 512GB Surface Duo model, run the following command:

```bash
TODO: Please file an issue to help us!
```

In our case we have a 128GB Surface Duo model, so we're running the first command, like so:

![Image Of userdata creation](TODO)

As you can see, parted notifies us the partition may not be aligned for best performance, if you get such warning as well, simply enter i like so:

![image](TODO)

- Let's now run the print command:

![image](TODO)

Please confirm that you see the exact same thing as we do above, except the total storage capacity. If you do not, your device may permanently be damaged if you reboot or turn it off now. Please reach out as soon as you can to prevent rendering your device a paper weight to telegram for assistance, and remain calm and patient.

- Let's now leave parted after confirming we did well previously:

```bash
quit
```

This will get you out of parted and back to the device shell.

![Image Of device shell after parted quit](TODO)

- Now let's make the userdata partition actually usable:

```bash
mke2fs -t ext4 /dev/block/sda8
```

![image](TODO)

- As you can see, mke2fs notifies us, the previous partitions (esp) is here, simply confirm by answering "y" like so:

 ![image](TODO)

- And leave the device shell

```bash
exit
```

![image](TODO)

- Once it is done, you can reboot your phone using ```adb reboot```. You will be able to boot to Android™ and your phone should work normally. In case it doesn't you likely messed up something above.

![image](TODO)

- You should now be seeing the Android™ Out of Box Experience (OOBE). Setup your phone to confirm it works correctly if you need it.

![Android™ - OOBE](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/5f86cbbe-df08-4ba6-92aa-b7fd2a7f72b3)

- Once your phone is confirmed working, congratulations, you successfully uninstalled Windows from your device.

You may however want to also relock the bootloader of the device, please note that you cannot relock the bootloader of your device if you flashed a custom rom as well as installed Windows before, or modified the boot partition for dual boot, or other purposes. Please look into undoing such changes before proceeding forward.

### In order to relock the bootloader

- Start by turning on your Surface Duo into Android™, and unlock it

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

- Turn on the OEM Unlock option as shown above, then, scroll all the way down til you see the USB Debugging option

![Android™ Settings - Dev - Debugging Option](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/3847fdcb-c19c-4c5d-aa4c-00a60e85c2b0)

- And turn on the USB Debugging option

![Android™ Settings - Dev - Debugging Option Confirmation](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/60b52b98-8c6a-4845-833d-470378206fb2)

Assuming your Surface Duo is booted to Android™, plugged to your PC:

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

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/f4db0f2e-40a1-4822-9675-41cd56ab5062)

- Your phone will ask for permission to authorize your computer to execute commands, accept it:

![Screenshot_20230811-024721](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/515c2f89-6a71-4e01-b3e1-94e4805cb69f)

- Now run the following command again, it should now work properly:

```batch
adb reboot bootloader
```

You will be rebooted to Surface Duo's bootloader.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

- From there:

```batch
fastboot flashing lock
```

- Confirm that you want to relock the bootloader using your device side buttons, your device will erase itself and restart into the Android™ Out of box Experience Again.
If your device doesn't go into Android™ but the bootloader menu, this means you performed additional modifications to your device previously, and you must undo them. You need to reunlock your device now using "fastboot flashing unlock", and undo them according to the instructions you or someone else provided you)

- You should now be seeing the Android™ Out of Box Experience (OOBE). Setup your phone to confirm it works correctly.

![Android™ - OOBE](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/5f86cbbe-df08-4ba6-92aa-b7fd2a7f72b3)

Congratulations, you successfully relocked your bootloader.

Now, you may want to forbid unlocking the bootloader again for additional security and peace of mind

### In order to turn off the ability to unlock the bootloader of the device

- Start by turning on your Surface Duo into Android™, and unlock it

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

- Turn off the OEM Unlock option as shown above, then turn off the developer options toggle at the very top

🎉 Congratulations, your Surface Duo is back to factory settings.
