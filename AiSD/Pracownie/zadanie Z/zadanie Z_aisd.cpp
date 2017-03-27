#include <iostream>
int main(){
	int a,b;
	scanf("%d %d", a,b);
	if(a>b){
		int temp=a;
		a=b;
		b=temp;
	}
	for (int i = a; i <= b; i++)
	{
		printf("%s\n", i);
	}
	
	return 0;
}