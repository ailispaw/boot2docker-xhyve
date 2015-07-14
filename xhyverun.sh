#!/bin/sh

KERNEL="vmlinuz64"
INITRD="initrd.img"
#CMDLINE="earlyprintk=serial console=ttyS0 acpi=off"
CMDLINE="loglevel=3 user=docker console=ttyS0 console=tty0 noembed nomodeset norestore waitusb=10:LABEL=boot2docker-data base host=boot2docker"

ACPI="-A"
MEM="-m 1G"
#SMP="-c 2"
NET="-s 2:0,virtio-net"
#IMG_CD="-s 3,ahci-cd,boot2docker.iso"
IMG_HDD="-s 4,virtio-blk,boot2docker-data.img"
PCI_DEV="-s 0:0,hostbridge -s 31,lpc"
LPC_DEV="-l com1,stdio"

UUID="bb60a7fd-2655-4927-88a6-fdd1e2223ddc"
if [ -n "${UUID}" ]; then
  if [ -x "uuid2ip/build/uuid2mac" ]; then
    MAC_ADDRESS=$(uuid2ip/build/uuid2mac ${UUID})
    if [ -n "${MAC_ADDRESS}" ]; then
      echo "${MAC_ADDRESS}" > .mac_address
    else
      exit 1
    fi
  fi
  UUID="-U ${UUID}"
fi

while [ 1 ]; do
  xhyve $ACPI $MEM $SMP $PCI_DEV $LPC_DEV $NET $IMG_CD $IMG_HDD $UUID -f kexec,$KERNEL,$INITRD,"$CMDLINE"
  if [ $? -ne 0 ]; then
    break
  fi
done
exit 0
