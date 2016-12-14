#include <stdio.h>
#include <limits.h>
#include <stdio.h> 
#include <time.h>

int licz(unsigned int tablica[], int size ){
	int count=0;
	for (int i = 0; i < size; i++)
	{
		unsigned int x= ~(tablica[i]);
		if((x!=0 )&&( (x&(x-1))!=0)){
			count++;
			//printf("%u\n", x);
			//printf("%u  %u  %u %u   %u\n", x,x!=0,x&(x-1), (x&(x-1)) !=0, x!=0 && x&(x-1)!=0);
		}
		else{
			//printf("%u  %u  %u %u   %u\n", x,x!=0,x&(x-1), (x&(x-1)) !=0, x!=0 && x&(x-1)!=0);
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
			
			temp+=((x>>j)&0x00000001);
			//printf("%u  %u\n", temp,((x>>j)&0x00000001));

		}
		if(temp>=2){
			count++;
			//printf("%u\n",~tablica[i] );
		}
	}
	//printf("%u\n", count);
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
	int ile=licz(tablica,size);
	int ile2=licz2(tablica,size);

	while(ile-ile2==0&&ile-size==0){
		for(int i=0;i<size;i++){
			tablica[i]= rand();
		}
		ile=licz(tablica,size);
		ile2=licz2(tablica,size);

		
	}
	printf("%u %u %u\n", ile, ile2,size);
	return 0;
}