main : Makefile router.cpp
	g++ -std=gnu++11 -Wall -W  -static -DSPRAWDZACZKA router.cpp -o sharedVM/router/router

.PHONY: run

run:
	./sharedVM/router/router < test
