#!/bin/bash

#g++ C.cpp -o C -O2 -std=gnu++11 -Wall -W -static -DSPRAWDZACZKA
for i in {1..39}
do
	echo $i
	./zad < testy/${i}.in
done
#shutdown -h now
