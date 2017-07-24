#!/bin/bash

#Sleep 120 - a instancia pode levantar sem ter um ip real, nao deixando com que ela execute o user-data - workaround


#Update system - instala docker
apt-get update -y 
apt-get install docker docker-compose -y 
apt-get install unzip -y 

#Inicia o docker
/etc/init.d/docker start

update-rc.d docker enable 2

#Faz o pull das imagens que serao utilizadas
docker pull fernandopereira/nginx-consul-template
docker pull progrium/consul
docker pull gliderlabs/registrator


#Rodando o container do Consul para controlar os nodes e interagir com o Nginx
docker run -dit --restart unless-stopped -p 8400:8400 -p 8500:8500 -p 53:53/udp -p 8600:53/udp -h consul --name consul progrium/consul -server -advertise=`/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}'` -bootstrap=1

#Rodando o container do register para monitorar
docker run -dit --restart unless-stopped --name=registrator --volume=/var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest consul://`/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}'`:8500

#Rodando o container o Nginx com LB + consul template
docker run -dit --link consul -p 80:80 --restart unless-stopped fernandopereira/docker-nginx-consul 
