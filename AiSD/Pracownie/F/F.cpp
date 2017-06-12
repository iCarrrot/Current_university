#include <stdio.h>
#include <stdint.h>
#include <climits>
using namespace std;
int binSearch(int beg, int end, int elem, int tab[]){
  int mid = (beg+ end)/2;
  if(elem<tab[beg]){
    return beg-1+ beg==0;
  }
  if(elem>tab[end]){
    return end;
  }
  if(tab[mid]<elem && tab[mid+1]>=elem){
    return mid;
  }
  else if(tab[mid]==elem){
    return mid-1;
  }
  return (tab[mid]>elem? binSearch(beg,mid,elem,tab) : binSearch(mid+1,end,elem,tab));
}
int main(){

int T=0;
scanf("%d\n", &T);

  for (int ii = 0; ii < T; ii++)
  {
    int n=0;
    scanf("%d\n", &n);
    int A[n];
    for (int i = 0; i < n; i++) {
      scanf("%d \n", &(A[i]) );
    }
    int Asc[n];
    int Dec[n];
    int len[n];
    Asc[n-1]=1;
    for (int i = n-2; i >= 0; i--) {
      A[i]<A[i+1]?Asc[i]=Asc[i+1]+1 : Asc[i]=1;
    }
    Dec[0]=1;
    int maxDec=0;
    for (int i = 1; i < n; i++) {
      A[i]>A[i-1] ? Dec[i]=Dec[i-1]+1 : Dec[i]=1;
    }
    for (int i = 0; i < n; i++) {
      if(len[Dec[i]]>A[i])
        len[Dec[i]]=A[i];
      len[i]=INT_MAX;
    }
    len[0]=0;
    int maxLen=1;
    for (int i =0; i <n; i++) {
      if(len[Dec[i]]>=A[i]||Dec[i]>maxDec){
        len[Dec[i]]=A[i];
      }
      maxDec=(Dec[i]>maxDec?Dec[i]:maxDec);
      int j= binSearch(0,maxDec,A[i],len);
      maxLen=(Asc[i]+j>maxLen?Asc[i]+j:maxLen);
    }
    printf("%d\n",maxLen );
  }
	return 0;
}
