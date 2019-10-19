#!/bin/bash

for i in ` seq 1 10`;
do
	echo $i
	snmpget -v 1 -c public localhost sysUpTime.0
	snmpget -v 1 -c public localhost ipInReceives.0
	snmpget -v 1 -c public localhost snmpOutPkts.0
	snmpget -v 1 -c public localhost ifInOctets.2
	snmpget -v 1 -c public localhost ifOutOctets.2
	snmpget -v 1 -c public localhost ifSpeed.2
	snmpget -v 1 -c public localhost ifInUcastPkts.2
	snmpget -v 1 -c public localhost ifInNUcastPkts.2
	sleep 30
done
