# Secure Boot on Surface Duo devices with SurfaceDuoPkg

Starting with version 230X.XX of SurfaceDuoPkg, Secure Boot is now supported on select Surface Duo devices.

While SurfaceDuoPkg comes with its own set of certificates for SecureBoot, some people may be interested in using their own keys for their own security purposes.

This guide aims to document the process to use your own certificates to sign drivers.

## Prerequisites

- [A technician computer with Windows 11 version 22621 or higher and 4K OLED Monitor](https://www.lenovo.com/us/en/p/laptops/thinkpad/thinkpadp/thinkpad-p16-(16-inch-intel)/len101t0041)
- [A Surface Duo](https://www.ebay.com/sch/i.html?_from=R40&_trksid=p2334524.m570.l1313&_nkw=Surface+Duo&_sacat=0&LH_TitleDesc=0&_osacat=0&_odkw=surface+duo) with [SurfaceDuoPkg](https://github.com/WOA-Project/SurfaceDuoPkg) version 230X.XX or higher
- [A USB cable](https://www.amazon.com/Anker-Charging-MacBook-Galaxy-Charger/dp/B088NMR44C)
- [The ability to compile SurfaceDuoPkg in order to use your own keyset](https://github.com/WOA-Project/SurfaceDuoPkg#build-instructions)
- A HSM is preferred for Secure Key storage. This guide will not detail how to proceed with a HSM, but rather will show how to proceed with self signed certificate stored outside of a HSM. You will want to store certificates securely.
- A copy of [SurfaceDuo-Drivers](https://github.com/WOA-Project/SurfaceDuo-Drivers) for your device
- [The Windows SDK/ADK/WDK for signtool and makecat](https://learn.microsoft.com/en-us/windows-hardware/drivers/download-the-wdk#enterprise-wdk-ewdk)
- [An internet connection for timestamping](https://www.aol.com/)

## Create Secure Boot keys

Here we'll generate self signed certificate on our local machine. You _definitely_ want to use an HSM for security reasons. (You may want a SmartCard PKI Card for example)

Open powershell on your computer and run the following commands, replacing things whenever needed:

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

### Generate Certificate Lists

```pwsh
    Publish-Status "DB list : "
    $db
    Import-Module secureboot
    # Get current time in format "yyyy-MM-ddTHH':'mm':'ss'Z'"
    $time = (Get-date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

    # DB
    $objectFromFormat = (Format-SecureBootUEFI -Name db -SignatureOwner 77fa9abd-0359-4d32-bd60-28f4e78f784b -FormatWithCert -CertificateFilePath $db -SignableFilePath ".\db.bin" -Time $time -AppendWrite: $false)
    & "C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x86\signtool.exe" "sign" "-v" "/fd" "sha256" "/p7" "." "/p7co" "1.2.840.113549.1.7.1" "/p7ce" "DetachedSignedData" "/a" "/u" "1.3.6.1.4.1.311.79.2.1" "/sha1" "$keksigncerttp" ".\db.bin"
    $objectFromFormat | Set-SecureBootUEFI -SignedFilePath ".\db.bin.p7" -OutputFilePath ".\SetVariable_db.bin" | Out-Null
    Publish-Status "Key Exchange Keys : "
    $kekcert

    # KEK
    $objectFromFormat = (Format-SecureBootUEFI -Name KEK -SignatureOwner 00000000-0000-0000-0000-000000000000 -FormatWithCert -CertificateFilePath $kekcert -SignableFilePath ".\kek.bin" -Time $time -AppendWrite: $false)
    & "C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x86\signtool.exe" "sign" "-v" "/fd" "sha256" "/p7" "." "/p7co" "1.2.840.113549.1.7.1" "/p7ce" "DetachedSignedData" "/a" "/sha1" ".p" ".\kek.bin"
    $objectFromFormat | Set-SecureBootUEFI -SignedFilePath ".\kek.bin.p7" -OutputFilePath ".\SetVariable_kek.bin" | Out-Null

    # PK
    $objectFromFormat = (Format-SecureBootUEFI -Name PK -SignatureOwner 55555555-5555-5555-5555-555555555555 -FormatWithCert -CertificateFilePath $pkcert -SignableFilePath ".\pk.bin" -Time $time -AppendWrite: $false)
    & "C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x86\signtool.exe" "sign" "-v" "/fd" "sha256" "/p7" "." "/p7co" "1.2.840.113549.1.7.1" "/p7ce" "DetachedSignedData" "/a" "/sha1" "$pksigncerttp" ".\pk.bin"
    $objectFromFormat | Set-SecureBootUEFI -SignedFilePath ".\pk.bin.p7" -OutputFilePath ".\SetVariable_pk.bin" | Out-Null
```

### Embed the new keys into the UEFI

Now that we generated valid UEFI Certificate lists and signed them, we need to embed these files into the locations described in the following sections.

#### KEK (kek.bin.p7)

![image](https://user-images.githubusercontent.com/3755345/213809796-b13d3620-b509-4b74-a0bb-788d4fd33f13.png)

[KEK Byte Array Code Location](https://github.com/WOA-Project/SurfaceDuoPkg/blob/6ed3fb88b36ad8e5ae80901fdd328c98c5c5c748/Platforms/SurfaceDuoFamilyPkg/Library/SecureBootKeyStoreLib/MsSecureBootDefaultVars.h#L17-L203)

#### DB (db.bin.p7)

![image](https://user-images.githubusercontent.com/3755345/213809926-aa6fe964-7bd2-4f3e-9503-01616c57e325.png)

[DB Byte Array Code Location](https://github.com/WOA-Project/SurfaceDuoPkg/blob/6ed3fb88b36ad8e5ae80901fdd328c98c5c5c748/Platforms/SurfaceDuoFamilyPkg/Library/SecureBootKeyStoreLib/MsSecureBootDefaultVars.h#L207-L403)

#### PK (pk.bin.p7)

![image](https://user-images.githubusercontent.com/3755345/213808143-818c6148-14c1-4304-918a-fc993ea3d932.png)

[PK Byte Array Code Location](https://github.com/WOA-Project/SurfaceDuoPkg/blob/6ed3fb88b36ad8e5ae80901fdd328c98c5c5c748/Platforms/SurfaceDuoFamilyPkg/Library/SecureBootKeyStoreLib/SecureBootKeyStoreLib.c#L25-L114)

#### Rebuilding

Once done, recompile SurfaceDuoPkg as usual with your new changes.

_TIP: Use the built in Azure DevOps CI to save time!_

## Generate a new System Integrity Policy

### Creating the SiPolicy XML file

Using below's template, fill in the missing Certificate Thumbprints using your own generated certificates from earlier. Once done save the entire file as ```SiPolicy.xml```.

_Note: Please see "C:\Windows\schemas\CodeIntegrity\ExamplePolicies\DefaultWindows_Enforced.xml" for comparisons_

```xml
<?xml version="1.0" encoding="utf-8"?>
<SiPolicy xmlns="urn:schemas-microsoft-com:sipolicy">
  <VersionEx>10.0.0.0</VersionEx>
  <PolicyTypeID>{A244370E-44C9-4C06-B551-F6016E563076}</PolicyTypeID>
  <PlatformID>{2E07F7E4-194C-4D20-B7C9-6F4AA6C5A234}</PlatformID>
  <Rules>
    <Rule>
      <Option>Enabled:Unsigned System Integrity Policy</Option>
    </Rule>
    <Rule>
      <Option>Enabled:Advanced Boot Options Menu</Option>
    </Rule>
    <Rule>
      <Option>Enabled:Inherit Default Policy</Option>
    </Rule>
    <Rule>
      <Option>Enabled:Update Policy No Reboot</Option>
    </Rule>
    <Rule>
      <Option>Enabled:Dynamic Code Security</Option>
    </Rule>
    <Rule>
      <Option>Enabled:Revoked Expired As Unsigned</Option>
    </Rule>
    <Rule>
      <Option>Enabled:Allow Supplemental Policies</Option>
    </Rule>
  </Rules>
  <!--EKUS-->
  <EKUs>
    <EKU ID="ID_EKU_WINDOWS" Value="010A2B0601040182370A0306" />
    <EKU ID="ID_EKU_WHQL" Value="010A2B0601040182370A0305" />
    <EKU ID="ID_EKU_ELAM" Value="010A2B0601040182373D0401" />
    <EKU ID="ID_EKU_HAL_EXT" Value="010a2b0601040182373d0501" />
    <EKU ID="ID_EKU_RT_EXT" Value="010a2b0601040182370a0315" />
    <EKU ID="ID_EKU_STORE" FriendlyName="Windows Store EKU - 1.3.6.1.4.1.311.76.3.1 Windows Store" Value="010a2b0601040182374c0301" />
    <EKU ID="ID_EKU_DCODEGEN" FriendlyName="Dynamic Code Generation EKU - 1.3.6.1.4.1.311.76.5.1" Value="010A2B0601040182374C0501" />
    <EKU ID="ID_EKU_AM" FriendlyName="AntiMalware EKU -1.3.6.1.4.1.311.76.11.1 " Value="010a2b0601040182374c0b01" />
  </EKUs>
  <!--File Rules-->
  <FileRules>
    <FileAttrib ID="ID_FILEATTRIB_REFRESH_POLICY" FriendlyName="RefreshPolicy.exe FileAttribute" FileName="RefreshPolicy.exe" MinimumFileVersion="10.0.19042.0" />
  </FileRules>
  <!--Signers-->
  <Signers>
    <Signer ID="ID_SIGNER_WINDOWS_PRODUCTION" Name="Microsoft Product Root 2010 Windows EKU">
      <CertRoot Type="Wellknown" Value="06" />
      <CertEKU ID="ID_EKU_WINDOWS" />
    </Signer>
    <Signer ID="ID_SIGNER_ELAM_PRODUCTION" Name="Microsoft Product Root 2010 ELAM EKU">
      <CertRoot Type="Wellknown" Value="06" />
      <CertEKU ID="ID_EKU_ELAM" />
    </Signer>
    <Signer ID="ID_SIGNER_HAL_PRODUCTION" Name="Microsoft Product Root 2010 HAL EKU">
      <CertRoot Type="Wellknown" Value="06" />
      <CertEKU ID="ID_EKU_HAL_EXT" />
    </Signer>
    <Signer ID="ID_SIGNER_WHQL_SHA2" Name="Microsoft Product Root 2010 WHQL EKU">
      <CertRoot Type="Wellknown" Value="06" />
      <CertEKU ID="ID_EKU_WHQL" />
    </Signer>
    <Signer ID="ID_SIGNER_WHQL_SHA1" Name="Microsoft Product Root WHQL EKU SHA1">
      <CertRoot Type="Wellknown" Value="05" />
      <CertEKU ID="ID_EKU_WHQL" />
    </Signer>
    <Signer ID="ID_SIGNER_WHQL_MD5" Name="Microsoft Product Root WHQL EKU MD5">
      <CertRoot Type="Wellknown" Value="04" />
      <CertEKU ID="ID_EKU_WHQL" />
    </Signer>
    <Signer ID="ID_SIGNER_WINDOWS_PRODUCTION_USER" Name="Microsoft Product Root 2010 Windows EKU">
      <CertRoot Type="Wellknown" Value="06" />
      <CertEKU ID="ID_EKU_WINDOWS" />
    </Signer>
    <Signer ID="ID_SIGNER_ELAM_PRODUCTION_USER" Name="Microsoft Product Root 2010 ELAM EKU">
      <CertRoot Type="Wellknown" Value="06" />
      <CertEKU ID="ID_EKU_ELAM" />
    </Signer>
    <Signer ID="ID_SIGNER_HAL_PRODUCTION_USER" Name="Microsoft Product Root 2010 HAL EKU">
      <CertRoot Type="Wellknown" Value="06" />
      <CertEKU ID="ID_EKU_HAL_EXT" />
    </Signer>
    <Signer ID="ID_SIGNER_WHQL_SHA2_USER" Name="Microsoft Product Root 2010 WHQL EKU">
      <CertRoot Type="Wellknown" Value="06" />
      <CertEKU ID="ID_EKU_WHQL" />
    </Signer>
    <Signer ID="ID_SIGNER_WHQL_SHA1_USER" Name="Microsoft Product Root WHQL EKU SHA1">
      <CertRoot Type="Wellknown" Value="05" />
      <CertEKU ID="ID_EKU_WHQL" />
    </Signer>
    <!-- Flighting related signers -->
    <Signer ID="ID_SIGNER_WINDOWS_FLIGHT_ROOT" Name="Microsoft Flighting Root 2014 Windows EKU">
      <CertRoot Type="Wellknown" Value="0E" />
      <CertEKU ID="ID_EKU_WINDOWS" />
    </Signer>
    <Signer ID="ID_SIGNER_ELAM_FLIGHT" Name="Microsoft Flighting Root 2014 ELAM EKU">
      <CertRoot Type="Wellknown" Value="0E" />
      <CertEKU ID="ID_EKU_ELAM" />
    </Signer>
    <Signer ID="ID_SIGNER_HAL_FLIGHT" Name="Microsoft Flighting Root 2014 HAL EKU">
      <CertRoot Type="Wellknown" Value="0E" />
      <CertEKU ID="ID_EKU_HAL_EXT" />
    </Signer>
    <Signer ID="ID_SIGNER_WHQL_FLIGHT_SHA2" Name="Microsoft Flighting Root 2014 WHQL EKU">
      <CertRoot Type="Wellknown" Value="0E" />
      <CertEKU ID="ID_EKU_WHQL" />
    </Signer>
    <Signer ID="ID_SIGNER_WINDOWS_FLIGHT_ROOT_USER" Name="Microsoft Flighting Root 2014 Windows EKU">
      <CertRoot Type="Wellknown" Value="0E" />
      <CertEKU ID="ID_EKU_WINDOWS" />
    </Signer>
    <Signer ID="ID_SIGNER_ELAM_FLIGHT_USER" Name="Microsoft Flighting Root 2014 ELAM EKU">
      <CertRoot Type="Wellknown" Value="0E" />
      <CertEKU ID="ID_EKU_ELAM" />
    </Signer>
    <Signer ID="ID_SIGNER_HAL_FLIGHT_USER" Name="Microsoft Flighting Root 2014 HAL EKU">
      <CertRoot Type="Wellknown" Value="0E" />
      <CertEKU ID="ID_EKU_HAL_EXT" />
    </Signer>
    <Signer ID="ID_SIGNER_WHQL_FLIGHT_SHA2_USER" Name="Microsoft Flighting Root 2014 WHQL EKU">
      <CertRoot Type="Wellknown" Value="0E" />
      <CertEKU ID="ID_EKU_WHQL" />
    </Signer>
    <Signer ID="ID_SIGNER_WHQL_MD5_USER" Name="Microsoft Product Root WHQL EKU MD5">
      <CertRoot Type="Wellknown" Value="04" />
      <CertEKU ID="ID_EKU_WHQL" />
    </Signer>
    <Signer ID="ID_SIGNER_STORE" Name="Microsoft MarketPlace PCA 2011">
      <CertRoot Type="TBS" Value="FC9EDE3DCCA09186B2D3BF9B738A2050CB1A554DA2DCADB55F3F72EE17721378" />
      <CertEKU ID="ID_EKU_STORE" />
    </Signer>
    <Signer ID="ID_SIGNER_STORE_FLIGHT_ROOT" Name="Microsoft Flighting Root 2014 Store EKU">
      <CertRoot Type="Wellknown" Value="0E" />
      <CertEKU ID="ID_EKU_STORE" />
    </Signer>
    <Signer ID="ID_SIGNER_RT_PRODUCTION" Name="Microsoft Product Root 2010 RT EKU">
      <CertRoot Type="Wellknown" Value="06" />
      <CertEKU ID="ID_EKU_RT_EXT" />
    </Signer>
    <Signer ID="ID_SIGNER_RT_FLIGHT" Name="Microsoft Flighting Root 2014 RT EKU">
      <CertRoot Type="Wellknown" Value="0E" />
      <CertEKU ID="ID_EKU_RT_EXT" />
    </Signer>
    <Signer ID="ID_SIGNER_RT_STANDARD" Name="Microsoft Standard Root 2011 RT EKU">
      <CertRoot Type="Wellknown" Value="07" />
      <CertEKU ID="ID_EKU_RT_EXT" />
    </Signer>
    <Signer ID="ID_SIGNER_TEST2010" Name="MincryptKnownRootMicrosoftTestRoot2010">
      <CertRoot Type="Wellknown" Value="0A" />
    </Signer>
    <Signer ID="ID_SIGNER_TEST2010_USER" Name="MincryptKnownRootMicrosoftTestRoot2010">
      <CertRoot Type="Wellknown" Value="0A" />
    </Signer>
    <Signer ID="ID_SIGNER_DRM" Name="MincryptKnownRootMicrosoftDMDRoot2005">
      <CertRoot Type="Wellknown" Value="0C" />
    </Signer>
    <Signer ID="ID_SIGNER_DCODEGEN" Name="MincryptKnownRootMicrosoftProductRoot2010">
      <CertRoot Type="Wellknown" Value="06" />
      <CertEKU ID="ID_EKU_DCODEGEN" />
    </Signer>
    <Signer ID="ID_SIGNER_AM" Name="MincryptKnownRootMicrosoftStandardRoot2011">
      <CertRoot Type="Wellknown" Value="07" />
      <CertEKU ID="ID_EKU_AM" />
    </Signer>
    <Signer ID="ID_SIGNER_MICROSOFT_REFRESH_POLICY" Name="Microsoft Code Signing PCA 2011">
      <CertRoot Type="TBS" Value="F6F717A43AD9ABDDC8CEFDDE1C505462535E7D1307E630F9544A2D14FE8BF26E" />
      <CertPublisher Value="Microsoft Corporation" />
      <FileAttribRef RuleID="ID_FILEATTRIB_REFRESH_POLICY" />
    </Signer>
    <Signer ID="ID_SIGNER_S_1A_1_0_0" Name="OEMA0 KEK Secure Boot">
      <CertRoot Type="TBS" Value="<YOUR CERTFICIATE THUMBPRINT GOES HERE>" />
    </Signer>
    <Signer ID="ID_SIGNER_S_19_1_0_0" Name="OEMA0 KEK Secure Boot">
      <CertRoot Type="TBS" Value="<YOUR CERTFICIATE THUMBPRINT GOES HERE>" />
    </Signer>
    <Signer ID="ID_SIGNER_S_1C_1_0" Name="OEMA0 UMCI Codesigning">
      <CertRoot Type="TBS" Value="<YOUR CERTFICIATE THUMBPRINT GOES HERE>" />
    </Signer>
    <Signer ID="ID_SIGNER_S_1B_1_0_0" Name="OEMA0 KEK Secure Boot">
      <CertRoot Type="TBS" Value="<YOUR CERTFICIATE THUMBPRINT GOES HERE>" />
    </Signer>
    <Signer ID="ID_SIGNER_S_1D_1" Name="OEMA0 KMCI Codesigning">
      <CertRoot Type="TBS" Value="<YOUR CERTFICIATE THUMBPRINT GOES HERE>" />
    </Signer>
    <Signer ID="ID_SIGNER_S_1E_1" Name="OEMA0 KMCI Codesigning">
      <CertRoot Type="TBS" Value="<YOUR CERTFICIATE THUMBPRINT GOES HERE>" />
    </Signer>
  </Signers>
  <SigningScenarios>
    <!--Kernel Mode Signing Scenario-->
    <SigningScenario Value="131" ID="ID_SIGNINGSCENARIO_KMCI" FriendlyName="Kernel Mode Signing Scenario">
      <ProductSigners>
        <AllowedSigners>
          <AllowedSigner SignerId="ID_SIGNER_WINDOWS_PRODUCTION" />
          <AllowedSigner SignerId="ID_SIGNER_ELAM_PRODUCTION" />
          <AllowedSigner SignerId="ID_SIGNER_HAL_PRODUCTION" />
          <AllowedSigner SignerId="ID_SIGNER_WHQL_SHA2" />
          <AllowedSigner SignerId="ID_SIGNER_WHQL_SHA1" />
          <AllowedSigner SignerId="ID_SIGNER_WHQL_MD5" />
          <AllowedSigner SignerId="ID_SIGNER_WINDOWS_FLIGHT_ROOT" />
          <AllowedSigner SignerId="ID_SIGNER_ELAM_FLIGHT" />
          <AllowedSigner SignerId="ID_SIGNER_HAL_FLIGHT" />
          <AllowedSigner SignerId="ID_SIGNER_WHQL_FLIGHT_SHA2" />
          <!-- Test signer is trusted by ConfigCI, however, it will not be trusted by CI unless testsigning BCD is set -->
          <AllowedSigner SignerId="ID_SIGNER_TEST2010" />
          <AllowedSigner SignerId="ID_SIGNER_S_1A_1_0_0" />
          <AllowedSigner SignerId="ID_SIGNER_S_1E_1" />
        </AllowedSigners>
      </ProductSigners>
    </SigningScenario>
    <!--User Mode Signing Scenario-->
    <SigningScenario Value="12" ID="ID_SIGNINGSCENARIO_UMCI" FriendlyName="User Mode Signing Scenario">
      <ProductSigners>
        <AllowedSigners>
          <AllowedSigner SignerId="ID_SIGNER_WINDOWS_PRODUCTION_USER" />
          <AllowedSigner SignerId="ID_SIGNER_ELAM_PRODUCTION_USER" />
          <AllowedSigner SignerId="ID_SIGNER_HAL_PRODUCTION_USER" />
          <AllowedSigner SignerId="ID_SIGNER_WHQL_SHA2_USER" />
          <AllowedSigner SignerId="ID_SIGNER_WHQL_SHA1_USER" />
          <AllowedSigner SignerId="ID_SIGNER_WHQL_MD5_USER" />
          <AllowedSigner SignerId="ID_SIGNER_WINDOWS_FLIGHT_ROOT_USER" />
          <AllowedSigner SignerId="ID_SIGNER_ELAM_FLIGHT_USER" />
          <AllowedSigner SignerId="ID_SIGNER_HAL_FLIGHT_USER" />
          <AllowedSigner SignerId="ID_SIGNER_WHQL_FLIGHT_SHA2_USER" />
          <AllowedSigner SignerId="ID_SIGNER_STORE" />
          <AllowedSigner SignerId="ID_SIGNER_STORE_FLIGHT_ROOT" />
          <AllowedSigner SignerId="ID_SIGNER_RT_PRODUCTION" />
          <AllowedSigner SignerId="ID_SIGNER_DRM" />
          <AllowedSigner SignerId="ID_SIGNER_DCODEGEN" />
          <AllowedSigner SignerId="ID_SIGNER_AM" />
          <AllowedSigner SignerId="ID_SIGNER_RT_FLIGHT" />
          <AllowedSigner SignerId="ID_SIGNER_RT_STANDARD" />
          <AllowedSigner SignerId="ID_SIGNER_MICROSOFT_REFRESH_POLICY" />
          <!-- Test signer is trusted by ConfigCI, however, it will not be trusted by CI unless testsigning BCD is set -->
          <AllowedSigner SignerId="ID_SIGNER_TEST2010_USER" />
          <AllowedSigner SignerId="ID_SIGNER_S_19_1_0_0" />
          <AllowedSigner SignerId="ID_SIGNER_S_1C_1_0" />
          <AllowedSigner SignerId="ID_SIGNER_S_1D_1" />
        </AllowedSigners>
      </ProductSigners>
    </SigningScenario>
  </SigningScenarios>
  <UpdatePolicySigners>
    <UpdatePolicySigner SignerId="ID_SIGNER_S_1B_1_0_0" />
  </UpdatePolicySigners>
  <!-- 

    CiSigners are signers that ConfigCI asks CI to trust for all builds, include 
    retail builds.
    
    Normally CiSigners is empty or only includes production signers. For enterprise
    ConfigCI policy, you may need to include enterprise signers. Just make sure it
    is understood that CiSigners will be trusted by CI for all builds.

-->
  <CiSigners>
    <!--
      Currently Centennial Apps are launched as Win32 Apps and signed by store certificate.
      We need to allow enterprise signing scenario to trust store certificate.
    -->
    <CiSigner SignerId="ID_SIGNER_STORE" />
    <CiSigner SignerId="ID_SIGNER_S_19_1_0_0" />
    <CiSigner SignerId="ID_SIGNER_S_1C_1_0" />
    <CiSigner SignerId="ID_SIGNER_S_1D_1" />
  </CiSigners>
  <HvciOptions>0</HvciOptions>
  <Settings>
    <Setting Provider="PolicyInfo" Key="Information" ValueName="Name">
      <Value>
        <String>DefaultWindowsOnAndromedaEnforced</String>
      </Value>
    </Setting>
    <Setting Provider="PolicyInfo" Key="Information" ValueName="Id">
      <Value>
        <String>011623</String>
      </Value>
    </Setting>
  </Settings>
</SiPolicy>
```

### Convert SiPolicy.xml to SiPolicy.p7b

```pwsh
ConvertFrom-CIPolicy -XmlFilePath ".\SiPolicy.xml" -BinaryFilePath ".\SiPolicy.bin"

# Use sha1 thumbprint to identify the cert for signing. Cert must be available in CurrentUser store (from smartcard or local machine)
$signcerttp = (Get-PfxCertificate -FilePath ".\OEMA0-KEK.cer").Thumbprint

& "C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x86\signtool.exe" "sign" "-v" "/s" "my" "/sha1" "$signcerttp" "/p7" "." "/p7co" "1.3.6.1.4.1.311.79.1" "/fd" "sha256" ".\SiPolicy.bin"
Copy-Item -Path ".\SiPolicy.bin.p7" -Destination ".\SiPolicy.p7b" -Force
```

## Generate a new Self-Signed Driver Enabler package

Self-Signed Driver Enabler ([SSDE](https://github.com/valinet/ssde) for short) is a driver written by @Valinet designed to help maintain Custom Kernel Policy Signer Licensing persistence in the Operating System. If you understood nothing from this sentence, _this is normal_, but just follow along. (For people curious, you can read the excellent write up by Geoff Chappell on the matter: [Licensed Driver Signing in Windows 10](https://www.geoffchappell.com/notes/windows/license/customkernelsigners.htm))

In case you do not trust the binary in the Surface Duo Drivers package, feel free to rebuild it using the WDK of your choice. Just be aware the WDK must be of version 18362 if you want to run the driver on 18362 and may require [some api changes in regards to pool apis](https://learn.microsoft.com/en-us/windows-hardware/drivers/wdk-known-issues#issue-in-exallocatepoolzero-exallocatepoolquotazero-and-exallocatepoolpriorityzero-functions-fixed). Once built, replace the sys file (and only this file) in ```/components/ANYSOC/Support/Desktop/SUPPORT.DESKTOP.BASE/Signature/SSDE/ssde.sys```

Navigate to ```/components/ANYSOC/Support/Desktop/SUPPORT.DESKTOP.BASE/Signature/SSDE/``` in the driver package you downloaded, replace the existing SiPolicy.p7b file with the one you just built on your own.

## Resigning Driver binaries for Kernel Mode use (KMCI)

## Resigning Driver binaries for User Mode use (UMCI)

## Reinstalling Drivers

## Boot Test
