#!/bin/bash

# g++ a.cpp -o a -O2 -std=gnu++11 -Wall -W -static -DSPRAWDZACZKA
for i in {1..48}
do
	echo $i
	./zad < in/${i}.in > out/${i}.out
done
