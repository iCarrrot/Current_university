//Michał Martusewicz 282023

#include "tools.h"

//sprawdzenie czy adres ip jest parsowalny
bool validateIpAddress(const string &ipAddress)
{
    struct sockaddr_in sa;
    int result = inet_pton(AF_INET, ipAddress.c_str(), &(sa.sin_addr));
    return result != 0;
}

//utworzenie z tablicy stringów linii z adresami. 
string makeIpLine(string ipString[])
{
	if(ipString[0]=="")
		return "*";
	else if(ipString[1]=="")
		return ipString[0];
	else if(ipString[2]=="")
		return ipString[0]+" "+ipString[1];
	else
		return ipString[0]+" "+ipString[1]+" "+ipString[2];
}

//wyciągnięcie id lub sequence z pakietu
int getValue(icmphdr *icmp_header , int flag)
{
	u_int8_t *point = (u_int8_t*)(icmp_header) +32;
	int value=0;
	switch (flag)
	{
		case 0:   //GET_ID
			if(icmp_header->type == 0)
			{
				return icmp_header->un.echo.id ;
			}
			else if(icmp_header->type==11&&icmp_header->code==0)
			{
				value=256* (int)*(point+1)+(int)*(point);
				return value;
			}
			else return -1;
			break;
		case 1:   //GET_SEQUENCE
			if(icmp_header->type == 0)
			{
				return icmp_header->un.echo.sequence;
			}
			else if(icmp_header->type==11&&icmp_header->code==0)
			{
				value=256* (int)*(point+3)+(int)*(point+2);
				return value;
			}
			else return -1;
			break;
		
	}
	return -2;
}

//dodanie adresu ip do tablicy stringów, przy czym adres jest wpisywany na pierwsze wolne miejsce, o ile nie jest już zawarty w tablicy.
void addIpAdress(string ipString[], string tempIp)
{
	if(ipString[0]=="")
		ipString[0]=tempIp;
	else if(ipString[0]!=tempIp)
	{
		if(ipString[1]=="")
			ipString[1]=tempIp;
		else if(ipString[1]!=tempIp)
			ipString[2]=tempIp;
	}
}