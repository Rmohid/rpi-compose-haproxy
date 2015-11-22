# rpi-compose-haproxy
A sample web app on rasberry pi with HAproxy and docker-compose

Based on [hypriot's howto](http://blog.hypriot.com/post/docker-compose-nodejs-haproxy/)

Notes: 

## docker was installed on a rasbian based system with the following:

$ wget http://downloads.hypriot.com/docker-hypriot_1.8.2-1_armhf.deb
dpkg -i docker-hypriot_1.8.2-1_armhf.deb

## docker-compose was installed with the following command:

$ sudo sh -c "curl -L https://github.com/hypriot/compose/releases/download/1.2.0-raspbian/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose; chmod +x /usr/local/bin/docker-compose"
