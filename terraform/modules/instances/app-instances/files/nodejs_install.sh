#!/bin/bash

#Sleep 120 - a instancia pode levantar sem ter um ip real, nao deixando com que ela execute o user-data - workaround
#Aguarda a instancia de NAT levantar e a de consul para se registrar
sleep 120
#Update system - instala docker
apt-get update -y && 
apt-get install docker docker-compose -y && 


#Inicia o docker
/etc/init.d/docker start
update-rc.d docker enable 2

#Faz o pull da imagem docker do meu repositorio privado
docker pull fernandopereira/nodejs

#Faz o start do container do Docker com o servico de teste - calcula o numero de cpus para subir os containers nodejs
#ncpu=`nproc`
hostname=`hostname`
#for ncpu in $(seq 1 $ncpu);
#do
#  echo "Container up"
#  docker run -dit --restart unless-stopped -h $hostname --name $hostname -p 300$ncpu:300$ncpu -ti fernandopereira/nodejs
#done

docker run -dit --restart unless-stopped -h $hostname --name $hostname -p 3000:3000 -ti fernandopereira/nodejs

#Docker Registry
docker run -dit --restart unless-stopped --name=registrator --volume=/var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest -ip `/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}'` consul://nginx.chaordic-lab.internal:8500
