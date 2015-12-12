# rpi-compose-haproxy
A sample web app on rasberry pi with HAproxy and docker-compose

Based on [hypriot's howto](http://blog.hypriot.com/post/docker-compose-nodejs-haproxy/)

Notes: 

## docker was installed on a rasbian based system with the following:

	$ wget http://downloads.hypriot.com/docker-hypriot_1.8.2-1_armhf.deb
	dpkg -i docker-hypriot_1.8.2-1_armhf.deb

## docker-compose was installed with the following command:

	$ sudo sh -c "curl -L https://github.com/hypriot/compose/releases/download/1.2.0-raspbian/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose; chmod +x /usr/local/bin/docker-compose"

### TODO
- [x] Use consul for service discovery
- [x] Use registrator for service registration
- [x] Use consul-template to update haproxy.cfg
- [ ] Get haproxy to reload cfg file change
- [ ] Test service increase/decrease in circleCi
- [ ] Add redis service
- [ ] Add redis replication
- [ ] Migrate into docker swarm


#### References:
* https://hub.docker.com/u/hypriot/
* https://developer.epages.com/blog/2015/09/28/service-discovery.html
* http://sirile.github.io/2015/05/18/using-haproxy-and-consul-for-dynamic-service-discovery-on-docker.html
* https://github.com/foostan/consul-with-docker 
* https://github.com/hashicorp/consul-template
