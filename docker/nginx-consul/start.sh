#!/bin/bash
service nginx start
consul-template -consul-addr="consul.chaordic-lab.internal:8500" -template="/etc/nginx/default.ctmpl:/etc/nginx/conf.d/default.conf:service nginx -s reload"
