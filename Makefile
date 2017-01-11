VERSION := v1.12.6

all: initrd.img vmlinuz64 boot2docker-data.img uuid2ip

upgrade:
	$(RM) boot2docker.iso
	$(MAKE)

initrd.img vmlinuz64: boot2docker.iso
	hdiutil mount boot2docker.iso
	cp /Volumes/b2d-$(VERSION)/boot/$@ . && sync
	hdiutil unmount /Volumes/b2d-$(VERSION)

boot2docker.iso:
	curl -OL https://github.com/boot2docker/boot2docker/releases/download/$(VERSION)/boot2docker.iso

boot2docker-data.img: boot2docker-data.tar.gz
	tar zxvf boot2docker-data.tar.gz

boot2docker-data.tar.gz:
	curl -OL https://github.com/ailispaw/boot2docker-xhyve/releases/download/v0.6.0/boot2docker-data.tar.gz

clean: exports-clean uuid2ip-clean
	$(RM) initrd.img vmlinuz64
	$(RM) boot2docker.iso
	$(RM) boot2docker-data.img
	$(RM) boot2docker-data.tar.gz

.PHONY: all upgrade clean

EXPORTS = $(shell ./vmnet_export.sh)

exports:
	@if [ -n "$(EXPORTS)" ]; then \
		sudo touch /etc/exports; \
		if ! grep -qs '^$(EXPORTS)$$' /etc/exports; \
		then \
			echo '$(EXPORTS)' | sudo tee -a /etc/exports; \
		fi; \
		sudo nfsd restart; \
	else \
		echo "It seems your first run for xhyve with vmnet."; \
		echo "You can't use NFS shared folder at this time."; \
		echo "But it should be available at the next boot."; \
	fi;

exports-clean:
	@if [ -n "$(EXPORTS)" ]; then \
		sudo touch /etc/exports; \
		sudo sed -E -e '/^\$(EXPORTS)$$/d' -i.bak /etc/exports; \
		sudo nfsd restart; \
	fi;

.PHONY: exports exports-clean

run: xhyveexec.sh xhyverun.sh
	@sudo echo "Booting up..." # to input password at the current window in advance
	@./xhyveexec.sh

.PHONY: run

IP = `uuid2ip/mac2ip.sh $(shell cat .mac_address)`
ID = docker
PW = tcuser

mac: .mac_address
	@cat .mac_address

ip: .mac_address
	@echo $(IP)

SSH_ARGS = -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no

ssh: .mac_address
	@expect -c ' \
		spawn -noecho ssh $(ID)@'$(IP)' $(SSH_ARGS) $(filter-out $@,$(MAKECMDGOALS)); \
		expect "(yes/no)?" { send "yes\r"; exp_continue; } "password:" { send "$(PW)\r"; }; \
		interact; \
	'

halt: .mac_address
	@expect -c ' \
		spawn -noecho ssh $(ID)@'$(IP)' $(SSH_ARGS) sudo halt; \
		expect "(yes/no)?" { send "yes\r"; exp_continue; } "password:" { send "$(PW)\r"; }; \
		interact; \
	'
	@echo "Shutting down..."

env:
	@echo "export DOCKER_HOST=tcp://$(IP):2375;"
	@echo "unset DOCKER_CERT_PATH;"
	@echo "unset DOCKER_TLS_VERIFY;"

uuid2ip: uuid2ip/build/uuid2mac

uuid2ip/build/uuid2mac:
	$(MAKE) -C uuid2ip

uuid2ip-clean:
	$(MAKE) -C uuid2ip clean
	$(RM) .mac_address

.PHONY: mac ip ssh halt uuid2ip uuid2ip-clean

.DEFAULT:
	@:
