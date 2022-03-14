# Creating a Windows ISO with UUPMediaCreator

- Presuming you are working on a Windows 64-bit machine, download and extract win64.zip file from [the UUPMediaCreator repo](https://github.com/gus33000/UUPMediaCreator). 
- Navigate to this directory: `"win-x64\CLI" `

-  Inside the CLI directory, open command prompt and run the following command:

```
uupdownload -s Professional -e Professional -v 10.0.22000.100 -r Retail -b Retail -c co_release -t arm64 -l en-US
```

This will download the professional edition of Windows 11 retail copy for arm64 architecture for English version. If you want to change the language, 
use the standard Windows language pack commands. Installing the right language pack will save a lot of time for download. 

- Once the download is completed, you will see a new folder with prefix "10.0.22000..." created inside the CLI folder. This 
  contains all the required Windows 11 files. Let's create an ISO from the Windows 11 build download. Open up the command prompt and type:

```
UUPMediaConverter.exe -u <10.0.22000... name of your Windows 11 build folder> -i Windows11_Pro_arm64_en-US.iso -l en-US -e Professional
```

- Once that's done, mount the newly created `Windows11_Pro_arm64_en-US.iso` on your Windows machine. You will find the install.wim file in your mounted ISO drive in `G:\sources\install.wim`. 
