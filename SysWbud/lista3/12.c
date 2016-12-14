#include <stdio.h>
#include <limits.h>
#include <stdio.h>  

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
	char napis[8]={' ','a',' ',' ','a','b',' ','e'};
	spaceFunction2(napis,8);
	for (int i=0;i<8;i++){
		printf("%c", napis[i]);
	}

	return 0;
}