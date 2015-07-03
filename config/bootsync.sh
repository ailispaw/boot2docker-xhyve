#!/bin/sh

mkdir -p /Users
umount /Users
/usr/local/etc/init.d/nfs-client start
GW_IP=$(ip route get 8.8.8.8 | awk 'NR==1 {print $3}')
if [ -n "${GW_IP}" ]; then
  mount ${GW_IP}:/Users /Users -o rw,async,noatime,rsize=32768,wsize=32768,proto=tcp
fi
