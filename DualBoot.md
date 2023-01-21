# Enabling Dual Boot on Duo

## Files/Tools Needed 📃

- UEFI Raw FV Image for Surface Duo 1: [SM8150_EFI.fd](https://github.com/WOA-Project/SurfaceDuoPkg/releases)
- UEFI Raw FV Image for Surface Duo 2: [SM8350_EFI.fd](https://github.com/WOA-Project/SurfaceDuoPkg/releases)
- Stock device boot.img image obtained from an ota package, or from the device itself using ```adb pull```
- Kernel Patching Utility: [SurfaceDuoDualBootKernelImagePatcher](https://github.com/WOA-Project/SurfaceDuoDualBootKernelImagePatcher/releases)
- [mkbootimg](https://github.com/WOA-Project/SurfaceDuoPkg/blob/main/ImageResources/mkbootimg.py)
- [unpack_bootimg.py](https://android.googlesource.com/platform/system/tools/mkbootimg/+/refs/heads/master/unpack_bootimg.py)
- Python
 
## Steps🛠️

### Getting original boot image information and files

First we need to unpack the stock boot image to gather a few files and information, like so:

```bash
gus@Bubo:/duo$ ./unpack_bootimg.py --boot_img ./boot.img
boot magic: ANDROID!
kernel_size: 38262800
kernel load address: 0x00008000
ramdisk size: 11828976
ramdisk load address: 0x01000000
second bootloader size: 0
second bootloader load address: 0x00000000
kernel tags load address: 0x00000100
page size: 4096
os version: 11.0.0
os patch level: 2022-12
boot image header version: 2
product name:
command line args: console=ttyMSM0,115200n8 earlycon=msm_geni_serial,0xa90000 androidboot.hardware=surfaceduo androidboot.hardware.platform=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 swiotlb=2048 loop.max_part=7 androidboot.usbcontroller=a600000.dwc3 kpti=off buildvariant=user
additional command line args:
recovery dtbo size: 0
recovery dtbo offset: 0x0000000000000000
boot header size: 1660
dtb size: 4229414
dtb address: 0x0000000001f00000
gus@Bubo:/duo$
```

### Patching original kernel image header

Once done, run the kernel patcher utility as such:

For Surface Duo 1:
```batch
SurfaceDuoDualBootKernelImagePatcher.exe .\kernel .\patchedkernel 0
```

For Surface Duo 2:
```batch
SurfaceDuoDualBootKernelImagePatcher.exe .\kernel .\patchedkernel 2
```

### Merging patched kernel image with the UEFI firmware

Now we need to combine our new kernel with our UEFI fd image:

For Surface Duo 1:
```bash
cat ./patchedkernel ./SM8150_EFI.fd > ./hybridkernel
```

For Surface Duo 2:
```bash
cat ./patchedkernel ./SM8350_EFI.fd > ./hybridkernel
```

### Rebuilding a new boot.img file

Now using the files we got earliers as well as the information being output above from unpack_bootimg, we can generate a new dual boot image:

For Surface Duo 1:
```bash
python3 ./mkbootimg.py \
  --kernel ./hybridkernel \
  --ramdisk ./ramdisk \
  -o ./dualboot.img \
  --pagesize 4096 \
  --header_version 2 \
  --cmdline "console=ttyMSM0,115200n8 earlycon=msm_geni_serial,0xa90000 androidboot.hardware=surfaceduo androidboot.hardware.platform=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 swiotlb=2048 loop.max_part=7 androidboot.usbcontroller=a600000.dwc3 kpti=off buildvariant=user" \
  --dtb ./dtb \
  --base 0x0 \
  --os_version 11.0.0 \
  --os_patch_level 2022-12-01 \
  --second_offset 0xf00000
```

For Surface Duo 2:
```bash
python3 ./mkbootimg.py \
  --kernel ./hybridkernel \
  --ramdisk ./ramdisk \
  -o ./dualboot.img \
  --pagesize 4096 \
  --header_version 3 \
  --cmdline "" \
  --base 0x0 \
  --os_version 11.0.0 \
  --os_patch_level 2022-12-01
```

### Flashing newly made image

- Go to stock recovery
```
adb reboot recovery
```
- Go to fastbootd. To do that, on recovery:
  1. Press and hold **Power** then press **Volume Up**
  2. Release **Volume Up**, release **Power**
     * Do not release the **Power** button before pressing the **Volume Up** button.
  4. Go to "fastboot" in the menu

- Get the Current slot (*Search for current-slot:<slot\>)*
```
fastboot getvar all
```

- Flash the boot img to that slot
```
fastboot flash boot_<slot> <dualboot.img>
```

## How it Works
- To boot Android, leave Duo open while turning it on
- To boot Windows, close Duo as soon as you turn it on and wait a while to open it again
  
## Troubleshooting
If the device keeps going back to the bootloader menu
```
fastboot set_active <alternative slot from current>
fastboot set_active <original slot from before>
```
