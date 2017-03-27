//Michał Martusewicz 282023

#include "tools.h"
#include "receive.h"



string receivePacket(int *sockfd,int id, int ttl, string* time)
{
	struct sockaddr_in 	sender;	
	socklen_t sender_len = sizeof(sender);
	u_int8_t buffer[IP_MAXPACKET];

	fd_set descriptors;
	FD_ZERO (&descriptors);
	FD_SET (*sockfd, &descriptors);


	struct timeval tv; 
		tv.tv_sec = 1; 
		tv.tv_usec = 0;
	int itime=0;

	int ready=2; 
	ssize_t packet_len = 0;
	int packetAmount=0;

	//tablica stringów, będą w niej trzymane adresy ip
	string ipString[3];
		ipString[0]="";
		ipString[1]="";
		ipString[2]="";
	
	while(ready>0&&packetAmount<3)
	{	
		//odczekanie na pierwszy pakiet
		ready = select (*sockfd+1, &descriptors, NULL, NULL, &tv);
		if (ready<0)
		{
			fprintf(stderr, "select error: %s\n", strerror(errno)); 
			return "EXIT_FAILURE";

		}
		if(ready==1)
		{
			//odbiór pakietu
			packet_len = recvfrom (*sockfd, buffer,  MSG_DONTWAIT, 0, (struct sockaddr*)&sender, &sender_len);
			
			if (packet_len < 0) 
			{
				fprintf(stderr, "recvfrom error: %s\n", strerror(errno)); 
				return "EXIT_FAILURE";
			}

			if(packet_len>0)
			{	
				struct iphdr* ip_header = (struct iphdr*) buffer;
				u_int8_t* icmp_packet = buffer + 4 * ip_header->ihl;
				struct icmphdr* icmp_header = (struct icmphdr*) icmp_packet;

				//sprawdzenie czy odebrany pakiet jest tym właściwym
				if(getValue(icmp_header, GET_ID)==id && getValue(icmp_header, GET_SEQUENCE) ==ttl+443)
				{
					itime+=MICRO_IN_SECOND-tv.tv_usec;
					packetAmount++;
					char sender_ip_str[20]; 
					inet_ntop(AF_INET, &(sender.sin_addr), sender_ip_str, sizeof(sender_ip_str));
					string temp=sender_ip_str;
					addIpAdress(ipString,temp);
				}
			}
		}
	}
	//konwersja floata na stringa
	float ftime=itime;
	ostringstream ss;
	ss << (ftime/3/1000);
	string stime(ss.str());
	//stime.erase(stime.end()-3,stime.end());

	//utworzenie stringa z ip i czasem
	packetAmount==3 ? *time=stime +" ms" : *time="???";
	string ipLine=makeIpLine(ipString);


	return ipLine;
}