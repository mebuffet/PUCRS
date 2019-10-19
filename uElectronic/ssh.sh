#!/bin/bash

#script to SSH (PUCRS's server) from linux

#sudo apt install sshpass -y

#change X to validate the login

clear

if [ "$#" -ne 2 ]
then
	echo "./ssh.sh user server"
else
	user=$1
	server=$2
	load="source /soft64/source_gaph;module load modelsim;bash -l"
	echo "[$user]->[$server]"
	if [ $user = "micro" ]
	then
		user="microX"
		export SSHPASS="X"
		if [ $server = "naxos" ]
		then
			sshpass -e ssh -X $user@$server.inf.pucrs.br -t $load
                elif [ $server = "kriti" ]
                then
                        sshpass -e ssh -X $user@$server.inf.pucrs.br -p 8888 -t $load
		fi
        elif [ $user = "vlsi" ]
	then
		user="vlsi1_g0X"
		export SSHPASS="X"
		if [ $server = "naxos" ]
		then
			sshpass -e ssh -X $user@$server.inf.pucrs.br -t $load
        	elif [ $server = "kriti" ]
		then
			sshpass -e ssh -X $user@$server.inf.pucrs.br -p 8888 -t $load
		fi
	fi
fi
