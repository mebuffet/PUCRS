#!/bin/bash

rm report.parser
clear
g++ -Wall -Wextra main.cpp parser.cpp -o parser
time ./parser ../pif2wb.vcd >> report.parser
cat report.parser
