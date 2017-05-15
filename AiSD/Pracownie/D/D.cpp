#include <stdio.h>
#include <vector>
#include <queue>
#include <algorithm>
#include <map>
using namespace std;
vector<unsigned int> drzewo1[500001];
vector<unsigned int> drzewo2[500001];
map<vector<unsigned int>,int> mapa;
size_t ii=0;

vector<unsigned int>::iterator deleteElem (vector<unsigned int>::iterator begin, vector<unsigned int>::iterator end, unsigned int number ){
  for (vector<unsigned int>::iterator it = begin; it!=end; ++it) {
    if(*it==number){
      return it;
    }
  }
  return end;
}

unsigned int findCenter(unsigned int * N, vector<unsigned int> drzewo[], unsigned int  *newN1){
  unsigned int n=*N;
  queue <unsigned int> center1;
  unsigned int centroid1=0;
  unsigned int poziom[n];
  unsigned int deg[n];
  for (size_t i = 0; i < n; ++i) {
    deg[i]= (drzewo[i]).size();
  }

  for (unsigned int i = 0; i < n; ++i) {
    if(deg[i]==1){
      center1.push(i);
      poziom[i]=1;
    }
  }
  while(*newN1>1){
    unsigned int i = center1.front();
    center1.pop();
    --deg[i];
    for (size_t j = 0; j < drzewo[i].size(); j++) {
      unsigned int x=(drzewo[i])[j];
      if(deg[x]>0){
        if(deg[x]==2){
          center1.push(x);
          poziom[x]=poziom[i]+1;
        //  cout<<"dodano: "<< x<<endl;

        }
          else
          --deg[x];
      }
    }
    (*newN1)-=1;
  }
  unsigned int t1,t2;
  t1 = center1.front();
  if(center1.size()==2){
    center1.pop();
    t2 = center1.front();
  }
  else {
    printf("AAAAAAAAAAAAAAAAAAAAAAAAAAAA\n" );
    t1>0?t2 = t1-1 : t2 = 1;
  }

  if(poziom[t1]==poziom[t2]){
    *newN1=1;
    (drzewo[t1]).erase(deleteElem((drzewo[t1]).begin(), (drzewo[t1]).end(), t2));
    (drzewo[t2]).erase(deleteElem((drzewo[t2]).begin(), (drzewo[t2]).end(), t1));
    (drzewo[n]).push_back(t1);
    (drzewo[n]).push_back(t2);
    (drzewo[t1]).push_back(n);
    (drzewo[t2]).push_back(n);
    return n;
  }
  else{
    poziom[t1]>poziom[t2]?centroid1=t1:centroid1=t2;
    *newN1=0;
  }
  return centroid1;
}

int hashTree(unsigned int current, unsigned int father,vector<unsigned int> drzewo[],  int * licznik, unsigned char sequence){
  if(drzewo[current].size()==1){
    return 0;
  }
  vector<unsigned int> v;
  for (size_t i = 0; i < drzewo[current].size(); ++i) {
    if((drzewo[current])[i]!=father){
      int a=hashTree((drzewo[current])[i],current,drzewo, licznik, sequence);
      if(a>-1)
        v.push_back(a);
      else
        return -1;
    }
  }
  sort(v.begin(),v.end());
  map<vector<unsigned int>,int>::iterator it=mapa.find(v);
  if (it != mapa.end()){
    return it->second;
  }
  else{
    if(sequence==1)
      mapa.insert( pair<vector<unsigned int>,int>(v,++(*licznik)));
    else
      return -1;
  }
  return *licznik;
}
int main(){

unsigned int lSlow=0;
scanf("%d\n", &lSlow);

for (ii = 0; ii < lSlow; ii++)
{
  int ok=1;
  unsigned int n;
  scanf("%d\n",&n );
  unsigned int w1,w2;
  for (unsigned int i = 0; i < n-1; ++i) {
    scanf("%d %d\n", &w1, &w2);
    (drzewo1[w1-1]).push_back(w2-1);
    (drzewo1[w2-1]).push_back(w1-1);
  }
  for (unsigned int i = 0; i < n-1; ++i) {
    scanf("%d %d\n", &w1, &w2);
    (drzewo2[w1-1]).push_back(w2-1);
    (drzewo2[w2-1]).push_back(w1-1);
    }
  unsigned int newN1=n-1;
  unsigned int newN2=n-1;
  unsigned int centroid1=findCenter(&n,drzewo1, &newN1);
  unsigned int centroid2=findCenter(&n,drzewo2, &newN2);

  if(newN2==newN1){
    newN1==1?n++:n;
  }
  else{
    printf("NIE\n");
    ok=0;
  }
  if(ok){
    int licznik =1;
    int code1=hashTree(centroid1, n+2, drzewo1, &licznik, 1);
    int code2=hashTree(centroid2, n+2, drzewo2, &licznik, 2);
    code1==code2? printf("TAK\n") : printf("NIE\n");
  }

  for (size_t i = 0; (i < n+1)&&(i<500001); ++i) {
    (drzewo1[i]).clear();
    (drzewo2[i]).clear();
  }
  mapa.clear();
  }
	return 0;
}
