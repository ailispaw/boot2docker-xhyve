# Making SSH easy

License: BSD as well as [xhybe](https://github.com/mist64/xhyve)

config.mk and uuid.h are from xhybe and most of main.c is from xhyve, too.

## Seting up

```
$ git clone https://github.com/ailispaw/boot2docker-xhyve
$ cd boot2docker-xhyve
$ make
$ make uuid2ip
cd contrib/uuid2ip && make
cc main.c
ld uuid2mac.sym
dsym uuid2mac.dSYM
strip uuid2mac
```

## Booting up

```
$ sudo ./vhyverun.sh

Core Linux
boot2docker login: 
```

## SSH from another terminal

```
$ make ssh
ssh docker@`contrib/uuid2ip/mac2ip.sh 16:c1:b5:29:cf:32`
The authenticity of host '192.168.64.3 (192.168.64.3)' can't be established.
RSA key fingerprint is 52:5f:26:c3:21:0c:48:b0:d4:d6:ea:fc:5d:73:5b:29.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.64.3' (RSA) to the list of known hosts.
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
