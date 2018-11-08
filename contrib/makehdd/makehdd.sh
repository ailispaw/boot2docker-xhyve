#!/bin/sh

MNT=/mnt/vda1

curl -L https://raw.githubusercontent.com/ailispaw/boot2docker-xhyve/master/config/profile \
  -o ${MNT}/var/lib/boot2docker/profile
curl -L https://raw.githubusercontent.com/ailispaw/boot2docker-xhyve/master/config/bootsync.sh \
  -o ${MNT}/var/lib/boot2docker/bootsync.sh
chmod +x ${MNT}/var/lib/boot2docker/bootsync.sh

sync; sync; sync
