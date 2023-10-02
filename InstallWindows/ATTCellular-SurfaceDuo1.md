# Making Cellular work on Sim Unlocked AT&T Surface Duo 1 devices

AT&T devices that are _Unlocked_ will be simlocked in Windows but not in Android™ again. In order to make Windows _Unlocked_ like Android™ some steps are required.

## Files/Tools Needed 📃

- TWRP image: [surfaceduo1-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo1-twrp.img)
- Mass Storage Shell Script: [surfaceduo1-msc.tar](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo1-msc.tar)
- Windows Command Prompt, Linux is not required

## Warnings ⚠️

- Don't create partitions from Mass Storage Mode on Windows (because ABL will break with blank/spaces in names), your phone may be irrecoverable otherwise
- If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.
- Do not run all commands at once.
- Do not commit *any* typo with *any* commands.
- Be familiar with command line interfaces.
- When using TWRP, it is normal and expected for the phone to be detected as a Xiaomi phone and for touch to not work.

# Steps 🛠️

## Getting to Mass Storage Mode

- Reboot into the bootloader menu by running this command while inside Android™:

```
adb reboot bootloader
```

- Now let's boot TWRP:

```
fastboot boot surfaceduo1-twrp.img
```

Once inside TWRP, touch will not be working and the device will say it is locked. This is completely normal.
- Let's load the mass storage shell script in order to boot into Mass Storage from TWRP

```batch
adb push <path to downloaded surfaceduo1-msc.tar> /sdcard/
adb shell "tar -xf /sdcard/surfaceduo1-msc.tar -C /sdcard --no-same-owner"
adb shell "sh /sdcard/msc.sh"
```

Surface Duo should now be in USB 3 SuperSpeed (or what the USB-IF currently calls it) Mass Storage Mode.

## Dumping Modem partitions

Using the following guide (../Other/ExtractingPartitions.md), extract the following partitions:

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
