all: initrd.img vmlinuz64 boot2docker.iso boot2docker-data.img exports

initrd.img vmlinuz64: boot2docker.iso
	hdiutil mount boot2docker.iso
	cp /Volumes/Boot2Docker-v1.7/boot/$@ .
	hdiutil unmount /Volumes/Boot2Docker-v1.7

boot2docker.iso:
	curl -OL https://github.com/boot2docker/boot2docker/releases/download/v1.7.0/boot2docker.iso

boot2docker-data.img: boot2docker-data.tar.gz
	tar zxvf boot2docker-data.tar.gz

boot2docker-data.tar.gz:
	curl -OL https://github.com/ailispaw/boot2docker-xhyve/releases/download/v0.2.1/boot2docker-data.tar.gz

clean: exports-clean uuid2ip-clean
	$(RM) initrd.img vmlinuz64
	$(RM) boot2docker.iso
	$(RM) boot2docker-data.img
	$(RM) boot2docker-data.tar.gz

.PHONY: all clean

UID = $(shell id -u)
GID = $(shell id -g)
USERS = /Users -network 192.168.64.0 -mask 255.255.255.0 -alldirs -mapall=$(UID):$(GID)

exports:
	@sudo touch /etc/exports
	@if ! grep -qs '^$(USERS)$$' /etc/exports; \
	then \
		echo '$(USERS)' | sudo tee -a /etc/exports; \
	fi;
	sudo nfsd restart

exports-clean:
	@sudo touch /etc/exports
	sudo sed -E -e '/^\$(USERS)$$/d' -i.bak /etc/exports
	sudo nfsd restart

.PHONY: exports exports-clean

run:
	osascript xhyverun.scpt

.PHONY: run

ssh: .mac_address
	ssh docker@`contrib/uuid2ip/mac2ip.sh $(shell cat .mac_address)` || true

uuid2ip:
	cd contrib/uuid2ip && make

uuid2ip-clean:
	cd contrib/uuid2ip && make clean
	$(RM) .mac_address

.PHONY: ssh uuid2ip uuid2ip-clean
