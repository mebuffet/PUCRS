#!/bin/bash

clear

if [ "$#" -ne 1 ]
then
	echo "usage: ./server.sh SERVER_PORT"
else
	../../bin/simple-server $1
fi
