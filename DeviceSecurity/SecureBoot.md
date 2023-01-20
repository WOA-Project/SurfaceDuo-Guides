# Secure Boot on Surface Duo devices with SurfaceDuoPkg

Starting with version 230X.XX of SurfaceDuoPkg, Secure Boot is now supported on select Surface Duo devices.

While SurfaceDuoPkg comes with its own set of certificates for SecureBoot, some people may be interested in using their own keys for their own security purposes.

This guide aims to document the process to use your own certificates to sign drivers.

## Prerequisites

- A technician computer with Windows 11 version 22621 or higher and 4K OLED Monitor
- A Surface Duo with SurfaceDuoPkg version 230X.XX or higher
- A USB cable
- The ability to compile SurfaceDuoPkg in order to use your own keyset
- A HSM is preferred for Secure Key storage. This guide will not detail how to proceed with a HSM, but rather will show how to proceed with self signed certificate stored outside of a HSM. You will want to store certificates securely.
- A copy of SurfaceDuo-Drivers for your device
- The Windows SDK/ADK/WDK for signtool and makecat
- An internet connection for timestamping

## Create Secure Boot keys

Here we'll generate self signed certificate on our local machine. You _definitely_ want to use an HSM for security reasons. (You may want a SmartCard PKI Card for example)

Open powershell on your compute and run the following commands, replacing things whenever needed:

_Note: below source code is heavily inspired from https://github.com/ms-iot/iot-adk-addonkit/blob/17763-v7/Tools/IoTCoreImaging/IoTSecurity.ps1_

```pwsh
    $MakeCert = "C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x64\makecert.exe" # Replace with your own path!
    $pvkpfx = "C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x64\pvk2pfx.exe" # Replace with your own path!

    $outputDir = ".\Certs"
    New-DirIfNotExist "$outputDir\private"
    $OemName = "OEMA0"
    # Filenames
    $Root = "$outputDir\$OemName-Root"
    $RootPri = "$outputDir\private\$OemName-Root"
    $CA = "$outputDir\$OemName-CA"
    $CAPri = "$outputDir\private\$OemName-CA"
    $PCA = "$outputDir\$OemName-PCA"
    $PCAPri = "$outputDir\private\$OemName-PCA"
    $PK = "$outputDir\$OemName-RootPK"
    $PKPri = "$outputDir\private\$OemName-RootPK"
    $KEK = "$outputDir\$OemName-KEK"
    $KEKPri = "$outputDir\private\$OemName-KEK"
    $KMCI = "$outputDir\$OemName-KMCI"
    $KMCIPri = "$outputDir\private\$OemName-KMCI"
    $UMCI = "$outputDir\$OemName-UMCI"
    $UMCIPri = "$outputDir\private\$OemName-UMCI"
    $BitlockerDRA = "$outputDir\$OemName-DRA"
    $BitlockerDRAPri = "$outputDir\private\$OemName-DRA"

    $ReApply = Test-Path "$RootPri.pfx"
    if ($ReApply -eq $False) {
        Publish-Status "Creating $RootPri.pfx"
        & $MakeCert -r -pe -n "CN=OEMA0 Root" -ss CA -sr CurrentUser -a sha256 -len 4096 -cy authority -sky signature -sv "$RootPri.pvk" "$Root.cer"
        & $pvkpfx -pvk "$RootPri.pvk" -spc "$Root.cer" -pfx "$RootPri.pfx"
    }

    $ReApply = Test-Path "$CAPri.pfx"
    if ($ReApply -eq $False) {
        Publish-Status "Creating $CAPri.pfx"
        & $MakeCert -pe -n "CN=OEMA0 CA" -ss CA -sr CurrentUser -a sha256 -len 4096 -cy authority -sky signature -iv "$RootPri.pvk" -ic "$Root.cer" -sv "$CAPri.pvk" "$CA.cer"
        & $pvkpfx -pvk "$CAPri.pvk" -spc "$CA.cer" -pfx "$CAPri.pfx"
    }

    $ReApply = Test-Path "$PCAPri.pfx"
    if ($ReApply -eq $False) {
        $year = Get-Date -Format "yyyy"
        Publish-Status "Creating $PCAPri.pfx"
        & $MakeCert -pe -n "CN=OEMA0 Production PCA $year" -ss CA -sr CurrentUser -a sha256 -len 4096 -cy authority -sky signature -iv "$CAPri.pvk" -ic "$CA.cer" -sv "$PCAPri.pvk" "$PCA.cer"
        & $pvkpfx -pvk "$PCAPri.pvk" -spc "$PCA.cer" -pfx "$PCAPri.pfx"
    }

    $ReApply = Test-Path "$KMCIPri.pfx"
    if ($ReApply -eq $False) {
        Publish-Status "Creating $KMCIPri.pfx"
        & $MakeCert -pe -n "CN=OEMA0 KMCI Codesigning, E=info@contoso.com" -sr CurrentUser -a sha256 -len 2048 -cy end -eku 1.3.6.1.5.5.7.3.3 -sky signature -iv "$PCAPri.pvk" -ic "$PCA.cer" -sv "$KMCIPri.pvk" "$KMCI.cer"
        & $pvkpfx -pvk "$KMCIPri.pvk" -spc "$KMCI.cer" -pfx "$KMCIPri.pfx"
    }

    $ReApply = Test-Path "$UMCIPri.pfx"
    if ($ReApply -eq $False) {
        Publish-Status "Creating $UMCIPri.pfx"
        & $MakeCert -pe -n "CN=OEMA0 UMCI Codesigning, E=info@contoso.com" -sr CurrentUser -a sha256 -len 2048 -cy end -eku 1.3.6.1.5.5.7.3.3 -sky signature -iv "$PCAPri.pvk" -ic "$PCA.cer" -sv "$UMCIPri.pvk" "$UMCI.cer"
        & $pvkpfx -pvk "$UMCIPri.pvk" -spc "$UMCI.cer" -pfx "$UMCIPri.pfx"
    }

    #Making PK a root cert
    $ReApply = Test-Path "$PKPri.pfx"
    if ($ReApply -eq $False) {
        Publish-Status "Creating $PKPri.pfx"
        & $MakeCert -r -pe -n "CN=OEMA0 Root Platform Key" -ss CA -sr CurrentUser -a sha256 -len 4096 -cy authority -sky signature -sv "$PKPri.pvk"  "$PK.cer"
        & $pvkpfx -pvk "$PKPri.pvk" -spc "$PK.cer" -pfx "$PKPri.pfx"
    }

    #KEK is derived out of PK instead of PCA
    $ReApply = Test-Path "$KEKPri.pfx"
    if ($ReApply -eq $False) {
        Publish-Status "Creating $KEKPri.pfx"
        & $MakeCert -pe -n "CN=OEMA0 KEK Secure Boot" -sr CurrentUser -a sha256 -len 4096 -cy end -sky signature -iv "$PKPri.pvk" -ic "$PK.cer" -sv "$KEKPri.pvk"  "$KEK.cer"
        & $pvkpfx -pvk "$KEKPri.pvk" -spc "$KEK.cer" -pfx "$KEKPri.pfx"
    }

    $ReApply = Test-Path "$BitlockerDRAPri.pfx"
    if ($ReApply -eq $False) {
        Publish-Status "Creating $BitlockerDRAPri.pfx"
        & $MakeCert -pe -n "CN=OEMA0 Data Recovery Agent" -sr CurrentUser -a sha256 -len 2048 -cy end -eku 1.3.6.1.4.1.311.67.1.2 -sky exchange -iv "$PCAPri.pvk" -ic "$PCA.cer" -sv "$BitlockerDRAPri.pvk" "$BitlockerDRA.cer"
        & $pvkpfx -pvk "$BitlockerDRAPri.pvk" -spc "$BitlockerDRA.cer" -pfx "$BitlockerDRAPri.pfx"
    }

    Remove-Item "$outputDir\private\*.pvk" -Force
    if ($ReApply) {
        Publish-Warning "Certificates already exist. See $outputDir"
    }
    else {
        Publish-Success "Certificates created. See $outputDir"
    }
```

## Embed the new keys into your SurfaceDuoPkg compile

## Generate a new System Integrity Policy

## Generate a new Self-Signed Driver Enabler package

## Resigning Driver binaries for Kernel Mode use (KMCI)

## Resigning Driver binaries for User Mode use (UMCI)

## Reinstalling Drivers

## Boot Test
