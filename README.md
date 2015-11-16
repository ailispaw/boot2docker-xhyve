# Boot2Docker running on xhyve hypervisor

## Features

- boot2docker v1.8.3
- Disable TLS
- Expose the official IANA registered Docker port 2375
- Support NFS synced folder: /Users is NFS-mounted on the boot2docker VM.

## Requirements

- [xhyve](https://github.com/mist64/xhyve)
  - Mac OS X Yosemite 10.10.3 or later
  - A 2010 or later Mac (i.e. a CPU that supports EPT)

## Caution

- **Kernel Panic** will occur on booting, if VirtualBox (< v5.0) has run before.
- Pay attention to **exposing the port 2375 without TLS**, as you see the features.

## Installing xhyve

```
$ git clone https://github.com/mist64/xhyve
$ cd xhyve
$ make
$ cp build/xhyve /usr/local/bin/    # You may require sudo
```

or

```
$ brew install xhyve
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
$ make run    # You may be asked for your sudo password
Booting up...
```

- On Terminal.app: This will open a new window, then you will see in the window as below.
- On iTerm.app: This will split the current window, then you will see in the bottom pane as below.

```
Core Linux
boot2docker login: 
```

## Logging In

- ID: docker
- Password: tcuser (in most instances you will not be prompted for a password)

```
$ make ssh
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
Boot2Docker version 1.8.3, build master : af8b089 - Mon Oct 12 18:56:54 UTC 2015
Docker version 1.8.3, build f4bf5c7
docker@boot2docker:~$ 
```

## Shutting Down

Use `halt` command to shut down in the VM:

```
docker@boot2docker:~$ sudo halt
docker@boot2docker:~$ reboot: System halted
$ 
```

or, use `make halt` on the host:

```
$ make halt
docker@192.168.64.3's password:
Shutting down...
```

## Using Docker

You can simply run Docker within the VM. However, if you install the Docker client on the host, you can use Docker commands natively on the host Mac. Install the Docker client as follows:

```
$ curl -L https://get.docker.com/builds/Darwin/x86_64/docker-latest -o docker
$ chmod +x docker
$ mv docker /usr/local/bin/    # You may require sudo
```

Alternatively install with Homebrew:

```
$ brew install docker
```

Then, in the VM, or on the host if you have installed the Docker client:

```
$ make env
export DOCKER_HOST=tcp://192.168.64.3:2375;
unset DOCKER_CERT_PATH;
unset DOCKER_TLS_VERIFY;
$ eval $(make env)

$ docker info
Containers: 0
Images: 0
Storage Driver: aufs
 Root Dir: /mnt/vda1/var/lib/docker/aufs
 Backing Filesystem: extfs
 Dirs: 0
 Dirperm1 Supported: true
Execution Driver: native-0.2
Logging Driver: json-file
Kernel Version: 4.1.10-boot2docker
Operating System: Boot2Docker 1.8.3 (TCL 6.4); master : af8b089 - Mon Oct 12 18:56:54 UTC 2015
CPUs: 1
Total Memory: 996.2 MiB
Name: boot2docker
ID: NRCK:2H7Z:XXXS:SS3P:5Q4Z:7IQS:O2PK:ESRA:TLJO:GGA5:NAXH:3EOV
Debug mode (server): true
File Descriptors: 14
Goroutines: 16
System Time: 2015-10-15T00:59:34.007611747Z
EventsListeners: 0
Init SHA1:
Init Path: /usr/local/bin/docker
Docker Root Dir: /mnt/vda1/var/lib/docker
```

## Upgrading Boot2Docker

When Boot2Docker is upgraded and boot2docker-xhyve is updated,

```
$ git pull origin master
$ make upgrade
```

## Resources

- /var/db/dhcpd_leases
- /Library/Preferences/SystemConfiguration/com.apple.vmnet.plist
  - Shared_Net_Address
  - Shared_Net_Mask
