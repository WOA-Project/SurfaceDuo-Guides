# Creating a Windows ISO with UUPMediaCreator

You can find out which Windows versions are supported for each device model [here](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/WindowsCompatibility.md)

### Option: Latest Windows Insider Program Versions

Microsoft releases Insider Preview builds to you through channels, which are each designed to bring you a different experience based on the quality of Windows you need for your life and your device. When choosing a channel, you should keep in mind:

- How stable you need your device to be
- What level of issues you can handle on your device
- How early in development you'd like to see features and changes
- Whether or not you need Microsoft support

As Microsoft continues to evolve the way they're building and releasing Windows in the future, they may introduce new channels to bring you new experiences.

![Windows Insider Channels, Recommended Ones](https://learn.microsoft.com/en-us/windows-insider/images/channelsmovev2.png)

For more information about the insider program, please see the [Windows Insider Program website](https://insider.windows.com)

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

_Windows 11 Version Next (Release Preview Channel)_
```batch
uupdownload -s Professional -e Professional -v 10.0.22621.100 -r External -b ReleasePreview -c ni_release -t arm64 -l en-US
```

_Windows 11 Version Next (Beta Channel)_
```batch
uupdownload -s Professional -e Professional -v 10.0.22621.100 -r External -b Beta -c ni_release -t arm64 -l en-US
```

_Windows vNext (Dev Channel)_
```batch
uupdownload -s Professional -e Professional -v 10.0.22621.100 -r External -b Dev -c ni_release -t arm64 -l en-US
```

_Windows vNext (Canary Channel)_
```batch
uupdownload -s Professional -e Professional -v 10.0.22621.100 -r External -b CanaryChannel -c ni_release -t arm64 -l en-US
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