DVER:=v5.0
DNAME:=mp1-openstlinux
DUSER:=siana

build:
	docker build -t $(DNAME):$(DVER) . && \
	docker tag $(DNAME):$(DVER) $(DUSER)/$(DNAME):$(DVER)

push:
	docker push $(DUSER)/$(DNAME):$(DVER)

pull:
	docker pull $(DUSER)/$(DNAME):$(DVER)
