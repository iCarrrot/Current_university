#include <stdio.h>
#include <list>
#include <utility>


using namespace std;
#define M 2000
#define N 2000



char pola[N][M];

struct data{
	int first;
	int second;
	char letter;
};
int one=1;

data temp;
list < data> lista;
char up;
char right;
char left;
char down;

int  i1;
int  j1;

int main(){
	int n,m;
	scanf("%d %d\n" ,&n,&m);

	for (int i = 0; i < n; i++)
	{
		fgets(pola[i], m+1, stdin);
		scanf("\n");
	
	}
	int liczba_miast=0;
	for (int i = 0; i < n; i++)
	{

		for (int j = 0; j < m; j++)
		{
			if (pola[i][j]!='o')
			{
				if(pola[i][j]!='A')
				{	
					i1=i;
					j1=j;
					
					temp={i,j,pola[i][j]};
					lista.push_back(temp);
					while(lista.size() > 0){
						
						i=lista.begin()->first;
						j=lista.begin()->second;
						char pole=lista.begin()->letter;
						
						switch (pole)
						{
							
							case 'F':
								i+1<n? up= pola[i+1][j]:up='A';
								j+1<m? right=pola[i][j+1]:right='A';
								j-1>=0? left=pola[i][j-1]:left='A';
								i-1>=0? down=pola[i-1][j]:down='A';
								
								pola[i][j]='o';
								
								if(up=='D'||up=='C'||up=='F'){
									
									
									temp={i+1,j,up};
									lista.push_back(temp);

								}
								if(right=='B'||right=='C'||right=='F'){
									
									
									temp={i,j+1,right};
									lista.push_back(temp);
								}
								if(down=='B'||down=='E'||down=='F'){
									
									
									temp={i-1,j,down};
									lista.push_back(temp);
								}
								if(left=='D'||left=='E'||left=='F'){
									
									
									temp={i,j-1,left};
									lista.push_back(temp);
								}
								break;

							case 'B':
								pola[i][j]='o';
								i+1<n? up= pola[i+1][j]:up='A';
								
								j-1>=0? left=pola[i][j-1]:left='A';
								
								if(up=='D'||up=='C'||up=='F'){
									
									
									temp={i+1,j,up};
									lista.push_back(temp);
								}
								
								if(left=='D'||left=='E'||left=='F'){
									
									
									temp={i,j-1,left};
									lista.push_back(temp);
								}
								break;

							case 'C':
								j-1>=0? left=pola[i][j-1]:left='A';
								i-1>=0? down=pola[i-1][j]:down='A';
								pola[i][j]='o';

								if(down=='B'||down=='E'||down=='F'){
									
									
									temp={i-1,j,down};
									lista.push_back(temp);
								}
								if(left=='D'||left=='E'||left=='F'){
									
									
									temp={i,j-1,left};
									lista.push_back(temp);
								}
								break;
							case 'D':
								pola[i][j]='o';
								
								j+1<m? right=pola[i][j+1]:right='A';
								
								i-1>=0? down=pola[i-1][j]:down='A';
								
								if(right=='B'||right=='C'||right=='F'){
									
									
									temp={i,j+1,right};
									lista.push_back(temp);
								}
								if(down=='B'||down=='E'||down=='F'){
									
									
									temp={i-1,j,down};
									lista.push_back(temp);
								}
								break;

							case 'E':
								pola[i][j]='o';

								i+1<n? up= pola[i+1][j]:up='A';
								j+1<m? right=pola[i][j+1]:right='A';

								if(up=='D'||up=='C'||up=='F'){
									
									
									temp={i+1,j,up};
									lista.push_back(temp);
								}
								if(right=='B'||right=='C'||right=='F'){
									
									
									temp={i,j+1,right};
									lista.push_back(temp);
								}
								break;

							default:
								pola[i][j]='o';
								break;
						}

						lista.pop_front();
					}
					liczba_miast++;	
					i=i1;
					j=j1;
				}

				else
				{
					pola[i][j]='o';
				}
			}
		}
	}

	printf("%d", liczba_miast);

	return 0;
}