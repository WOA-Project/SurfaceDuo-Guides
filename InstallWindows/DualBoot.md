# Enabling Dual Boot on Surface Duo

Table of Contents:

* [Enabling Dual Boot on Surface Duo](#enabling-dual-boot-on-surface-duo)
   * [Files/Tools Needed 📃](#filestools-needed-)
   * [Steps 🛠️](#steps-️)
      * [Getting original boot image information and files](#getting-original-boot-image-information-and-files)
      * [Patching original kernel image header and merging the UEFI with it](#patching-original-kernel-image-header-and-merging-the-uefi-with-it)
      * [Rebuilding a new boot.img file](#rebuilding-a-new-bootimg-file)
      * [Testing the newly made image](#testing-the-newly-made-image)
         * [Testing Android™ works](#testing-android-works)
         * [Testing Windows works](#testing-windows-works)
      * [Flashing newly made image](#flashing-newly-made-image)
   * [Reverting changes for Android™ Updates or uninstallation](#reverting-changes-for-android-updates-or-uninstallation)
   * [How it Works](#how-it-works)
   * [Troubleshooting](#troubleshooting)

## Files/Tools Needed 📃

- You will need the following files from the [BSP Release page](https://github.com/WOA-Project/SurfaceDuo-Releases/releases/latest):

UEFI Raw FV Image:

| File Name                                                           | Target Device         |
|---------------------------------------------------------------------|-----------------------|
| Surface.Duo.1st.Gen.UEFI.FD.for.making.your.own.Dual.Boot.Image.zip | Surface Duo (1st Gen) |
| Surface.Duo.2.UEFI.FD.for.making.your.own.Dual.Boot.Image.zip       | Surface Duo 2         |

- Stock device boot.img image obtained from an ota package, or from the device itself using [the extracting partition guide](/Other/ExtractingPartitions.md).
- Kernel Patching Utility: [SurfaceDuoDualBootKernelImagePatcher](https://github.com/WOA-Project/SurfaceDuoDualBootKernelImagePatcher/releases/latest)
- [mkbootimg](https://github.com/WOA-Project/mu_andromeda_platforms/blob/main/ImageResources/mkbootimg.py)
- [unpack_bootimg.py](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/unpack_bootimg.py)
- Python 3 (the one from the Microsoft Store will do just fine)
- Windows Command Prompt, Linux is not required

## Disclaimers

> [!WARNING]
> Once you do this, you will need to follow this guide again each time you update Android™, or your Android™ installation won't boot anymore.
>
> Please backup your original boot.img image. You will need to reflash it in order to update successfully within Android™ going forward. Or you'll have to use an OTA package.
>
> You cannot relock the bootloader if the boot image was modified using this guide. You will have to restore the original file to do so with instructions mentioned below. The uninstall guide also cannot be followed until you follow the restore part at the bottom of this guide.

# Steps 🛠️

## Getting original boot image information and files

First make sure you've downloaded both python and the required py files mentioned above. If you did not, please download them now and come back here afterwards.

Once done, open a Command Prompt window on your Windows computer (not PowerShell).

First we need to unpack the stock boot image to gather a few files and information, like so from an OS with python installed:

Assuming you downloaded every file you needed:

```batch
python3 unpack_bootimg.py --boot_img boot.img
```

This command will extract specific files from the original boot image extracted earlier, but will also print some vital/important information on screen, here's an example of such information:

```batch
boot magic: ANDROID!
kernel_size: 38262800
kernel load address: 0x00008000
ramdisk size: 11828976
ramdisk load address: 0x01000000
second bootloader size: 0
second bootloader load address: 0x00000000
kernel tags load address: 0x00000100
page size: 4096
os version: <os version>
os patch level: <os patch level>
boot image header version: 2
product name:
command line args: <command line>
additional command line args:
recovery dtbo size: 0
recovery dtbo offset: 0x0000000000000000
boot header size: 1660
dtb size: 4229414
dtb address: 0x0000000001f00000
```

To avoid mistakes/reusing values, we've replaced them above. You will want to note down safely the values for the following fields, you will need them later:

- os version: ```<os version>```
- os patch level: ```<os patch level>```
- command line args: ```<command line>```

later in the guide, you will have to replace every occurence of ```<os version>```, ```<os patch level>```, ```<command line>``` with the values you collected above, without the ```<>``` of course!

## Patching original kernel image header and merging the UEFI with it

Now we need to combine our new kernel with our UEFI fd image from a Command Prompt (cmd.exe _not_ PowerShell).

Run the kernel patcher utility as such:

For Surface Duo (1st Gen):

```batch
SurfaceDuoDualBootKernelImagePatcher.exe .\kernel .\SM8150_EFI.fd 0 .\hybridkernel
```

For Surface Duo 2:

```batch
SurfaceDuoDualBootKernelImagePatcher.exe .\kernel .\SM8350_EFI.fd 1 .\hybridkernel
```

## Rebuilding a new boot.img file

Now using the files we got earliers as well as the information being output above from unpack_bootimg, we can generate a new dual boot image from an OS with python installed:

For Surface Duo (1st Gen):

```batch
python3 mkbootimg.py --kernel hybridkernel --ramdisk ramdisk -o dualboot.img --pagesize 4096 --header_version 2 --cmdline "<command line>" --dtb dtb --base 0x0 --os_version <os version> --os_patch_level <os patch level> --second_offset 0xf00000
```

For Surface Duo 2:

```batch
python3 mkbootimg.py --kernel hybridkernel --ramdisk ramdisk -o dualboot.img --pagesize 4096 --header_version 3 --cmdline "<command line>" --base 0x0 --os_version <os version> --os_patch_level <os patch level>
```

## Testing the newly made image

Before risking to brick your device, it is good practice to test your image to make sure it fully works to avoid further issues.

### Testing Android™ works

First go to the Bootloader mode with:

```batch
adb reboot bootloader
```

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

Now, boot your newly image like so, with the device folded flat/open:

```batch
fastboot boot dualboot.img
```

If your device boots into Android™ just fine, like before, you did well! your image is fully working for Android™ use. Make sure you can unlock the device fine and use it as normal before proceeding further.

### Testing Windows works

Now we'll test the ability to boot into Windows in roughly the same way.

Go to the Bootloader mode once more with:

```batch
adb reboot bootloader
```

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

Now, boot your newly image like so, this time with the device closed, not opened:

```batch
fastboot boot dualboot.img
```

If your device boots into Windows just fine, like before, you did well! your image is fully working for Windows use. Make sure you can unlock the device fine and use it as normal before proceeding further.

We have now certified our image works. In case it does not, please make sure you used a matching boot.img file to generate your file, and correctly used the information provided at the beginning of the guide in commands.

- Reboot the device back to Android™ from the start menu, power, reboot:

![Surface Duo in Windows, Start Menu Opened, Power Menu opened, Reboot option highlighted](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/fabc1514-4e8a-47cd-80d7-8655674384c7)
_Image of what you should see and do right now: Surface Duo in Windows, Start Menu Opened, Power Menu opened, Reboot option highlighted_

## Flashing newly made image

Now that our image is confirmed working:

- Go to stock recovery

```batch
adb reboot recovery
```

![Surface Duo in Locked Recovery mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/0198103d-d44d-40d5-af45-8e60744dfb96)
_Image of what you should see right now: Surface Duo in Locked Recovery mode_

- Go to fastbootd. To do that, on recovery:
  1. Press and hold **Power** then press **Volume Up**
  2. Release **Volume Up**, release **Power**
     * Do not release the **Power** button before pressing the **Volume Up** button.

![Surface Duo in Recovery mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/9a4a2dd7-7a72-4ed4-8f1e-7e8de627995f)
_Image of what you should see right now: Surface Duo in Recovery mode_

  3. Select "Enter fastboot" in the menu by using the **Volume Up** and/or the **Volume Down** button to go up and down, and press the **Power** button to select/confirm.

![Surface Duo in Fastbootd mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/fbd0d1b9-fdf1-4102-8c8a-c29c44ab9c4f)
_Image of what you should see right now: Surface Duo in Fastbootd mode_

- Flash the boot image (dualboot.img) to the device:

_Replace ```<dualboot.img>``` (including the ```<``` and ```>``` with the full path to your image file!)_

```batch
fastboot flash boot <dualboot.img>
```

## Reverting changes for Android™ Updates or uninstallation

To revert the changes and go back to a clean state, simply flash the original boot.img file again from the recovery menu. In case you are unable to go to the recovery menu, it is possible your device has a completely broken boot partition. You will need to reflash the file from twrp or an alternative bootable linux method, which is not detailed yet in this guide.

## How it Works

- To boot Android™, leave Surface Duo open while turning it on
- To boot Windows, close Surface Duo as soon as you turn it on and wait a while to open it again

## Troubleshooting

If the device keeps going back to the Bootloader mode

```batch
fastboot set_active <alternative slot from current>
fastboot set_active <original slot from before>
```

---

_**© 2020-2024 The Duo WOA Authors**_

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

_**Limited emergency calling**_

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

_**Hello from Seattle (US), France, Italy.**_