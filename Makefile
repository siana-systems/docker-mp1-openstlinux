CWD:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
DVER:=v2.0
DNAME:=mp1-openstlinux
DUSER:=siana
OVER:=openstlinux-5.4-dunfell-mp1-20-06-24
OURL:=https://github.com/STMicroelectronics/oe-manifest.git
ODWN:=downloads
OSSC:=sstate-cache

build:
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
	mkdir $(OVER) && \
	repo init -u $(OURL) -b refs/tags/$(OVER) && \
	repo sync
