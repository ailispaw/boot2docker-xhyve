#!/bin/sh

LABEL=boot2docker-data

DEV=/dev/vda
MNT=/mnt/vda1

(echo n; echo p; echo 2; echo; echo +1000M; echo w) | fdisk ${DEV}
(echo t; echo 82; echo w) | fdisk ${DEV}
until [ -b "${DEV}2" ]; do
  sleep 0.5
done
mkswap ${DEV}2

(echo n; echo p; echo 1; echo; echo; echo w) | fdisk ${DEV}
until [ -b "${DEV}1" ]; do
  sleep 0.5
done
mkfs.ext4 -b 4096 -i 4096 -L ${LABEL} ${DEV}1

mkdir -p ${MNT}
mount ${DEV}1 ${MNT}
mkdir -p ${MNT}/var/lib/boot2docker

curl -L https://raw.githubusercontent.com/ailispaw/boot2docker-xhyve/master/config/profile \
  -o ${MNT}/var/lib/boot2docker/profile
curl -L https://raw.githubusercontent.com/ailispaw/boot2docker-xhyve/master/config/bootsync.sh \
  -o ${MNT}/var/lib/boot2docker/bootsync.sh
chmod +x ${MNT}/var/lib/boot2docker/bootsync.sh

sync; sync; sync
