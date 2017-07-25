MAINTAINER FPereira DevOps "fpereira.rio@gmail.com"
LABEL Description="Nginx  consul template  register"


FROM nginx:latest

RUN apt-get update -y \

ENTRYPOINT ["/bin/start.sh"]
#EXPOSE 80
#VOLUME /templates
ENV CONSUL_URL localhost:8500
COPY limits.conf /etc/security/limits.conf
COPY tuninginx.conf /etc/sysctl.d/tuninginx.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY default.ctmpl /etc/nginx/default.ctmpl

ADD start.sh /bin/start.sh

COPY consul-template /usr/bin
RUN chmod +x /usr/bin/consul-template

