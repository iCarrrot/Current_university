//Michał Martusewicz
//282023
//KLO

#include <iostream>
#include  <stdio.h>
int main(){
	int a,b;
	scanf("%i %i", &a,&b);
	if(a%2==0){
		a+=1;
	}
	for (int i = a; i <= b; i+=2)
	{
		printf("%i ", i);
	}
	
	return 0;
}