CWD:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
DVER:=v1.0
DNAME:=mp1-openstlinux
DUSER:=siana
OVER:=openstlinux-4.19-thud-mp1-19-02-20

build:
	cd admin && docker build -t $(DNAME):$(DVER) . && docker tag $(DNAME):$(DVER) $(DUSER)/$(DNAME):$(DVER)

push:
	docker push $(DUSER)/$(DNAME):$(DVER)

pull:
	docker pull $(DUSER)/$(DNAME):$(DVER)

run:
	docker run -v $(CWD)/$(OVER):/repo \
	-v $(CWD)/downloads:/downloads \
	-v $(CWD)/sstate-cache:/sstate-cache \
	-it $(DUSER)/$(DNAME):$(DVER)

sources:
	admin/get_sources.sh $(OVER)
