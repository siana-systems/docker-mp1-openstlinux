CWD:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
DVER:=v1.1
DNAME:=mp1-openstlinux
DUSER:=siana
OVER:=openstlinux-20-02-19
OURL:=https://github.com/STMicroelectronics/oe-manifest.git
ODWN:=downloads
OSSC:=sstate-cache

build:
	cd admin && \
	docker build -t $(DNAME):$(DVER) . && \
	docker tag $(DNAME):$(DVER) $(DUSER)/$(DNAME):$(DVER)

push:
	docker push $(DUSER)/$(DNAME):$(DVER)

pull:
	docker pull $(DUSER)/$(DNAME):$(DVER)

run:
	docker run -v $(CWD)/$(OVER):/repo \
	-v $(CWD)/$(ODWN):/$(ODWN) \
	-v $(CWD)/$(OSSC):/$(OSSC) \
	-it $(DUSER)/$(DNAME):$(DVER)

sources:
	cd $(OVER) && \
	repo init -u $(OURL) -b refs/tags/$(OVER) && \
	repo sync

folders:
	@read -e -r -p "Repository full path: " pth; ln -s $$pth $(OVER)
	@read -e -r -p "Downloads full path: " pth; ln -s $$pth $(ODWN)
	@read -e -r -p "Cache full path: " pth; ln -s $$pth $(OSSC)
