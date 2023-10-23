# Creating a Windows ISO with UUPMediaCreator

You can find out which Windows versions are supported for each device model [here](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/WindowsCompatibility.md)

## Steps

- Presuming you are working on a Windows AMD64 machine, download and extract the ```win-x64.zip``` file from [the UUPMediaCreator repo](https://github.com/gus33000/UUPMediaCreator/releases/latest).
(if you are on a Windows ARM64 machine, use win-arm64 instead, etc..)

NOTE: For apps to be included in the image for Windows 11 Version 22H1 or higher, please run the tool on Windows 11.

- Navigate to this directory: `"win-x64\CLI"`

### Download commands

-  Inside the CLI directory, open command prompt and run one of following commands (depending on what version of Windows you would like to use):

#### Latest Production Versions (Recommended)

This will get you the latest currently supported _stable_ version of Windows 11, which is the recommended option for most people to use on your device.

Windows Insider Program's channel builds may be more unstable, and less tested for use on Surface Duo devices. They'll also break more often than production versions, and require more recurrent updating.

If you value stability, please use below's command to download the latest stable version of Windows 11:

_Windows 11 Version 23H2_
```batch
uupdownload -s Professional -e Professional -v 10.0.22621.100 -r Retail -b Retail -c ni_release -t arm64 -l en-US
```

---

This will download the professional edition of Windows for arm64 architecture for English version. If you want to change the language,
use the standard Windows language pack commands. Installing the right language pack will save a lot of time for download.

---

- Once the download is completed, you will see a new folder with prefix "10.0.22000..." (or something different!) created inside the CLI folder. This
  contains all the required Windows files. Let's create an ISO from the Windows build download.
  Open up the command prompt as Administrator and type:

```batch
UUPMediaConverter.exe -u <10.0.22000... name of your Windows build folder> -i Windows11_Pro_arm64_en-US.iso -l en-US -e Professional
```

- Once that's done, mount the newly created `Windows11_Pro_arm64_en-US.iso` on your Windows machine. You will find the install.wim file in your mounted ISO drive in `G:\sources\install.wim`.
