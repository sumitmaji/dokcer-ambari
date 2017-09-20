#!/bin/bash

ip_addr=`/sbin/ifconfig eth1 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}'`
echo 'host ip address: '$ip_addr
docker build --build-arg REPOSITORY_HOST=http://192.168.1.108:9098 -t sumit/ambari:latest .

