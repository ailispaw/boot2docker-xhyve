# Making a fresh persistent disk

## Make a blank disk image on Max OS X

4GB for example

```
$ dd if=/dev/zero of=boot2docker-data.img bs=1g count=4
4+0 records in
4+0 records out
4294967296 bytes transferred in 11.442139 secs (375364023 bytes/sec)
```

## Set up a persistent disk

- Boot it on xhyve
- Download and execute [makehdd.sh](https://github.com/ailispaw/boot2docker-xhyve/blob/master/contrib/makehdd/makehdd.sh)

```
$ sudo ./xhyverun.sh

Core Linux
boot2docker login: docker
                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/
 _                 _   ____     _            _
| |__   ___   ___ | |_|___ \ __| | ___   ___| | _____ _ __
| '_ \ / _ \ / _ \| __| __) / _` |/ _ \ / __| |/ / _ \ '__|
| |_) | (_) | (_) | |_ / __/ (_| | (_) | (__|   <  __/ |
|_.__/ \___/ \___/ \__|_____\__,_|\___/ \___|_|\_\___|_|
Boot2Docker version 1.7.1, build xhyve : 9a59e50 - Thu Jul 16 00:26:02 UTC 2015
Docker version 1.7.1, build 786b29d
docker@boot2docker:~$ curl -OL https://raw.githubusercontent.com/ailispaw/boot2docker-xhyve/master/contrib/makehdd/makehdd.sh
docker@boot2docker:~$ chmod +x makehdd.sh
docker@boot2docker:~$ sudo ./makehdd.sh
docker@boot2docker:~$ sudo fdisk -l

Disk /dev/vda: 4294 MB, 4294967296 bytes
64 heads, 32 sectors/track, 4096 cylinders
Units = cylinders of 2048 * 512 = 1048576 bytes

   Device Boot      Start         End      Blocks  Id System
/dev/vda1             956        4096     3216384  83 Linux
/dev/vda2               1         955      977904  82 Linux swap

Partition table entries are not in disk order
docker@boot2docker:~$ ls -l /mnt/vda1/var/lib/boot2docker
total 8
-rwxr-xr-x    1 root     root           250 Jul  3 21:43 bootsync.sh
-rw-r--r--    1 root     root            14 Jul  3 21:43 profile
docker@boot2docker:~$ sudo halt
docker@boot2docker:~$ reboot: System halted
$ 
```

Done.
