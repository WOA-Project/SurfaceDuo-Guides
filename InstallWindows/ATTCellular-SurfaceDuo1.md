# Making Cellular work on Sim Unlocked AT&T Surface Duo (1st Gen) devices

AT&T devices that are _Unlocked_ will be simlocked in Windows but not in Android™ again. In order to make Windows _Unlocked_ like Android™ some steps are required.

## Files/Tools Needed 📃

- TWRP image:

| File Name                                       | Target Device         |
|-------------------------------------------------|-----------------------|
| [surfaceduo1-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo1-twrp.img) | Surface Duo (1st Gen) |

- Mass Storage Shell Script: [msc.tar](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/msc.tar)
- Windows Command Prompt, Linux is not required

> [!WARNING]
> - Don't create partitions from Mass Storage Mode on Windows (because ABL will break with blank/spaces in names), your phone may be irrecoverable otherwise
> - If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.
> - Do not run all commands at once.
> - Do not commit *any* typo with *any* commands.
> - Be familiar with command line interfaces.
> - When using TWRP, it is normal and expected for the phone to be detected as a Xiaomi phone and for touch to not work.

# Steps 🛠️

## Getting to Mass Storage Mode

- Reboot into the Bootloader mode by running this command while inside Android™:

```batch
adb reboot bootloader
```

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

Now let's boot TWRP:

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

Once inside TWRP, touch will not be working and the device will say it is locked. This is completely normal.

- Let's load the mass storage shell script in order to boot into Mass Storage from TWRP

```batch
adb shell "setenforce 0"
adb push <path to downloaded msc.tar> /sdcard/
adb shell "tar -xf /sdcard/msc.tar -C /sdcard --no-same-owner"
adb shell "sh /sdcard/msc.sh"
```

Surface Duo should now be in USB 3 SuperSpeed (or what the USB-IF currently calls it) Mass Storage Mode.

## Dumping Modem partitions

Using [the following guide](/Other/ExtractingPartitions.md), extract the following partitions:

- ```modem_fs1```
- ```modem_fs2```

once done, you should have obtained the ```modem_fs1.img``` and ```modem_fs1.img``` files on your computer.

Please note that your device is already in twrp, there's no need to put it back again into twrp. (So jump directly to the adb shell section of the above's guide).

## Copying files over

Assuming the Windows partition is available under X: (will/may be different for you), do the following:

- Copy the ```modem_fs1.img``` file to ```X:\Windows\System32\DriverStore\FileRepository\qcremotefs8150_<random data here>\bootmodem_fs1```
- Copy the ```modem_fs2.img``` file to ```X:\Windows\System32\DriverStore\FileRepository\qcremotefs8150_<random data here>\bootmodem_fs2```

Please note bootmodem_fs1 is the name of the file, and not a folder (same for bootmodem_fs2).
You may have to adjust permissions on the ```X:\Windows\System32\DriverStore\FileRepository\qcremotefs8150_<random data here>``` folder in order to copy paste the above's files.

---

_**© 2020-2024 The Duo WOA Authors**_

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

_**Limited emergency calling**_

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

_**Hello from Seattle (US), France, Italy.**_