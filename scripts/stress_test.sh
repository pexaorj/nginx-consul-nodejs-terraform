#!/bin/bash

#On centos
#yum install httpd-tools

#On ubuntu/debian
#apt-get install apache2-utils


#Set server ip 

IP_SERVER=10.10.10.10

ab -n 10000 -c 100 http://$IP_SERVER:80/
