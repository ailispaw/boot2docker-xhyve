# Boot2Docker running on xhyve hypervisor

## Features

- boot2docker v1.7.1
- Disable TLS
- Expose the official IANA registered Docker port 2375
- Support NFS synced folder at /Users

## Requirements

- [xhyve](https://github.com/mist64/xhyve)
  - Mac OS X Yosemite 10.10.3 or later
  - A 2010 or later Mac (i.e. a CPU that supports EPT)

## Caution

- **Kernel Panic** will occur on booting, once VirtualBox (< v5.0) has run before.

## Installing xhyve

```
$ git clone https://github.com/mist64/xhyve
$ cd xhyve
$ make
$ cp build/xhyve /usr/local/bin/ # You may need sudo.
```

## Setting up Boot2Docker images and tools

```
$ git clone https://github.com/ailispaw/boot2docker-xhyve
$ cd boot2docker-xhyve
$ make
```

## Booting Up

```
$ sudo ./xhyverun.sh

Core Linux
boot2docker login: 
```

or

```
$ make run
Booting up...
```

- On Termial.app: This will open a new window, then you will see in the window as below.
- On iTerm.app: This will split the current window, then you will see in the bottom pane as below.

```
Core Linux
boot2docker login: 
```

## Logging In

- ID: docker
- Password: tcuser

```
$ make ssh
spawn ssh docker@192.168.64.3 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
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
Boot2Docker version 1.7.1, build xhyve : 9a59e50 - Thu Jul 16 00:26:02 UTC 2015
Docker version 1.7.1, build 786b29d
docker@boot2docker:~$ 
```

## Shutting Down

Use `halt` command to shut down in the VM.

```
docker@boot2docker:~$ sudo halt
docker@boot2docker:~$ reboot: System halted
$ 
```

or

```
$ make halt
spawn ssh docker@192.168.64.3 sudo halt
docker@192.168.64.3's password:
Shutting down...
```

## Using Docker

```
$ docker -H `make ip`:2375 info
Containers: 2
Images: 5
Storage Driver: aufs
 Root Dir: /mnt/vda1/var/lib/docker/aufs
 Backing Filesystem: extfs
 Dirs: 9
 Dirperm1 Supported: true
Execution Driver: native-0.2
Logging Driver: json-file
Kernel Version: 4.0.7-boot2docker
Operating System: Boot2Docker 1.7.1 (TCL 6.3); xhyve : 9a59e50 - Thu Jul 16 00:26:02 UTC 2015
CPUs: 1
Total Memory: 996.3 MiB
Name: boot2docker
ID: B243:SVE5:H5FI:MV3P:CUHD:6FG5:O4RY:OBLJ:G34P:4SEC:XCMS:7GIY
Debug mode (server): true
File Descriptors: 21
Goroutines: 32
System Time: 2015-07-30T19:21:48.722587684Z
EventsListeners: 0
Init SHA1:
Init Path: /usr/local/bin/docker
Docker Root Dir: /mnt/vda1/var/lib/docker
```

## Resources

- /var/db/dhcpd_leases
- /Library/Preferences/SystemConfiguration/com.apple.vmnet.plist
  - Shared_Net_Address
  - Shared_Net_Mask
