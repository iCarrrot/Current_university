//Michał Martusewicz 282023

#include "send.h"
#include "tools.h"



static u_int16_t computeIcmpChecksum (const u_int16_t* buff, int length);

//funkcja licząca sumę kontrolną by Marcin Bieńkowski UWR *** Copyright by Marcin Bieńkowski UWR
u_int16_t computeIcmpChecksum (const u_int16_t* buff, int length)
{
	u_int32_t sum;
	const u_int16_t* ptr = buff;
	assert (length % 2 == 0);
	for (sum = 0; length > 0; length -= 2)
		sum += *ptr++;
	sum = (sum >> 16) + (sum & 0xffff);
	return (u_int16_t)(~(sum + (sum >> 16)));
}


void sendPacket (int *sockfd, int ttl, int id, const char* ip)
{
	//inicjacja struktury nagłówkowej
	struct icmphdr icmp_header;
		icmp_header.type = ICMP_ECHO;
		icmp_header.code = 0;
		icmp_header.un.echo.id = id;
		icmp_header.un.echo.sequence = ttl+443;//*3;
		icmp_header.checksum = 0;
		icmp_header.checksum = computeIcmpChecksum ((u_int16_t*)&icmp_header, sizeof(icmp_header));

	struct sockaddr_in recipient;

	bzero (&recipient, sizeof(recipient));
		recipient.sin_family = AF_INET;

	inet_pton(AF_INET, ip, &recipient.sin_addr);
	//dodanie ttl do pakietu
	setsockopt (*sockfd, IPPROTO_IP, IP_TTL, &ttl, sizeof(int));

	ssize_t bytes_sent; 

	//wysłanie trzech pakietów
	for (int i = 0; i < 3; ++i)
	{
		bytes_sent = sendto (*sockfd, &icmp_header, sizeof(icmp_header), 0, (struct sockaddr*)&recipient, sizeof(recipient));
		
		if(bytes_sent<=0)
		{
			fprintf(stderr, "sending error: %s\n", strerror(errno)); 
		}
	}

}