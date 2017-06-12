#!/bin/bash

#g++ C.cpp -o C -O2 -std=gnu++11 -Wall -W -static -DSPRAWDZACZKA
for i in {1..39}
do
	echo $i
	./zad < testy/${i}.in > a_out
	X=$(diff -b -B testy/${i}.out a_out)
	if [ "$X" != "" ]
	then
		echo "FAIL"
		#break
	fi
done
#shutdown -h now
