2. Unattended install with ImageX
==============================

```
net use Z: \\bootsrv.example.com\data
diskpart /s Z:\install-2-CreatePartitions.txt
ImageX /apply Z:\Extracted_ISO\sources\\install.wim 1 W:\

bcdboot W:\Windows /s S:
reboot
```

