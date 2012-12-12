# Requirements:

# Windows AIK (http://www.microsoft.com/en-us/download/details.aspx?id=5753)
# KVM virtio drivers in c:\temp

# Create PE development environment
copype.cmd amd64 C:\winpe_amd64

# Add virtio network and storage drivers to the WIM
dism /mount-wim /wimfile:winpe.wim /mountdir:mount /index:1
dism /image:mount /add-driver /driver:c:\temp\netkvm\2k8\amd64\netkvm.inf
dism /image:mount /add-driver /driver:c:\temp\viostor\2k8\amd64\viostor.inf
dism /unmount-wim /mountdir:mount /commit

# Add ImageX for offline installations
copy "C:\Program Files\Windows AIK\Tools\amd64\imagex.exe"  C:\winpe_amd64\ISO\

# Move the created .WIM into the ISO to be packed
copy C:\winpe_amd64\winpe.wim C:\winpe_amd64\ISO\sources\boot.wim

# Pack the ISO.
Oscdimg -n -bC:\winpe_amd64\Etfsboot.com C:\winpe_amd64\ISO C:\winpe_amd64\winpe_amd64.iso

# pxelinux config:
#
# LABEL Windows2008
#   KERNEL http://pixie.zoiah.net/memdisk
#   APPEND iso
#   INITRD http://pixie.zoiah.net/winpe_amd64.iso

