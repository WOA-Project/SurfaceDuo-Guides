# Extract the boot partition or other partitions

## Files/Tools Needed 📃

- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- A Windows PC

### For Surface Duo (First Gen)

- TWRP image for Surface Duo (First Gen): [surfaceduo1-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo1-twrp.img)

### For Surface Duo 2

- TWRP image for Surface Duo 2: [surfaceduo2-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/surfaceduo2-twrp.img)

> [!WARNING]
> - Read the entire guide before starting. Make sure you understand all of what you're going to do!
> - If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.
> - Don't rerun the commands if you interrupt the process. You may break things.
> - Do not run all commands at once.
> - Do not commit *any* typo with *any* commands.
> - Be familiar with command line interfaces.
> - When using TWRP, it is normal and expected for the phone to be detected as a Xiaomi phone or an Asus phone and for touch to not work.

## Getting your current boot slot (A/B)

Assuming your Surface Duo is currently booted into Android™️, connect it to your PC with a USB cable and open a command prompt.

- First, we need to reboot into the Bootloader mode, to do so, run this command on your pc:

```batch
adb reboot bootloader
```

Your Surface Duo will reboot into the Bootloader mode.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

-  In order to retrieve the current active slot, run this command on your PC:

```batch
fastboot getvar current-slot
```

A line with the text 'current-slot:' will appear.
The value can be a or b.

<img width="304" alt="image" src="https://github-production-user-asset-6210df.s3.amazonaws.com/75797743/242037668-45949c27-b4bc-4abb-90a9-b5a4060ba648.png">

Take note of your slot, we´ll assume it is `b`

- For the rest of this guide we´ll assume the current slot is `b` and we want to retrieve the `boot` partition

## Boot into TWRP

- We need to boot into TWRP, to do so, run the following command on your PC:

For Surface Duo (First Gen):

```batch
fastboot boot surfaceduo1-twrp.img
```

For Surface Duo 2:

```batch
fastboot boot surfaceduo2-twrp.img
```

---

Your Surface Duo will boot into TWRP, touch will not work and the device will say it is locked. This is completely normal and expected.


## Retrieve the location of our boot partition

- We need to open a shell to issue commands directly to the phone. To do so, run the following command on your PC:

```batch
adb shell "setenforce 0"
adb shell
```

You are now able to issue commands directly to your phone via your PC.

- Now, we need to find the location of our boot partition, as it is different for each device. To do so, run the following command on your PC:

```bash
ls /dev/block/platform/soc/
```

If you're lucky, you'll get only one line of output:

<img width="280" alt="image" src="https://user-images.githubusercontent.com/29689637/222556387-7595aa9c-e452-4534-afb2-acd2515e9496.png">

Take note of all the lines that get output from this command. In my case, it's only one and it is `1d84000.ufshc`.

- Next we need to retrieve our mount point for our partition, to do so, run this command:

```bash
ls -al /dev/block/platform/soc/[the last line we took note of]/by-name/
```

*In my case: `ls -al /dev/block/platform/soc/1d84000.ufshc/by-name/`*

- This is going to output a lot of lines, with each partition name having its mount point. Look for the line that says `boot_[your slot]`:

<img width="506" alt="image" src="https://user-images.githubusercontent.com/29689637/222557262-7cbe0114-a218-4d60-9da3-2e04a9733bd6.png">

- Now let's take note of its mount point, in my case: `/dev/block/sde26`.

Let's make an image of the partition:

```bash
dd if=/dev/block/[your mount point] of=/tmp/boot.img
```

*In my case: `dd if=/dev/block/sde26 of=/tmp/boot.img`.*

- Now let's exit the shell and pull the boot.img from the device, to do so, run the following command on your PC:

```bash
exit
```

```batch
adb pull /tmp/boot.img
```

If you did everything correctly, you will now have your `boot.img`. Enjoy! 🥳

<img width="531" alt="image" src="https://user-images.githubusercontent.com/29689637/222561203-7f2dc375-e500-4201-a538-8cd0ba6d7559.png">
