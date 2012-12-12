Source: http://dice.neko-san.net/2011/05/slipstreaming-windows-2008r2-sp1-into-the-win2k8r2-install-wim/

Start the AIK Deployment Tools Command Prompt and create some directories:

```
mkdir c:\data\up\
mkdir c:\data\up\sp1
mkdir c:\data\up\sp1e
mkdir c:\data\up\wim
```

Unpack windows6.1-KB976932-X64.exe: (background operation, monitor in task manager)

```
D:\>windows6.1-KB976932-X64.exe /x:c:\data\up\sp1
```

Unpack the main cab file inside the service pack:

```
C:\data\up\sp1>7z x c:\data\up\sp1\windows6.1-KB976932-X64.cab -oc:\data\up\sp1e -r
```

Unpack the cab files within the main cab file:

```
C:\data\up\sp1e>7z x NestedMPPContent.cab -r -y
C:\data\up\sp1e>7z x KB976933-LangsCab0.cab -r -y
C:\data\up\sp1e>7z x KB976933-LangsCab1.cab -r -y
C:\data\up\sp1e>7z x KB976933-LangsCab2.cab -r -y
C:\data\up\sp1e>7z x KB976933-LangsCab3.cab -r -y
C:\data\up\sp1e>7z x KB976933-LangsCab4.cab -r -y
C:\data\up\sp1e>7z x KB976933-LangsCab5.cab -r -y
C:\data\up\sp1e>7z x KB976933-LangsCab6.cab -r -y
````

Delete the unpacked cab files, and a couple of other index files:

```
C:\data\up\sp1e>erase NestedMPPContent.cab old_cabinet.cablist.ini cabinet.cablist.ini KB976933-LangsCab*.cab /S /Q
```

Modify files to permit offline installation:

In c:\data\up\sp1e\Windows7SP1-KB976933~31bf3856ad364e35~amd64~~6.1.1.17514.mum, change:

```
<mum:packageExtended xmlns:mum="urn:schemas-microsoft-com:asm.v3" allowedOffline="false" projectionPeakDisk="359" langProjectionPeakDisk="512" sqmBuildNumber="7601" sqmAttemptAppid="101457923" sqmResultAppid="101457924" sqmPoqexecAppid="101457925"/></package>
```

to:

```
<mum:packageExtended xmlns:mum="urn:schemas-microsoft-com:asm.v3" allowedOffline="true" projectionPeakDisk="359" langProjectionPeakDisk="512" sqmBuildNumber="7601" sqmAttemptAppid="101457923" sqmResultAppid="101457924" sqmPoqexecAppid="101457925"/></package>
```

In c:\data\up\sp1e\update.mum, change:

```
<mum:packageExtended xmlns:mum="urn:schemas-microsoft-com:asm.v3" allowedOffline="false" projectionPeakDisk="359" langProjectionPeakDisk="512" sqmBuildNumber="7601" sqmAttemptAppid="101457923" sqmResultAppid="101457924" sqmPoqexecAppid="101457925"/></package>
```

to:

```
<mum:packageExtended xmlns:mum="urn:schemas-microsoft-com:asm.v3" allowedOffline="true" projectionPeakDisk="359" langProjectionPeakDisk="512" sqmBuildNumber="7601" sqmAttemptAppid="101457923" sqmResultAppid="101457924" sqmPoqexecAppid="101457925"/></package>
```

In c:\data\up\sp1e\update.ses, change:

```
<Tasks operationMode="OfflineInstall">
        <Phase>
                <package id="Windows7SP1-KB976933~31bf3856ad364e35~amd64~~6.1.1.17514" targetState="Absent"/>
        </Phase>
</Tasks>
```

to:

```
<Tasks operationMode="OfflineInstall">
        <Phase>
                <package id="Windows7SP1-KB976933~31bf3856ad364e35~amd64~~6.1.1.17514" targetState="Installed"/>
        </Phase>
</Tasks>
```

Copy install.wim from win2008r2:

```
C:\data\up>copy e:\sources\install.wim c:\data\up
```

(Optional) Get index information on install.wim to pick the right index to install to (or install to multiple indexes, one at a time):

```
C:\data\up>dism /get-wiminfo /wimfile:c:\data\up\install.wim
```

Mount install.wim with the correct index (6 == Windows Server 2008 R2 SERVERDATACENTERCORE)

```
C:\data\up>dism /mount-wim /wimfile:c:\data\up\install.wim /index:6 /mountdir:c:\data\up\wim
```

Upgrade mounted wim:

```
C:\data\up>dism /image:c:\data\up\wim /logpath:c:\data\up\error.log /add-package /packagepath:c:\data\up\sp1e
```

Unmount wim and commit changes:

```
C:\data\up>dism /unmount-wim /mountdir:c:\data\up\wim /commit
```

Compress the wim:

```
C:\data\up>imagex /export c:\data\up\install.wim * c:\data\up\install2.wim /check /compress maximum
C:\data\up>del install.wim
C:\data\up>move install2.wim install.wim
```


