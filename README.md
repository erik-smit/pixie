pixie
=====

W.I.P

Usage
-----

- Setup tftpd, httpd pointing to /srv/tftp
- Put pxelinux in /srv/tftp
- ````cd /srv/tftp
mkdir pxelinux.cfg
git clone git@github.com:erik-smit/pixie
cd pixie
for i in scripts/*; do $i; done
make````
- dhcpd.conf ````group {
  filename "gpxelinux.0";
  next-server 193.16.154.63;

  host somebody { hardware ethernet 0:c0:c3:49:2b:57; }
}````
