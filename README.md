# Boot2Docker running on xhyve hypervisor

## Features

- boot2docker v1.6.2
- Disable TLS
- Expose the official IANA registered Docker port 2375
- Support NFS synced folder at /Users

## Requirements

- [xhyve](https://github.com/mist64/xhyve)
  - Mac OS X Yosemite 10.10.3 or later
  - A 2010 or later Mac (i.e. a CPU that supports EPT)
- Other hypervisors like VirtualBox must ***NOT*** be running at the same time, or crash.

## Installing xhyve

```
$ git clone https://github.com/mist64/xhyve
$ cd xhyve
$ make
$ cp build/xhyve /usr/local/bin/ # You may need sudo.
```

## Getting Boot2Docker Images

```
$ git clone https://github.com/ailispaw/boot2docker-xhyve
$ cd boot2docker-xhyve
$ make
```

## Booting Up

```
$ sudo ./xhyverun.sh
Password:

Core Linux
boot2docker login: 
```

## Logging In

### for Console

```
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
Boot2Docker version 1.6.2, build master : 4534e65 - Wed May 13 21:24:28 UTC 2015
Docker version 1.6.2, build 7c8fca2
docker@boot2docker:~$ ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 16:C1:B5:29:CF:32
          inet addr:192.168.64.3  Bcast:192.168.64.255  Mask:255.255.255.0
          inet6 addr: fe80::14c1:b5ff:fe29:cf32/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:44 errors:0 dropped:0 overruns:0 frame:0
          TX packets:48 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:7026 (6.8 KiB)  TX bytes:7617 (7.4 KiB)

docker@boot2docker:~$ 
```

### for SSH

Use IP address (192.168.64.X) shown avobe.

- ID: docker
- Password: tcuser

```
$ ssh docker@192.168.64.3
docker@192.168.64.3's password:
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
Boot2Docker version 1.6.2, build master : 4534e65 - Wed May 13 21:24:28 UTC 2015
Docker version 1.6.2, build 7c8fca2
docker@boot2docker:~$
```

## Shutting Down

Use `halt` command to shut down.

```
docker@boot2docker:~$ sudo halt
docker@boot2docker:~$ reboot: System halted
$ 
```

## Using Docker

Use IP address (192.168.64.X) shown avobe as well.

```
$ docker -H 192.168.64.3:2375 info
Containers: 0
Images: 0
Storage Driver: aufs
 Root Dir: /mnt/vda1/var/lib/docker/aufs
 Backing Filesystem: extfs
 Dirs: 0
 Dirperm1 Supported: true
Execution Driver: native-0.2
Kernel Version: 4.0.3-boot2docker
Operating System: Boot2Docker 1.6.2 (TCL 5.4); master : 4534e65 - Wed May 13 21:24:28 UTC 2015
CPUs: 1
Total Memory: 998.1 MiB
Name: boot2docker
ID: IZSU:6VGT:R6NN:XV2K:ESMF:U2T7:IPKU:IVEN:6RPQ:ZDKK:ZPOD:MGH5
Debug mode (server): true
Debug mode (client): false
Fds: 11
Goroutines: 16
System Time: Sun Jun 14 00:35:02 UTC 2015
EventsListeners: 0
Init SHA1: 7f9c6798b022e64f04d2aff8c75cbf38a2779493
Init Path: /usr/local/bin/docker
Docker Root Dir: /mnt/vda1/var/lib/docker
```

## Resources

- [bootpd -- Mac OS X's built-in DHCP/BOOTP/NetBoot server](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man8/bootpd.8.html)
  - /etc/bootpd.plist
  - /var/db/dhcpd_leases
