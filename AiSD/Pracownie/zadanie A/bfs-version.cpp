#include <stdio.h>
#include <tuple>
#include <list>

using namespace std;
#define M 2000
#define N 2000

void mark(int fi,int fj, char pola[N][M], bool miasta[N][M], int n, int m){
	
	char up;
	char right;
	char left;
	char down;
	
	short int i1=fi;
	short int j1=fj;
	list <tuple <short int,short int> > lista;
	lista.push_back(make_tuple(i1,j1));
	
	do{
		
		short int i=get<0>(*lista.begin());
		short int j=get<1>(*lista.begin());

		i+1<n? up= pola[i+1][j]:up='A';
		j+1<m? right=pola[i][j+1]:right='A';
		j-1>=0? left=pola[i][j-1]:left='A';
		i-1>=0? down=pola[i-1][j]:down='A';

		switch (pola[i][j])
		{
			case 'A':
				miasta[i][j]=1;
				break;

			case 'F':
				miasta[i][j]=1;
				
				if(miasta[i+1][j]==0 && (up=='D'||up=='C'||up=='F')){
					lista.push_back(make_tuple(i+1, j));
				}
				if(miasta[i][j+1]==0 && (right=='B'||right=='C'||right=='F')){
					lista.push_back(make_tuple(i, j+1));
				}
				if(miasta[i-1][j]==0 && (down=='B'||down=='E'||down=='F')){
					lista.push_back(make_tuple(i-1, j));
				}
				if(miasta[i][j-1]==0 && (left=='D'||left=='E'||left=='F')){
					lista.push_back(make_tuple(i, j-1));
				}
				break;


			case 'B':
				miasta[i][j]=1;

				if(miasta[i+1][j]==0 && (up=='D'||up=='C'||up=='F')){
					lista.push_back(make_tuple(i+1, j));
				}
				
				if(miasta[i][j-1]==0 && (left=='D'||left=='E'||left=='F')){
					lista.push_back(make_tuple(i, j-1));
				}
				break;

			case 'C':
				miasta[i][j]=1;

				if(miasta[i-1][j]==0 && (down=='B'||down=='E'||down=='F')){
					lista.push_back(make_tuple(i-1, j));
				}
				if(miasta[i][j-1]==0 && (left=='D'||left=='E'||left=='F')){
					lista.push_back(make_tuple(i, j-1));
				}
				break;
			case 'D':
				miasta[i][j]=1;
				
				if(miasta[i][j+1]==0 && (right=='B'||right=='C'||right=='F')){
					lista.push_back(make_tuple(i, j+1));
				}
				if(miasta[i-1][j]==0 && (down=='B'||down=='E'||down=='F')){
					lista.push_back(make_tuple(i-1, j));
				}
				break;

			case 'E':
				miasta[i][j]=1;

				if(miasta[i+1][j]==0 && (up=='D'||up=='C'||up=='F')){
					lista.push_back(make_tuple(i+1, j));
				}
				if(miasta[i][j+1]==0 && (right=='B'||right=='C'||right=='F')){
					lista.push_back(make_tuple(i, j+1));
				}
				break;
		}
		lista.pop_front();
	}while(lista.size() > 0);
}



int poszukiwacz(char pola[N][M], bool miasta[N][M],int n,int m ){
	int liczba_miast=0;
	for (int i = 0; i < n; i++)
	{

		for (int j = 0; j < m; j++)
		{
			if (pola[i][j]!='A')
			{
				if(miasta[i][j]==0)
				{
					mark(i,j,pola,miasta,n,m);
					liczba_miast++;
				}
			}
			else{
				miasta[i][j]=1;
			}
			
		}

	
	}
	return liczba_miast;
}

int main(){
	int n,m;
	scanf("%d %d\n" ,&n,&m);
	char pola[N][M];
	bool miasta[N][M];
	
	
	for (int i = 0; i < n; i++)
	{
		fgets(pola[i], m+1, stdin);
		scanf("\n");
		for (int j = 0; j < m; j++)
		{
			miasta[i][j]=0;
			
		}
	
	}

	int wynik=0;
	wynik=poszukiwacz(pola,miasta,n,m);
	printf("%d\n", wynik);

	return 0;
}