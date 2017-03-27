//Michał Martusewicz 282023

#include "tools.h"
#include "receive.h"
#include "send.h"



int main(int argc, char const *argv[])
{	
	if(argc!=2){
		return EXIT_FAILURE;
	}

	//walidacja adresu ip
	string ipAdress=argv[1];
	if(!validateIpAddress(ipAdress)){
		fprintf(stderr, "wrong ip adress!\n"); 
		return EXIT_FAILURE;
	}

	//utworzenie gniazda surowego
	int sockfd = socket(AF_INET, SOCK_RAW, IPPROTO_ICMP);
	if (sockfd < 0) {
		fprintf(stderr, "socket error: %s\n", strerror(errno)); 
		return EXIT_FAILURE;
	}
	u_int16_t id = getpid();

	for (int i = 1; i < 31; i++)
	{	
		string time="";

		printf("%d ",i);

		sendPacket(&sockfd,i,id,argv[1]);

		string line=receivePacket(&sockfd,id,i,&time);


		line=="*" ? cout<<line<<endl : cout<<line<<" "<<time<<endl;
		
		if(line==ipAdress){
			break;
		}
	}


	return 0;
}