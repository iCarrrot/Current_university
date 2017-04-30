#include <stdio.h>
#include <bitset>
#include <stdint.h>
#include <ctime>
#include <vector>
#include <string.h>
using namespace std;



int main()
{
int lSlow=0;
scanf("%d\n", &lSlow);
//printf("powtorzyÄ %d razy\n", lSlow);
for (int ii = 0; ii < lSlow; ii++)
{
	//printf("ii: %d\n",ii);
	int term=0;
	int nTerm=0;
	scanf("%d %d\n", &nTerm, &term);
	//printf("liczby: %d %d\n",nTerm,term);

	bool nTermTab[8][8][8];
	bool termTab[26][8];
	for (size_t i = 0; i < 8; i++) {
		for (size_t j = 0; j < 8; j++) {
			for (size_t k = 0; k < 8; k++) {
				nTermTab[i][j][k]=0;
			}

		}
	}
	for (size_t i = 0; i < 26; i++) {
		for (size_t j = 0; j < 8; j++) {
			termTab[i][j]=0;
		}
	}

	for(int i=0; i<nTerm;i++){
		char nT, p1, p2;
		scanf("%c %c %c\n", &nT,&p1,&p2);
		nTermTab[p1-65][p2-65][nT-65]=1;
		//printf("%c produkuje %c i %c\n", nT, p1, p2);

	}

	for(int i=0; i<term;i++){
		char t, p1;
		scanf("%c %c\n", &t,&p1);
		termTab[p1-97][t-65]=1;
		//printf("%c produkuje %c\n", t, p1);
	}
	char slowo[1001];
	scanf("%s\n", slowo);
	int dl_slowa=0;
	for (size_t i = 0; i < 1001; i++) {
		if(slowo[i]==0){
			dl_slowa=i;
			break;
		}
	}
	const int wordSize=dl_slowa;
	//printf("rozmiar sÅowaa to: %d, litera numer 2: %c / %d scanf: %d \n", wordSize, slowo[1],slowo[1]);

	bool table[wordSize][wordSize][8];

	for (int i = 0; i < wordSize; i++) {
		for (int j = 0; j < wordSize-i; j++) {
			for (int k = 0; k < 8; k++) {
				table[i][j][k]=0;
			}
		}
	}


	for (int j = 0; j < wordSize; j++) {
		for (int k = 0; k < 8; k++) {
			table[0][j][k]=termTab[slowo[j]-97][k];
			//table[0][j][k]? printf("%c \n", k+65):0;
		}
	}
//printf("%d %d %d %d\n",table[0][3][0],table[0][3][1],table[0][3][0],table[0][3][0] );
	for (int i = 1; i < wordSize; i++) {
		for (int j = 0; j < wordSize-i; j++) {
			for (int k = 0; k < i; k++) {
				for (int t1 = 0; t1 < 8; t1++) {
					for (int t2 = 0; t2 < 8; t2++) {
						for (size_t t3 = 0; t3 < 8; t3++) {
							if(table[k][j][t1] == 1 && table[i-k-1][j+k+1][t2]==1 &&  nTermTab[t1][t2][t3]==1){
								table[i][j][t3]=1;
							//printf("%d %d: %c %c\n",i, j, t1+65,t2+65);
							}
						}
					}
				}
			}
		}
	}

/*
	for (int i = 0; i < wordSize; i++) {

		for (int j = 0; j < wordSize; j++) {
			printf("%d: ",j );
			for (int k = 0; k < 8; k++) {
				table[i][j][k]? printf("%c", k+65):0;
			}
			printf(" ");
		}
		printf("\n");
	}
*/
	table[wordSize-1][0][0]? printf("TAK\n") : printf("NIE\n");

}
/*
bool tab[8];
char *xyz;
*xyz=10;
tab=memcpy( xyz, (void*)tab, sizeof(char));
*/


	return 0;
}
