#include <stdio.h>
#include <iostream>
#include <string>
using namespace std;
#define M 10
#define N 10

void mark(int i,int j, char pola[N][M], int miasta[N][M], int id, int n, int m){
	
		char up;
		char right;
		char left;
		char down;
		i+1<n? up= pola[i+1][j]:up=0;
		j+1<m? right=pola[i][j+1]:right=0;
		j-1>=0? left=pola[i][j-1]:left=0;
		i-1>=0? down=pola[i-1][j]:down=0;
	

	switch (pola[i][j])
	{
		case 'A':
			miasta[i][j]=0;
			break;

		case 'F':
			miasta[i][j]=id;
			
			if(miasta[i+1][j]<0 && (up=='D'||up=='C'||up=='F')){
				mark( i+1, j, pola, miasta, id,n,m);
			}
			if(miasta[i][j+1]<0 && (right=='B'||right=='C'||right=='F')){
				mark( i, j+1, pola, miasta, id,n,m);
			}
			if(miasta[i-1][j]<0 && (down=='B'||down=='E'||down=='F')){
				mark( i-1, j, pola, miasta, id,n,m);
			}
			if(miasta[i][j-1]<0 && (left=='D'||left=='E'||left=='F')){
				mark( i, j-1, pola, miasta, id,n,m);
			}
			break;


		case 'B':
			miasta[i][j]=id;

			if(miasta[i+1][j]<0 && (up=='D'||up=='C'||up=='F')){
				mark( i+1, j, pola, miasta, id,n,m);
			}
			
			if(miasta[i][j-1]<0 && (left=='D'||left=='E'||left=='F')){
				mark( i, j-1, pola, miasta, id,n,m);
			}
			break;

		case 'C':
			miasta[i][j]=id;

			if(miasta[i-1][j]<0 && (down=='B'||down=='E'||down=='F')){
				mark( i-1, j, pola, miasta, id,n,m);
			}
			if(miasta[i][j-1]<0 && (left=='D'||left=='E'||left=='F')){
				mark( i, j-1, pola, miasta, id,n,m);
			}
			break;
		case 'D':
			miasta[i][j]=id;
			
			if(miasta[i][j+1]<0 && (right=='B'||right=='C'||right=='F')){
				mark( i, j+1, pola, miasta, id,n,m);
			}
			if(miasta[i-1][j]<0 && (down=='B'||down=='E'||down=='F')){
				mark( i-1, j, pola, miasta, id,n,m);
			}
			break;

		case 'E':
			miasta[i][j]=id;

			char up = pola[i+1][j];
			char right = pola[i][j+1];
			char left = pola[i][j-1];
			char down = pola[i-1][j];

			if(miasta[i+1][j]<0 && (up=='D'||up=='C'||up=='F')){
				mark( i+1, j, pola, miasta, id,n,m);
			}
			if(miasta[i][j+1]<0 && (right=='B'||right=='C'||right=='F')){
				mark( i, j+1, pola, miasta, id,n,m);
			}
			break;
	}
}



int poszukiwacz(char pola[N][M], int miasta[N][M],int n,int m ){
	int id=1;
	for (int i = 0; i < n; i++)
	{

		for (int j = 0; j < m; j++)
		{
			if (pola[i][j]!='A')
			{
				if(miasta[i][j]<0)
				{
					mark(i,j,pola,miasta,id,n,m);
					id++;
				}
			}
			else{
				miasta[i][j]=0;
			}
			
		}

	
	}
	return --id;
}

int main(){
	int n,m;
	scanf("%d %d\n" ,&n,&m);
	//printf("%d %d\n",N,M );
	char pola[N][M];
	int miasta[N][M];
	
	
	for (int i = 0; i < n; i++)
	{
		fgets(pola[i], m+1, stdin);
		scanf("\n");
		//printf("tab1: ");
		for (int j = 0; j < m; j++)
		{
			//printf("%c ",pola[i][j]);
			miasta[i][j]=-1;
			//n+=miasta[i][j];
			
		}
		//printf("end \n");
	
	}
	
	/*
		for (int i = 0; i < N; i++)
		{
			//fgets(pola[i], M+1, stdin);
			printf("tab1: ");
			for (int j = 0; j < M; j++)
			{
				printf("%c ",pola[i][j]);
				//pola[i][j]
				
			}
			printf("end\n");
			//printf("tab: %c end\n", pola[i]);
		}*/
	int wynik=0;
	wynik=poszukiwacz(pola,miasta,n,m);
	printf("%d\n", wynik);

	for (int i = 0; i < n; i++)
	{
		
		for (int j = 0; j < m; j++)
		{
			printf("%c ",pola[i][j]);
			
			
		}
		printf("\n");
	
	}
	for (int i = 0; i < n; i++)
	{
		
		for (int j = 0; j < m; j++)
		{
			printf("%d ",miasta[i][j]);

			
			
		}
		printf("\n");
	
	}



	return 0;
}