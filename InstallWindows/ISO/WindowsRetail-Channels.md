# Creating a Windows ISO with UUPMediaCreator

You can find out which Windows versions are supported for each device model [here](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/WindowsCompatibility.md)

### Option: Latest Production Versions (Recommended)

This guide will get you the latest currently supported _stable_ version of Windows 11, which is the recommended option for most people to use on your device.

Windows Insider Program's channel builds may be more unstable, and less tested for use on Surface Duo devices. They'll also break more often than production versions, and require more recurrent updating.

If you value stability, please follow below's commands and steps to download the latest stable version of Windows 11:

## Steps

- Presuming you are working on a Windows AMD64 machine, download and extract the ```win-XXX.zip``` file from [the UUPMediaCreator repo](https://github.com/gus33000/UUPMediaCreator/releases/latest).

What version do I download?

- If your computer (different from the device or disk you want to update!) is running Windows on an Intel or AMD 64-bit CPU, please get the ```win-x64.zip``` file.

- If your computer (different from the device or disk you want to update!) is running Windows on an Intel or AMD 32-bit CPU, please get the ```win-x86.zip``` file.

- If your computer (different from the device or disk you want to update!) is running Windows on a Qualcomm or Apple 64-bit CPU, please get the ```win-arm64.zip``` file.

- If your computer (different from the device or disk you want to update!) is running Windows on a ARM32 CPU or anything else, consider getting another device as this program simply is not compatible with your PC.

NOTE: For apps to be included in the image for Windows 11 Version 22H1 or higher, please run the tool on Windows 11.

- Navigate to the directory you extracted the downloaded ZIP file onto, you should see files like ```uupdownload.exe``` inside.

### Download commands

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

### Creation commands

Let's create an ISO from the Windows build download.

Open up the command prompt as Administrator and type:

```batch
UUPMediaConverter.exe -u <10.0.22000... name of your Windows build folder> -i Windows11_Pro_arm64_en-US.iso -l en-US -e Professional
```

- Once that's done, mount the newly created `Windows11_Pro_arm64_en-US.iso` on your Windows machine. You will find the install.wim file in your mounted ISO drive in `G:\sources\install.wim`.

<i>© 2020-2024 The Duo WOA Authors

Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface.

Android is a registered trademark of Google LLC.

Hello from Seattle, France, Italy.</i>