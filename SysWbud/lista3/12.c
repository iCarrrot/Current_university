#include <stdio.h>
#include <limits.h>
#include <time.h>  

void spaceFunction(char napis[], int size){
	for (int i=0;i<size;i++){
		if (napis[i]==' '){
			int j=i;
			while(i>0&&napis[j-1]!=' '){
				char temp=napis[j];
				napis[j] =napis[j-1];
				napis[j-1]=temp;
				j--;
			}
		}
	}

}

void spaceFunction2(char napis[], int size){
	int licznik=0;
	char temp[size];
	for (int i = 0; i < size; i++)
	{
		if(napis[i]==' '){
			licznik++;
		}
	}
	for (int i=0; i<licznik;i++){
		temp[i]=' ';
	}
	for (int i=0;i<size; i++){
		if (napis[i]!=' '){
			temp[licznik]=napis[i];
			licznik++;
		}
	}
	for (int i = 0; i < size; i++)
	{
		napis[i]=temp[i];
	}


}




int main(){
	
	char napis[71]={' ','a',' ',' ','a','b',' ','e','a',' ',' ','a','b',' ','e','a',' ',' ','a','b',' ','e','a',' ',' ','a','b',' ','e','a',' ',' ','a','b',' ','e','a',' ',' ','a','b',' ','e','a',' ',' ','a','b',' ','e','a',' ',' ','a','b',' ','e','a',' ',' ','a','b',' ','e','a',' ',' ','a','b',' ','e'};
	clock_t start = clock();
	spaceFunction(napis,71);
	clock_t end = clock();

	clock_t start2 = clock();
	spaceFunction2(napis,71);
	clock_t end2 = clock();
	
	printf("czas 1: %li, czas 2: %li\n", (long) (end-start),(long)(end2-start2));
	

	return 0;
}