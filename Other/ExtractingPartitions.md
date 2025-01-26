# Extract the boot partition or other partitions

## Files/Tools Needed

- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- A Windows PC

- TWRP image:

| File Name                                       | Target Device         |
|-------------------------------------------------|-----------------------|
| [surfaceduo1-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/surfaceduo1-twrp.img) | Surface Duo (1st Gen) |
| [surfaceduo2-twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/surfaceduo2-twrp.img) | Surface Duo 2         |

## Disclaimers

> [!WARNING]
> - Read the entire guide before starting. Make sure you understand all of what you're going to do!
> - If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.
> - Don't rerun the commands if you interrupt the process. You may break things.
> - Do not run all commands at once.
> - Do not commit *any* typo with *any* commands.
> - Be familiar with command line interfaces.
> - When using TWRP, it is normal and expected for the phone to be detected as a Xiaomi phone or an Asus phone and for touch to not work.

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

For Surface Duo (1st Gen):

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

For Surface Duo 2:

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

You will now boot to TWRP. Reminder that touch doesn't work on TWRP for now, so you'll have to work through your PC.

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

---

_**© 2020-2025 The Duo WOA Authors**_

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

_**Limited emergency calling**_

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

_**Hello from Seattle (US), France, Italy.**_