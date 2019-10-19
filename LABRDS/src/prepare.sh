#!/bin/bash

clear

if [ "$#" -ne 0 ]
then
	echo "usage: ./prepare.sh"
else
    echo 1 > /proc/sys/net/ipv4/ip_forward
    #for i in `ls -1 /proc/sys/net/ipv4/conf/*/send_redirects`
    #do
    #	echo 0 > $i
    #done
    #open tmux manually
    tmux split-window -v
    tmux send-keys -t 0 'cd arpspoof/ && make && ./arpspoof' Enter
    tmux send-keys -t 1 'cd sniffer/ && make && ./sniffer' Enter
	#echo 0 > /proc/sys/net/ipv4/ip_forward
fi
