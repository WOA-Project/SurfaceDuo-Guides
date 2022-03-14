# Creating a Windows ISO with UUPMediaCreator

- Presuming you are working on a Windows 64-bit machine, download and extract win64.zip file from [the UUPMediaCreator repo](https://github.com/gus33000/UUPMediaCreator). 
- Navigate to this directory: `"win-x64\CLI" `

-  Inside the CLI directory, open command prompt and run the following command:

```
uupdownload -s Professional -e Professional -v 10.0.19043.1 -r Retail -b Retail -c vb_release -t arm64 -l en-US
```

This will download the professional edition of Windows 11 retail copy for arm64 architecture for English version. If you want to change the language, 
use the standard Windows language pack commands. Installing the right language pack will save a lot of time for download. 

- Once the download is completed, you will see a new folder with prefix "10.0.19043.1586..." created inside the CLI folder. This 
  contains all the required Windows 11 files. Let's create an ISO from the Windows 11 build download. Open up the command prompt and type:

```
UUPMediaConverter.exe -u <10.0.19043.1586...name of your Win 11 build folder> -i Win11.iso -l en-US -e Professional
```

- Once that's done, mount the newly created `Win11.iso` on your Windows machine. You will find the install.wim file in your mounted ISO drive in `G:\sources\install.wim`. 
