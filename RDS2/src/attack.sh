#!/bin/bash

clear

if [ "$#" -ne 0 ]
then
	echo "usage: ./attack.sh"
else
	#tmux new-session \; split-window -v \; select-pane -t 1
	./enable_routing.sh
	gcc main.c -Wall -Wextra -o main
	count=4
	while [ $count -ne 0 ]
	do
		printf "%d..." $count
		sleep 1
		((count--))
	done
	printf "%d!\nATTACKING!\n" $count
	./main
	#tmux select-pane -t 0
fi
