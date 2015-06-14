all: initrd.img vmlinuz64 boot2docker.iso boot2docker-data.img

initrd.img vmlinuz64: boot2docker.iso
	hdiutil mount boot2docker.iso
	cp /Volumes/Boot2Docker-v1.6/boot/$@ .
	hdiutil unmount /Volumes/Boot2Docker-v1.6

boot2docker.iso:
	curl -OL https://github.com/boot2docker/boot2docker/releases/download/v1.6.2/boot2docker.iso

boot2docker-data.img: boot2docker-data.tar.gz
	tar zxvf boot2docker-data.tar.gz

boot2docker-data.tar.gz:
	curl -OL https://github.com/ailispaw/boot2docker-xhyve/releases/download/v0.1.0/boot2docker-data.tar.gz

clean:
	$(RM) initrd.img vmlinuz64
	$(RM) boot2docker.iso
	$(RM) boot2docker-data.img
	$(RM) boot2docker-data.tar.gz

.PHONY: all clean
