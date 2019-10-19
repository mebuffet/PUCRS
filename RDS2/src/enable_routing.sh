#!/bin/bash

echo 1 > /proc/sys/net/ipv4/ip_forward

for i in `ls -1 /proc/sys/net/ipv4/conf/*/send_redirects`
do
	echo 0 > $i
done
