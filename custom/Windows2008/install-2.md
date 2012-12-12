2. Unattended install with ImageX
==============================

```
net use \\bootsrv.example.com\data
diskpart /s \\bootsrv.example.com\data\install-2-CreatePartitions.txt
ImageX /apply \\bootsrv.example.com\data\Windows2008\install.wim 1 W:\

bcdboot W:\Windows /s S:
reboot
```

