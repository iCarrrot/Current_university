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
#include <time.h>

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
int sendTable(int * dCNumber,vector<intAddr> * addrTable, vector<routeRecord> * routeTable, sockaddr_in * server_address, int * sockfd){


  for (int i = 0; i < *dCNumber; i++) {
    string sipAddr=  to_string(0xFF&(unsigned int)(*addrTable)[i].br1)+"."
                  + to_string(0xFF&(unsigned int)(*addrTable)[i].br2)+"."
                  + to_string(0xFF&(unsigned int)(*addrTable)[i].br3)+"."
                  + to_string(0xFF&(unsigned int)(*addrTable)[i].br4);
    const char * cipAddr = sipAddr.c_str();
    inet_pton(AF_INET,cipAddr , &server_address->sin_addr);
    for (int j = 0; j < (int)(*addrTable).size(); j++) {
      sendMessage(&((*routeTable)[j]),sockfd, server_address);

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
bool checkSender(vector<intAddr> * addrTable, char via1,char via2,char via3,char via4){
  for (size_t i = 0; i < addrTable->size(); i++) {
    char ip1=(*addrTable)[i].ip1;
    char ip2=(*addrTable)[i].ip2;
    char ip3=(*addrTable)[i].ip3;
    char ip4=(*addrTable)[i].ip4;
    if(via1==ip1  &&  via2==ip2  &&  via3==ip3  &&  via4==ip4){
      //printf("addrIp: %d.%d.%d.%d  via: %d.%d.%d.%d/n", ip1,ip2,ip3,ip4,via1,via2,via3,via4);
      return 1;
    }
  }
  return 0;
}


int receive(int *sockfd, routeRecord * newRecord, vector<intAddr> * addrTable){


  struct sockaddr_in 	sender;
  socklen_t 			sender_len = sizeof(sender);
  u_int8_t 			buffer[IP_MAXPACKET+1];

  ssize_t datagram_len = recvfrom (*sockfd, buffer, IP_MAXPACKET, 0, (struct sockaddr*)&sender, &sender_len);
  if (datagram_len < 0) {
    fprintf(stderr, "recvfrom error: %s\n", strerror(errno));
    return EXIT_FAILURE;
  }
  char via1=((sender.sin_addr.s_addr)) & 0xFF;
  char via2=((sender.sin_addr.s_addr)>>8) & 0xFF;
  char via3=((sender.sin_addr.s_addr)>>16) & 0xFF;
  char via4=((sender.sin_addr.s_addr)>>24) & 0xFF;
  if(checkSender(addrTable, via1,via2,via3,via4)){
    //printf("aaa\n");
    return 0;
  }

  buffer[datagram_len] = 0;
  char * b1=(char*)&(buffer[5]);
  int distance=bswap_32(*((int*)b1));
  struct routeRecord recivedRecord = {(char)buffer[0], (char)buffer[1], (char)buffer[2], (char)buffer[3], (char)buffer[4], distance, NO, via1 , via2 , via3 , via4};
  *newRecord=recivedRecord;
  printf ("%ld-byte message: +%d.%d.%d.%d/%d distance %d, via? %d  %d.%d.%d.%d+\n", datagram_len, (unsigned char)recivedRecord.ip1,
    (unsigned char)recivedRecord.ip2,(unsigned char)recivedRecord.ip3,(unsigned char)recivedRecord.ip4,
      (unsigned char)recivedRecord.mask,
      recivedRecord.LEdistance, recivedRecord.ifDirect, (unsigned char)recivedRecord.via1, (unsigned char)recivedRecord.via2
      , (unsigned char)recivedRecord.via3, (unsigned char)recivedRecord.via4);
  return 0;
}
bool checkIfSameWeb(routeRecord* r1,routeRecord* r2){
  if(r1->ip1==r2->ip1  &&  r1->ip2==r2->ip2  &&  r1->ip3==r2->ip3  &&  r1->ip4==r2->ip4 ){
    return 1;
  }
  return 0;
}


int updateTable(vector<routeRecord> *routeTable, routeRecord * newRecord){
  for (size_t i = 0; i < routeTable->size(); i++) {
    if(checkIfSameWeb(&(*routeTable)[i], newRecord) ){
      if ((*routeTable)[i].LEdistance>newRecord->LEdistance) {
        (*routeTable)[i]=*newRecord;

      }

    }
    return 0;
  }



  return 0;
}


int main(){

  int dCNumber=0; //directConnectionNumber - liczba bezpośrednio podłączonych sieci
  vector<intAddr> addrTable;
  vector<routeRecord> routeTable;
  scanf("%d\n", &dCNumber);

  initTables( & dCNumber, & addrTable,  &routeTable );

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

  if (bind (sockfd, (struct sockaddr*)&server_address, sizeof(server_address)) < 0) {
		fprintf(stderr, "bind error: %s\n", strerror(errno));
		return EXIT_FAILURE;
	}


  routeRecord newRecord;
  time_t start = time(0);
  cout<<start<<"aaa"<<endl;
  while(1){

    receive (&sockfd, &newRecord, &addrTable);

    if(difftime( time(0), start)>17+start%10){
        sendTable(&dCNumber,&addrTable, &routeTable, &server_address, &sockfd);
        start = time(0);
    }

  }





  //cout<<endl<<sizeof(intAddr)<<endl;

  return 0;
}

  //temp= bswap_32( temp);
