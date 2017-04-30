#include <stdio.h>
#include <bitset>
#include <stdint.h>
#include <ctime>
#include <vector>
#include <string.h>
using namespace std;

unsigned char preCalc[256][256];


int main()
{
int lSlow=0;
scanf("%d\n", &lSlow);

for (int ii = 0; ii < lSlow; ii++)
{
	int term=0;
	int nTerm=0;
	scanf("%d %d\n", &nTerm, &term);
	unsigned char nTermTab[8][8];
	unsigned char termTab[26];
	for (size_t i = 0; i < 8; i++) {
		for (size_t j = 0; j < 8; j++) {
			nTermTab[i][j]=0;
		}
	}
	for (size_t i = 0; i < 26; i++) {
			termTab[i]=0;
	}

	for(int i=0; i<nTerm;i++){
		char nT, p1, p2;
		scanf("%c %c %c\n", &nT,&p1,&p2);
		nTermTab[p1-65][p2-65]|=1<<(nT-65);
	}

	for(int i=0; i<term;i++){
		char t, p1;
		scanf("%c %c\n", &t,&p1);
		termTab[p1-97]|=1<<(t-65);
	}

	for (int i = 0; i < 256; i++) {
		for (int j = 0; j < 256; j++) {
			preCalc[i][j]=0;
			for (int t1 = 0; t1 < 8; t1++) {
				for (int t2 = 0; t2 < 8; t2++) {
					preCalc[i][j]|=(1&(i>>t1)&(j>>t2)) * nTermTab[t1][t2];
				}
			}
		}
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
	unsigned char table[wordSize][wordSize];
	for (int i = 0; i < wordSize; i++) {
		for (int j = 0; j < wordSize-i; j++) {
				table[i][j]=0;
		}
	}
	for (int j = 0; j < wordSize; j++) {
			table[0][j]=termTab[slowo[j]-97];
	}
	for (int i = 1; i < wordSize; i++) {
		for (int j = 0; j < wordSize-i; j++) {
			for (int k = 0; k < i; k++) {
				table[i][j]|=preCalc [ table [k] [j] ]  [ table [i-k-1] [j+k+1] ];
			}
		}
	}
	table[wordSize-1][0]&1? printf("TAK\n") : printf("NIE\n");

}

	return 0;
}
