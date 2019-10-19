#!/bin/bash

clear

if [ "$#" -ne 1 ]
then
	echo "usage: ./client.sh SERVER_PORT"
else
	../bin/simple-client 10.0.1.10 $1
fi
