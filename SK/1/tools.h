#ifndef TOOLS_H
#define TOOLS_H 1

#include <netinet/ip.h>
#include <netinet/ip_icmp.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <iostream>
#include <assert.h>
#include <sys/socket.h>
#include <string>
#include <sys/types.h>
#include <unistd.h>
#include <time.h>
#include <cmath>
#include <string.h>
#include <sstream>
using namespace std;

#define GET_ID 0
#define GET_SEQUENCE 1
#define MICRO_IN_SECOND 1000000 //how many micro seconds are in socond



bool validateIpAddress(const string &ipAddress);

string makeIpLine(string ipString[]);

int getValue(icmphdr *icmp_header , int flag);

void addIpAdress(string ipString[], string tempIp);

#endif