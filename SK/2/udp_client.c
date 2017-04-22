#include <netinet/ip.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

int main()
{
	int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
	if (sockfd < 0) {
		fprintf(stderr, "socket error: %s\n", strerror(errno));
		return EXIT_FAILURE;
	}

	struct sockaddr_in server_address;
	bzero (&server_address, sizeof(server_address));
	server_address.sin_family      = AF_INET;
	server_address.sin_port        = htons(12345);
	inet_pton(AF_INET, "192.168.2.255", &server_address.sin_addr);
	int broadcastPermission = 1;
	setsockopt (sockfd, SOL_SOCKET, SO_BROADCAST,(void *)&broadcastPermission,sizeof(broadcastPermission));


	char a='a';
	char b = 'b';
	char message[9];
	message[0]=a;
	message[1]=b;
	message[2]=a;
	message[3]=b;
	message[4]=a;
	message[5]=b;
	message[6]=a;
	message[7]=b;
	message[8]=a;
	ssize_t message_len = sizeof(message);
	printf("%lu\n", message_len);
	if (sendto(sockfd, message, message_len, 0, (struct sockaddr*) &server_address, sizeof(server_address)) != message_len) {
		fprintf(stderr, "sendto error: %s\n", strerror(errno));
		return EXIT_FAILURE;
	}


	close (sockfd);
	return EXIT_SUCCESS;
}
