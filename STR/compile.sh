#!/bin/bash

clear

if [ "$#" -ne 4 ]; then
        echo "./compile.sh SOURCE INPUT OUTPUT ANSWER"

else
        source=$1
        binary=${source%.*}
        input=$2
        output=$3
	answer=$4

	echo $source $binary $input $output

	rm $binary $output

	gcc -o $binary $source -Wall -Wextra

	./$binary < $input > $output

	cat $output

	echo DIFF BETWEEN $answer $output

	diff $answer $output
fi
