LOCALIP=`/sbin/ifconfig | perl -n -e 's/inet addr:(192[\d.]+)/print $$1/eg'`

Target: help ## Description
	@echo

.FORCE:

help: ##  This help dialog.
	@cat $(MAKEFILE_LIST) | perl -ne 's/(^\S+): .*##\s*(.+)/printf " %-16s %s\n", $$1,$$2/eg'

consul: .FORCE ## Run consul container
	#cd $@; docker build -t rpi-$@ .
	docker run -d --net=host --name=consul -p 8500:8500 -v /data \
	   hypriot/rpi-$@ \
	   agent -server -data-dir=/data -bootstrap-expect=1 -ui-dir=/ui
	   #agent -server -data-dir=/data -bootstrap-expect=1 -ui-dir=/ui -advertise=$(LOCALIP)
	   docker logs $@

registrator: .FORCE ## Run registrator container
	#cd $@; docker build -t rpi-$@ .
	docker run -d --name=registrator --net=host -v /var/run/docker.sock:/tmp/docker.sock  \
	   hypriot/rpi-$@ -internal consul://localhost:8500
	   docker logs $@

consul-template: .FORCE ## Run consul-template container
	#cd $@; docker build -t rpi-$@ .
	docker run -d --name=consul-template -v ./haproxy/:/haproxy/ \
	   hypriot/rpi-$@ -consul localhost:8500 -template "./haproxy/haproxy.ctmpl:./haproxy/haproxy.cfg:make haproxy-restart"
	   docker logs $@

haproxy: .FORCE ## Run haproxy container
	cd $@; docker build -t rpi-$@ .
	docker run -d --net=host -v --name=haproxy  ./haproxy/:/haproxy/ \
	  rpi-$@ -p 81:80 
	  docker logs $@

haproxy-restart: ## Restart haproxy container
	echo testing

worker: .FORCE ## Run another worker app container
	cd $@; docker build -t rpi-$@ .
	docker run -d -v /data \
	   rpi-$@ 

all: consul registrator consul-template haproxy worker ## Bring up all the containers
	echo testing

clean: ## Remove all containers
	docker stop `docker ps -a -q`
	docker rm `docker ps -a -q`

test: ## Basic testing
	echo testing

show-services: ## Show services registered in consul
	curl -s localhost:8500/v1/catalog/services | jq .
	curl -s localhost:8500/v1/catalog/service/rpi-worker | jq .

show-web: ## Show web output
	curl -s localhost | jq .

show-haproxy:  ## Show generated haproxy template
	tail -n 12 haproxy/haproxy.cfg

