CC = g++
FLAGS = -Wall -W -Wextra -std=gnu++11 -std=c++11
 
traceroute: receive.o send.o tools.o traceroute.cpp
	$(CC) $(FLAGS) -o traceroute receive.o send.o tools.o traceroute.cpp

tools: tools.h tools.cpp
	$(CC) $(FLAGS) -c -o tools.o tools.cpp

receive: receive.cpp receive.h tools.o tools.h
	$(CC) $(FLAGS) -c -o receive.o receive.cpp tools.o 

send: send.cpp send.h tools.o
	$(CC) $(FLAGS) -c -o send.o send.cpp tools.o

clean:
	rm -f *.o
	
distclean:
	rm -f traceroute 
	