# pixie

## Description

Pixie generates a syslinux menu with netinstallers.

By using the HTTP-support in PXELinux, it can do this without requiring local copies of kernels, initrds, etc.

Where possible, it will use a netinstaller or syslinux-menu as provided by the distribution.
If not, it will just load the vmlinuz and initrd with the required parameters.

## Supported OSes

### Distribution-menu

- ARCH Linux
- Debian Linux
- Ubuntu Linux

### vmlinuz/initrd

- CentOS Linux
- Fedora Linux
- OpenSUSE Linux
- PUIAS Linux
- Scientific Linux
 
## Screenshots

![Screenshot 1](/img/pixie1.png)
![Screenshot 2](/img/pixie2.png)
![Screenshot 3](/img/pixie3.png)
![Screenshot 4](/img/pixie4.png)
![Screenshot 5](/img/pixie5.png)
![Screenshot 6](/img/pixie6.png)
![Screenshot 7](/img/pixie7.png)
![Screenshot 8](/img/pixie8.png)
![Screenshot 9](/img/pixie9.png)
![Screenshot 10](/img/pixie10.png

## Requirements

- Syslinux (4.06 recommended. 5.xx and 6.xx have issues with HTTP-loading, MENUs, etc.)
- make

##  Usage

- Setup tftpd, httpd pointing to /srv/tftp
- Put pxelinux in /srv/tftp

- Setup pixie 
```
cd /srv/tftp
mkdir pxelinux.cfg
echo "UI menu.c32" > pxelinux.cfg/default
echo "INCLUDE pxelinux.cfg/pixie.cfg" >> pxelinux.cfg/default
git clone git@github.com:erik-smit/pixie
cd pixie
make
```
- Config dhcpd.conf 
```
group {
  filename "gpxelinux.0";
  next-server 193.16.154.63;

  host somebody { hardware ethernet 0:c0:c3:49:2b:57; }
}
```
