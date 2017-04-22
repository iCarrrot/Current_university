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
#include <byteswap.h>
#include <vector>

#define INF 4294967295
#define YES 1
#define  NO 0

using namespace std;

struct intAddr{
  char ip1;
  char ip2;
  char ip3;
  char ip4;
  char mask;
  int LEdistance;
  char br1;
  char br2;
  char br3;
  char br4;
};
struct routeRecord{
  char ip1;
  char ip2;
  char ip3;
  char ip4;
  char mask;
  int LEdistance;
  bool ifDirect;
  char via1;
  char via2;
  char via3;
  char via4;
};
struct sendPacket{
  char ip1;
  char ip2;
  char ip3;
  char ip4;
  char mask;
  int BEdistance;
};



int makeByteOfMask(int mask){

  int byteMask=0;
  while (mask>8){
    mask-=8;
  }
  for (int i = 0; i < mask; i++) {
    byteMask+=1<<(7-i);
  }
  return byteMask;
}
void brodadcast(int *b1,int *b2,int *b3,int *b4, int mask){
  switch ((mask+7)/8) {
    case 1:
      *b1+=255-makeByteOfMask(mask);
      mask=0;
    case 2:
      *b2+= 255- makeByteOfMask(mask);
      mask=0;
    case 3:
      *b3+= 255- makeByteOfMask(mask);
      mask=0;
    case 4:
      *b4+= 255- makeByteOfMask(mask);
  }
  //printf("broadcast: %d.%d.%d.%d\n", *b1,*b2,*b3,*b4 );

}
void andMask(int *b1,int *b2,int *b3,int *b4, int mask){
  switch ((mask+7)/8) {
    case 1:
      *b1=((char)*b1)& makeByteOfMask(mask);
      mask=0;
    case 2:
      *b2=(char)*b2& makeByteOfMask(mask);
      mask=0;
    case 3:
      *b3=(char)*b3& makeByteOfMask(mask);
      mask=0;
    case 4:
      *b4=(char)*b4& makeByteOfMask(mask);
  }

}
int sendMessage(routeRecord *routeTable, int * sockfd, sockaddr_in * server_address){
  char message[9];
  message[0]=routeTable->ip1;
  message[1]=routeTable->ip2;
  message[2]=routeTable->ip3;
  message[3]=routeTable->ip4;
  message[4]=routeTable->mask;
  message[5]=(char)((routeTable->LEdistance>>24 )&0xFF);
  message[6]=(char)((routeTable->LEdistance>>16 )&0xFF);
  message[7]=(char)((routeTable->LEdistance>>8 )&0xFF);
  message[8]=(char)((routeTable->LEdistance>>0 )&0xFF);
  //printf("%9d %20d\n", message, sipAddr );
  ssize_t message_len = sizeof(message);
  if (sendto(*sockfd, message, message_len, 0, (struct sockaddr*) server_address, sizeof(*server_address)) != message_len) {
    fprintf(stderr, "sendto error: %s\n", strerror(errno));
    return EXIT_FAILURE;
  }
  return 0;
}
int sendTable(int * dCNumber,vector<intAddr> * addrTable, vector<routeRecord> * routeTable){
  int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
	if (sockfd < 0) {
		fprintf(stderr, "socket error: %s\n", strerror(errno));
		return EXIT_FAILURE;
	}
  struct sockaddr_in server_address;
  bzero (&server_address, sizeof(server_address));
	server_address.sin_family      = AF_INET;
	server_address.sin_port        = htons(54321);
  int broadcastPermission = 1;
	setsockopt (sockfd, SOL_SOCKET, SO_BROADCAST,(void *)&broadcastPermission,sizeof(broadcastPermission));

  for (int i = 0; i < *dCNumber; i++) {
    string sipAddr=  to_string(0xFF&(unsigned int)(*addrTable)[i].br1)+"."
                  + to_string(0xFF&(unsigned int)(*addrTable)[i].br2)+"."
                  + to_string(0xFF&(unsigned int)(*addrTable)[i].br3)+"."
                  + to_string(0xFF&(unsigned int)(*addrTable)[i].br4);
    const char * cipAddr = sipAddr.c_str();
    inet_pton(AF_INET,cipAddr , &server_address.sin_addr);
    for (int j = 0; j < (int)(*addrTable).size(); j++) {
      sendMessage(&((*routeTable)[j]),&sockfd, &server_address);

    }
  }
  return 0;
}
void initTables(int * dCNumber, vector<intAddr>* addrTable, vector<routeRecord> *routeTable ){
  for (int i = 0; i < *dCNumber; i++) {
    int ip1, ip2, ip3, ip4, mask, LEdistance;
    int ifDirect=YES;
    int via1, via2, via3, via4;
    via1= via2= via3= via4=0;

    scanf("%d.%d.%d.%d/%d distance %d\n",&ip1,&ip2,&ip3,&ip4,& mask,& LEdistance);
    int br1, br2, br3, br4;
    br1=ip1;
    br2=ip2;
    br3=ip3;
    br4=ip4;

    //nałóż maskę na adres interfejsu
    andMask(&br1,&br2,&br3,&br4,mask);

    routeRecord temp1 =  {(char)br1, (char)br2, (char)br3, (char)br4, (char)mask, LEdistance, ifDirect, (char)via1, (char)via2, (char)via3, (char)via4};

    //utwórz adres rozgłoszeniowy
    brodadcast(&br1,&br2,&br3,&br4,mask);

    intAddr temp = {(char)ip1, (char)ip2, (char)ip3, (char)ip4, (char)mask, LEdistance, (char)br1, (char)br2, (char)br3, (char)br4};

    routeTable->push_back(temp1);
    addrTable->push_back(temp);
  }

}


int main(){

  int dCNumber=0; //directConnectionNumber - liczba bezpośrednio podłączonych sieci
  vector<intAddr> addrTable;
  vector<routeRecord> routeTable;
  scanf("%d\n", &dCNumber);

  initTables( & dCNumber, & addrTable,  &routeTable );

  sendTable(&dCNumber,&addrTable, &routeTable);


  //cout<<endl<<sizeof(intAddr)<<endl;

  return 0;
}

  //temp= bswap_32( temp);
