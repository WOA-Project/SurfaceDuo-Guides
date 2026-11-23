# Recovering a Surface Duo 2 From EDL (Emergency Download Mode)

This guide will help recover a Surface Duo 2 that is stuck in Qualcomm Emergency Download Mode (EDL).

Typical symptoms include:

- Completely black screens
- Device not booting
- Device only appearing as a Qualcomm device over USB
- No access to Android™, Recovery, or Bootloader

This guide restores a functional Surface Duo 2 bootloader using an EDL recovery package and then returns the device to Microsoft's official Android recovery process.

EDL (Emergency Download Mode) is a Qualcomm recovery mode used when the device cannot boot Android™, Recovery, or the Bootloader normally.

When a Surface Duo 2 enters EDL mode, both displays usually remain completely black, giving the impression that the device is dead. Fortunately, in most cases, the device can still be recovered.

## Table of Contents

- [Files/Tools Needed](#filestools-needed)
- [Disclaimers](#disclaimers)
- [Steps](#steps)
  - [Acquiring all files](#acquiring-all-files)
  - [Entering EDL Mode](#entering-edl-mode)
  - [Installing Qualcomm Drivers](#installing-qualcomm-drivers)
  - [Flashing the Bootloader](#flashing-the-bootloader)
  - [Confirming Success](#confirming-success)
  - [Returning To Recovery](#returning-to-recovery)
  - [Why A Recovery Image Is Still Required](#why-a-recovery-image-is-still-required)
  - [Downloading an Official Recovery Image](#downloading-an-official-recovery-image)
  - [Entering Recovery Mode Manually](#entering-recovery-mode-manually)
  - [Installing the Recovery Image](#installing-the-recovery-image)
  - [Recovery Complete](#recovery-complete)
- [Troubleshooting](#troubleshooting)
  - [Device Remains Black After Running edl_flash_bl.cmd](#device-remains-black-after-running-edl_flash_blcmd)
  - [Fastboot Cannot Detect The Device](#fastboot-cannot-detect-the-device)
  - [Device Keeps Returning To Bootloader](#device-keeps-returning-to-bootloader)
  - [Device Still Does Not Boot](#device-still-does-not-boot)

## Files/Tools Needed

| File Name | Target Device |
|--------------------------------------------------------|-----------------------|
| [surface-zeta-edl.7z](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/surface-zeta-edl.7z) | Surface Duo 2 |
| [USB-Drivers.zip](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/USB-Drivers.zip) | Surface Duo 2 |

- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- Windows PC

## Disclaimers

> [!IMPORTANT]
>
> This guide is intended only for **Surface Duo 2**.
>
> While this procedure has been used successfully on multiple devices, we cannot take responsibility for any damage caused by incorrect operation.
>
> **PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**
>
> Recovery images and EDL flashing will erase device data. Back up anything important before proceeding.

# Steps

## Acquiring all files

Download the following files from this repository:

- [surface-zeta-edl.7z](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/surface-zeta-edl.7z)
- [USB-Drivers.zip](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/USB-Drivers.zip)

Extract both archives.

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

## Entering EDL Mode

If your device is already in EDL mode, you may skip this section.

Typical signs of EDL mode include:

- Both screens remain completely black
- No Microsoft logo appears
- No bootloader menu appears
- Device appears as a Qualcomm device when connected via USB

To force a Surface Duo 2 into EDL mode:

1. Disconnect all USB cables.
2. Press and hold:

```text
Power + Volume Down
```

3. Continue holding both buttons for approximately 18 seconds.
4. Connect the USB cable to the PC.

The displays will remain completely black.

This is expected.

## Installing Qualcomm Drivers

If Windows automatically installs a driver, you may skip this section.

Extract:

```text
USB-Drivers.zip
```

Open Device Manager.

Locate the unknown Qualcomm device.

Right click it and select:

```text
Update Driver
Browse my computer for drivers
```

Point Windows to the extracted driver folder.

Allow installation to complete.

Once complete, the device should show up as a Qualcomm device rather than an unknown device.

## Flashing the Bootloader

> [!WARNING]
>
> Do not disconnect the USB cable while the EDL recovery package is flashing.
>
> Interrupting the flashing process may leave the device in an unrecoverable state.

Extract:

```text
surface-zeta-edl.7z
```

Connect the phone to your PC while it is in EDL mode.

Double click:

```text
edl_flash_bl.cmd
```

Accept the UAC prompt.

The script will automatically:

- Detect the device
- Flash a valid bootloader
- Reboot the phone

No additional interaction is required.

## Confirming Success

If flashing completed successfully, the phone should automatically reboot into the Surface Duo bootloader menu.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)

_Image of what you should see right now: Surface Duo 2 in Bootloader mode_

The screen should contain:

- Start
- Recovery Mode
- Power Off
- Device Information

Unlike EDL mode, the displays are now active.

At this point, the device has been successfully recovered from EDL.

## Returning To Recovery

Open a Command Prompt in the Platform Tools folder.

Go to the folder where you extracted the Android Platform Tools using the CD command and the path of the folder, like so:

![image](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/24760f21-dc1b-48e6-9ae3-0aeb16f8953c)

Run:

```batch
fastboot set_active other
fastboot set_active other
fastboot reboot recovery
```

> [!NOTE]
> The recovery package intentionally lands in a bootloader-only state.
>
> Running `set_active other` twice ensures the secondary slot becomes active and allows Android Recovery to boot correctly.

The device should reboot into Android Recovery.

![Surface Duo in Locked Recovery mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/0198103d-d44d-40d5-af45-8e60744dfb96)
_Image of what you should see right now: Surface Duo in Locked Recovery mode_

## Why A Recovery Image Is Still Required

The EDL package only restores enough bootloader functionality to recover the device.

It does **not** restore Android™ itself.

To return the phone to a fully working state, Microsoft's official Surface Recovery Image must still be installed after the bootloader has been recovered.

## Downloading an Official Recovery Image

Visit:

https://aka.ms/sri

Select:

```text
Surface Duo 2
```

Enter your serial number and download the latest recovery image for your device.

Save the downloaded ZIP file into your Platform Tools folder.

## Entering Recovery Mode Manually

If the device did not automatically enter Recovery Mode:

1. Disconnect USB.
2. Power the device off.
3. Press and hold Volume Down.
4. Press and release Power.
5. Continue holding Volume Down.

Select:

```text
Recovery Mode
```

using the volume buttons.

Confirm using the Power button.

When the Android robot appears:

1. Hold Power.
2. Press Volume Up once.
3. Release both buttons.

Android Recovery should appear.

![Surface Duo in Recovery mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/9a4a2dd7-7a72-4ed4-8f1e-7e8de627995f)
_Image of what you should see right now: Surface Duo in Recovery mode_

Select:

```text
Apply update from ADB
```

Connect the device to your computer.

## Installing the Recovery Image

Open a Command Prompt.

Navigate to the Platform Tools folder.

Example:

```batch
cd C:\platform-tools
```

Run:

```batch
adb sideload surface-recovery-image.zip
```

Replace:

```text
surface-recovery-image.zip
```

with the actual filename you downloaded from Microsoft's Surface Recovery Image portal.

The installation process typically takes around 10 minutes.

After installation completes:

1. Disconnect the USB cable.
2. Select:

```text
Reboot system now
```

3. Press the Power button.

The device should now boot normally into Android™.

## Recovery Complete

If everything completed successfully:

- The device is no longer stuck in EDL mode
- Android™ boots normally
- Recovery Mode works again
- Fastboot works again
- The device can receive future OTA updates normally

Congratulations, your Surface Duo 2 has been recovered successfully.

## Troubleshooting

### Device Remains Black After Running edl_flash_bl.cmd

Verify:

- The phone is actually in EDL mode.
- Qualcomm drivers are installed.
- The USB cable supports data transfer.
- The UAC prompt was accepted.

### Fastboot Cannot Detect The Device

Run:

```batch
fastboot devices
```

If no device appears:

- Reinstall the drivers.
- Try another USB port.
- Reconnect the device.

### Device Keeps Returning To Bootloader

Run:

```batch
fastboot set_active other
fastboot set_active other
fastboot reboot recovery
```

and then complete the official recovery image installation process.

### Device Still Does Not Boot

Download a fresh recovery image from Microsoft and repeat the recovery process.

---

*_**© 2020-2026 The Duo WOA Authors**_*

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi‑Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

*_*****Limited emergency calling*****_*

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

*_*****Hello from Seattle (US), France, Italy.*****_*