# Boot2Docker running on xhyve hypervisor

## Features

- boot2docker v1.7.0
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

## Setting up Boot2Docker images and tools

```
$ git clone https://github.com/ailispaw/boot2docker-xhyve
$ cd boot2docker-xhyve
$ make
```

## Booting Up

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
spawn ssh docker@192.168.64.3
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
Boot2Docker version 1.7.0, build master : 7960f90 - Thu Jun 18 18:31:45 UTC 2015
Docker version 1.7.0, build 0baf609
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
Containers: 0
Images: 0
Storage Driver: aufs
 Root Dir: /mnt/vda1/var/lib/docker/aufs
 Backing Filesystem: extfs
 Dirs: 0
 Dirperm1 Supported: true
Execution Driver: native-0.2
Kernel Version: 4.0.5-boot2docker
Operating System: Boot2Docker 1.7.0 (TCL 6.3); master : 7960f90 - Thu Jun 18 18:31:45 UTC 2015
CPUs: 1
Total Memory: 996.3 MiB
Name: boot2docker
ID: HE5H:JSGX:VJ2D:WQKX:7CQV:2G4I:XCM7:5OVO:CNFW:RREP:KWUA:ZTZ3
Debug mode (server): true
Debug mode (client): false
Fds: 10
Goroutines: 15
System Time: Fri Jun 19 04:05:38 UTC 2015
EventsListeners: 0
Init Path: /usr/local/bin/docker
Docker Root Dir: /mnt/vda1/var/lib/docker
Http Proxy:
Https Proxy:
No Proxy:
```

## Resources

- [bootpd -- Mac OS X's built-in DHCP/BOOTP/NetBoot server](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man8/bootpd.8.html)
  - /etc/bootpd.plist
  - /var/db/dhcpd_leases
