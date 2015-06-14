#!/bin/sh

umount /Users
mkdir -p /Users
/usr/local/etc/init.d/nfs-client start
mount 192.168.64.1:/Users /Users -o rw,async,noatime,rsize=32768,wsize=32768,proto=tcp
