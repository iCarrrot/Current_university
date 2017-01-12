#include <stdio.h>
#include <limits.h>
#include <time.h>

int licz(unsigned int tablica[], int size ){
	int count=0;
	for (int i = 0; i < size; i++)
	{
		unsigned int x= ~(tablica[i]);
		if((x!=0 )&&( (x&(x-1))!=0)){
			count++;
		}
	}
	return  count;
}





int licz2(unsigned int tablica[], int size ){
	int count=0;
	for (int i = 0; i < size; i++)
	{
		unsigned int x= ~(tablica[i]);


		int temp=0;
		for (int j=0; j<32; j++){	
			temp+=((x>>j)&1);
		}
		if(temp>=2){
			count++;
		}
	}
	return  count;
}






int main(){
	srand(time(NULL));
	int size=200000;
	unsigned int tablica[size];
	for(int i=0;i<size;i++){

		tablica[i]= rand();
		//printf("%u\n", tablica[i]);

	}
	clock_t start1 = clock();
	int ile=licz(tablica,size);
	clock_t end1 = clock();

	clock_t start2 = clock();
	int ile2=licz2(tablica,size);
	clock_t end2 = clock();
	printf("czas 1: %li, czas 2: %li\n", (long) (end1-start1),(long)(end2-start2));
	
	return 0;
}