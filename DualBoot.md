# Enabling Dual Boot on Surface Duo

## Files/Tools Needed 📃

- UEFI Raw FV Image for Surface Duo 1: [SM8150_EFI.fd](https://github.com/WOA-Project/SurfaceDuoPkg/releases)
- UEFI Raw FV Image for Surface Duo 2: [SM8350_EFI.fd](https://github.com/WOA-Project/SurfaceDuoPkg/releases)
- Stock device boot.img image obtained from an ota package, or from the device itself using ```adb pull```
- Kernel Patching Utility: [SurfaceDuoDualBootKernelImagePatcher](https://github.com/WOA-Project/SurfaceDuoDualBootKernelImagePatcher/releases)
- [mkbootimg](https://github.com/WOA-Project/SurfaceDuoPkg/blob/main/ImageResources/mkbootimg.py)
- [unpack_bootimg.py](https://android.googlesource.com/platform/system/tools/mkbootimg/+/refs/heads/master/unpack_bootimg.py)
- Python
- Windows Subsystem for Linux (for cat) (or use your own method)

## Warnings ⚠️

Once you do this, you will need to follow this guide again each time you update Android™, or your Android™ installation won't boot anymore.

Please backup your original boot.img image. You will need to reflash it in order to update successfully within android going forward. Or you'll have to use an OTA package.

## Steps 🛠️

### Getting original boot image information and files

First we need to unpack the stock boot image to gather a few files and information, like so from an OS with python installed:

```batch
B:\Duo>unpack_bootimg.py --boot_img boot.img
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
B:\Duo>
```

Take note of the values of:

- os version
- os patch level
- command line args

you will need them later

### Patching original kernel image header

Once done, run the kernel patcher utility as such:

For Surface Duo 1:

```batch
SurfaceDuoDualBootKernelImagePatcher.exe .\kernel .\patchedkernel 0
```

For Surface Duo 2:

```batch
SurfaceDuoDualBootKernelImagePatcher.exe .\kernel .\patchedkernel 1
```

### Merging patched kernel image with the UEFI firmware

Now we need to combine our new kernel with our UEFI fd image from a bash terminal:

For Surface Duo 1:

```bash
cat ./patchedkernel ./SM8150_EFI.fd > ./hybridkernel
```

For Surface Duo 2:

```bash
cat ./patchedkernel ./SM8350_EFI.fd > ./hybridkernel
```

### Rebuilding a new boot.img file

Now using the files we got earliers as well as the information being output above from unpack_bootimg, we can generate a new dual boot image from an OS with python installed:

For Surface Duo 1:

```batch
python3 mkbootimg.py \
  --kernel hybridkernel \
  --ramdisk ramdisk \
  -o dualboot.img \
  --pagesize 4096 \
  --header_version 2 \
  --cmdline "<command line>" \
  --dtb dtb \
  --base 0x0 \
  --os_version <os version> \
  --os_patch_level <os patch level> \
  --second_offset 0xf00000
```

For Surface Duo 2:

```batch
python3 mkbootimg.py \
  --kernel hybridkernel \
  --ramdisk ramdisk \
  -o dualboot.img \
  --pagesize 4096 \
  --header_version 3 \
  --cmdline "<command line>" \
  --base 0x0 \
  --os_version <os version> \
  --os_patch_level <os patch level>
```

### Flashing newly made image

- Go to stock recovery

```batch
adb reboot recovery
```

- Go to fastbootd. To do that, on recovery:
  1. Press and hold **Power** then press **Volume Up**
  2. Release **Volume Up**, release **Power**
     * Do not release the **Power** button before pressing the **Volume Up** button.
  4. Go to "fastboot" in the menu

- Get the Current slot (*Search for current-slot:<slot\>)*

```batch
fastboot getvar all
```

- Flash the boot img to that slot

```batch
fastboot flash boot_<slot> <dualboot.img>
```

## How it Works

- To boot Android™, leave Surface Duo open while turning it on
- To boot Windows, close Surface Duo as soon as you turn it on and wait a while to open it again

## Troubleshooting

If the device keeps going back to the bootloader menu

```batch
fastboot set_active <alternative slot from current>
fastboot set_active <original slot from before>
```
