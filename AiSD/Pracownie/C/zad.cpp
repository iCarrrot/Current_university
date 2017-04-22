#include <stdio.h>
#include <bitset>
#include <stdint.h>
#include <ctime>
#include <vector>
using namespace std;



int main()
{
int lSlow=0;
scanf("%d\n", &lSlow);
//printf("powtorzyć %d razy\n", lSlow);
for (int ii = 0; ii < lSlow; ii++)
{
	//printf("ii: %d\n",ii);
	int term=0;
	int nTerm=0;
	scanf("%d %d\n", &nTerm, &term);
	//printf("liczby: %d %d\n",nTerm,term);
	char nTermTab[8][8];
	char termTab[26];
	for(int i=0; i<nTerm;i++){
		char nT, p1, p2;
		scanf("%c %c %c\n", &nT,&p1,&p2);
		nTermTab[p1-65][p2-65]=nT-65;
		//printf("%c produkuje %c i %c\n", nT, p1, p2);

	}

	for(int i=0; i<term;i++){
		char t, p1;
		scanf("%c %c\n", &t,&p1);
		termTab[p1-97]=t-65;
		//printf("%c produkuje %c\n", t, p1);
	}
	char slowo[1000];
	scanf("%s\n", slowo);
	//printf("słowo to: %s\n", slowo);



}




	return 0;
}
