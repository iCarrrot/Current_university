#include <stdio.h>
#include <bitset> 
#include <stdint.h>
#include <ctime>
using namespace std;



struct plansza
{
	bool maska[6];
};

plansza board[1000000/2];
bitset<6> mask[36];
bitset<6> bitMask[36];
bitset<6> m1 (33);
bitset<6> m2 (18);

int8_t way[1000000/2][36];
int8_t wayBack[1000000/2];

unsigned int konie[1000000/2][36];
//bitset<6> temp;


bitset<6> convert(bool maska[])
{
	bitset<6> x;
	for(int i=0; i< 6; i++)
	{
		x[i]=maska[i];
	}
	return x;
}

plansza makeMask (char tab1[], char tab2[])
{
	
	plansza x;
	/*
		tab1[i]=='.'?x.maska[4-2*i]=1:x.maska[4-2*i]=0;
		tab2[i]=='.'?x.maska[5-2*i]=1:x.maska[5-2*i]=0;
	*/
	x.maska[0]=(tab2[0]>>1) &1;
	x.maska[1]=(tab1[0]>>1) &1;
	x.maska[2]=(tab2[1]>>1) &1;
	x.maska[3]=(tab1[1]>>1) &1;
	x.maska[4]=(tab2[2]>>1) &1;
	x.maska[5]=(tab1[2]>>1) &1;

	return x;

}


int main()
{	
clock_t begin = clock();

	int n;
	//pobieranie danych
		scanf("%d\n",&n);

		char tab1[4];
		char tab2[4];

		for (int i = 0; i < n/2; i++)
		{			

			fgets(tab1, 4, stdin);		
			scanf("\n");
			fgets(tab2, 4, stdin);
			scanf("\n");		
			board[i]=makeMask(tab1,tab2);		
		}		
		if(n%2)
		{
			fgets(tab1, 4, stdin);
			scanf("\n");
			tab2[0]='x';
			tab2[1]='x';
			tab2[2]='x';
			board[n/2]=makeMask(tab1,tab2);
			
		}

	//robienie masek
		int ja=0;
		for(unsigned int i=0;i<64;i++)
		{
			
			bitset<6> temp (i) ;
			
			if(  (temp&m1).count()<2  &&  (temp&m2 ).count()<2  )
			{
				mask[ja]=temp;
				ja++;
			}
			
		}

	//robienie masek bicia
		bitset<6> boardMask=convert(board[0].maska);
		for(unsigned int i=0;i<36;i++)
		{
			
			bitset<6> temp  ;
			temp[0]=mask[i][2];
			temp[1]=(mask[i][4]+mask[i][3])>0;
			temp[2]=(mask[i][4]+mask[i][0])>0;
			temp[3]=(mask[i][5]+mask[i][1])>0;
			temp[4]=mask[i][2];
			temp[5]=(mask[i][0]+mask[i][3])>0;
			bitMask[i]=temp;
			(mask[i]&boardMask) == mask[i]? konie[0][i]=mask[i].count() : konie[0][i]=0; 
		}
clock_t e1= clock();

	for(int i=1;i<(n+1)/2;i++)
	{
		boardMask=convert(board[i].maska);
		
		for(int j=0; j<36;j++)
		{
			
			if((mask[j]&boardMask) == mask[j])
			{	
				int max=0;
				int8_t pos=0;
				for(int k=0; k<36; k++)
				{	

					if((mask[j]&~bitMask[k]) == mask[j])
					{
						int tempx=konie[i-1][k]+mask[j].count();
						if(tempx>max)
						{
							max=tempx;
							pos=k;
						}
					}
				}
				konie[i][j]=max;
				way[i][j]=pos;
			}
			else
			{
				konie[i][j]=0;
			}

		}
	}
clock_t e2= clock();

	unsigned int lastMax=0;
	int8_t lastPos=0;
	for (int8_t i = 0; i < 36; i++)
	{	
		if(lastMax<konie[(n+1)/2-1][i])
		{
			lastMax=konie[(n+1)/2-1][i];
			lastPos=i;

		}
	}
	//printf("a\n");
	
	for (int i = (n+1)/2 -1; i >0 ; i--)
	{	
		//printf("%d\n", i);
		wayBack[i]=lastPos;
		lastPos=way[i][lastPos];
	}
	wayBack[0]=lastPos;
	//printf("a\n");
	printf("%d\n", lastMax);

clock_t e3= clock();

	for (int i = 0; i < (n+1)/2; i++)
	{
		char b[6];
		boardMask=convert(board[i].maska);
		bitset<6> horseMask= mask[wayBack[i]];
		horseMask[1]==1?b[0]='S': b[0]=boardMask[1]*46 + (1-boardMask[1])*120;
		horseMask[3]==1?b[1]='S': b[1]=boardMask[3]*46 + (1-boardMask[3])*120;
		horseMask[5]==1?b[2]='S': b[2]=boardMask[5]*46 + (1-boardMask[5])*120;
		horseMask[0]==1?b[3]='S': b[3]=boardMask[0]*46 + (1-boardMask[0])*120;
		horseMask[2]==1?b[4]='S': b[4]=boardMask[2]*46 + (1-boardMask[2])*120;
		horseMask[4]==1?b[5]='S': b[5]=boardMask[4]*46 + (1-boardMask[4])*120;


		//printf("%c%c%c\n%c%c%c\n", b[0],b[1],b[2],b[3],b[4],b[5] );


		//cout<<"indx: "<<(int)wayBack[i]<<" mask:"<<mask[wayBack[i]]<<endl;
	}
clock_t end = clock();
	printf("1: %li 2: %li 3: %li całość: %li\n",e1-begin,e2-e1,e3-e2,end-begin);







	return 0;
}