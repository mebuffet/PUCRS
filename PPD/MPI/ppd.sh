#!/bin/bash

clear

if [ "$#" -ne 4 ]; then
        echo "./ppd.sh BINARY NUMBER_TO_SORT FILE_WITH_INTEGERS PATH_TO_RESULTS"

else
        binary=$1
        source="$binary.c"
        sort=$2
        file_integers=$3
        path="$4"

        rm -rf $binary $path

        ladcomp -env mpiCC $source -o $binary -lm -Wall -Wextra

        if [ ! -d $path ]; then
                mkdir $path
        fi

        for i in 1 2 4 8 16; do
                for j in 1 2 4; do
                        size=$(($sort*j))
                        echo $i $size
                        ladrun -np $i $binary $size $file_integers > ./$path/$binary.$size.$i.txt
                done
        done
        tail -n1 ./$path/*
fi