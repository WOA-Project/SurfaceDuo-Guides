# Creating a Windows ISO with UUPMediaCreator

You can find out which Windows versions are supported for each device model [here](/WindowsCompatibility.md)

**Option: Latest Production Versions (Recommended)**

This guide will get you the latest currently supported _stable_ version of Windows 11, which is the recommended option for most people to use on your device.

Windows Insider Program's channel builds may be more unstable, and less tested for use on Surface Duo devices. They'll also break more often than production versions, and require more recurrent updating.

If you value stability, please follow below's commands and steps to download the latest stable version of Windows 11:

# Steps

## Option 1: Download the latest pre-made Optical Disc Image file from Microsoft

This ISO is downloaded directly from Microsoft and requires no extra processing step. It may however be slightly behind what is available as latest but can be easy fixed on the device itself by checking for updates.

[Download X23-81973_26100.1742.240906-0331.ge_release_svc_refresh_CLIENT_CONSUMER_A64FRE_en-us.iso from Microsoft](https://oemsoc.download.prss.microsoft.com/dbazure/X23-81973_26100.1742.240906-0331.ge_release_svc_refresh_CLIENT_CONSUMER_A64FRE_en-us.iso_688d2da0-e568-4137-91b0-21ec94894cc2?t=df8fb6b3-cdc7-44d0-a480-f09dc49f5879&P1=102816951036&P2=601&P3=2&P4=Hr%2bkSL%2bbzVZPSXl6l8bx9q7f%2bAdjvgFIdkp19X5XqWvjBzYR7eVBK1FEHFozCXHcYJhWr0lcJE%2fsu93U8iEz%2b0j2qORHIzxWKtgSU0bQZUhRL9HkNGlltGXZ%2fpjPxVFKV0uw6UihUdrpDoEnbWcAS0AzWv0Q6c2QNNysts54wLJBi%2fzM5PD%2bqBgiTZjIqv7rWntXjc8noHTRIe6TllHR2iy2sQdsn1AyVbxXQhP8ZbkLb9nzjTd13kaAxDKaneOT3Tj5V2hBf1T1p8%2f3e2%2fmLeJKjJS4Ys%2b7CGbleTDbHh5KZPhQ98WsWtp38u%2bXGtS9kQyza7zF9rGFD6M55gspKw%3d%3d)

## Option 2: Make the latest pre-made Optical Disc Image file on your own using Windows Update (newer versions)

- Presuming you are working on a Windows AMD64 machine, download and extract the ```win-XXX.zip``` file from [the UUPMediaCreator repo](https://github.com/gus33000/UUPMediaCreator/releases/latest).

What version do I download?

- If your computer (different from the device or disk you want to update!) is running Windows on an Intel or AMD 64-bit CPU, please get the ```win-x64.zip``` file.

- If your computer (different from the device or disk you want to update!) is running Windows on an Intel or AMD 32-bit CPU, please get the ```win-x86.zip``` file.

- If your computer (different from the device or disk you want to update!) is running Windows on a Qualcomm or Apple 64-bit CPU, please get the ```win-arm64.zip``` file.

- If your computer (different from the device or disk you want to update!) is running Windows on a ARM32 CPU or anything else, consider getting another device as this program simply is not compatible with your PC.

NOTE: For apps to be included in the image for Windows 11 Version 22H1 or higher, please run the tool on Windows 11.

- Navigate to the directory you extracted the downloaded ZIP file onto, you should see files like ```uupdownload.exe``` inside.

## Download commands

-  Inside the directory, open command prompt and run one of following commands (depending on what version of Windows you would like to use):

_Windows 11 Version 23H2_
```batch
uupdownload -s Professional -e Professional -v 10.0.22621.100 -r Retail -b Retail -c ni_release -t arm64 -l en-US
```

---

This will download the professional edition of Windows for arm64 architecture for English version. If you want to change the language,
use the standard Windows language pack commands. Installing the right language pack will save a lot of time for download.

---

- Once the download is completed, you will see a new folder with prefix "10.0.22000..." (or something different!) created inside the extracted folder. This
  contains all the required Windows files.

## Creation commands

Let's create an ISO from the Windows build download.

Open up the command prompt as Administrator and type:

```batch
UUPMediaConverter.exe -u <10.0.22000... name of your Windows build folder> -i Windows11_Pro_arm64_en-US.iso -l en-US -e Professional
```

- Once that's done, mount the newly created `Windows11_Pro_arm64_en-US.iso` on your Windows machine. You will find the install.wim file in your mounted ISO drive in `G:\sources\install.wim`.

---

_**© 2020-2024 The Duo WOA Authors**_

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

_**Limited emergency calling**_

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

_**Hello from Seattle (US), France, Italy.**_