#include <stdio.h>
#include <queue>
#include <stdint.h>
#include <list>
#include <array>
using namespace std;



struct que_wiadr{
  unsigned short w[7];
  int level;
};

struct lEl{
  unsigned short w[7];
};
//list<lEl> * istniejace[324031];

bool compare(unsigned short tab1[], unsigned short tab2[], unsigned short n){
  //printf("tab1: ");
  for (size_t i = 0; i < n; i++) {
    //printf("%d ", tab1[i]);
  }
  //printf("\ntab2: ");
  for (size_t i = 0; i < n; i++) {
    //printf("%d ", tab2[i]);
  }
  //printf("\n");
  for (size_t i = 0; i < n; i++) {
    //printf("compare %d %d \n", tab1[i], tab2[i]);
    if(tab1[i]!=tab2[i])
      return 0;
  }
  return 1;
}

bool insert( array<list<lEl>, 324031> * istniejace, unsigned int hash, unsigned short elem[], unsigned short n){
  ////printf("dupa\n");
/*
  if((*istniejace)[hash].empty()){
    lEl temp;
    for (size_t i = 0; i < n; i++) {
      temp.w[i]=elem[i];
      //printf("new: %d\n", elem[i]);
    }
    for (size_t i = n; i < 7; i++) {
      temp.w[i]=0;
    //  //printf("new: %d\n", elem[i]);
    }

    (*istniejace)[hash].push_back(temp);
    ////printf("dodany: %u\n",(*istniejace)[hash].w[0] );
    return 1;
  }
  else{
  */
    ////printf("2\n" );
  for (list<lEl>::iterator i = (*istniejace)[hash].begin(); i != (*istniejace)[hash].end() ; i++) {
    if(compare(i->w,elem,n)){
      return 0;
    }
  }

  lEl temp;
  for (size_t i = 0; i < n; i++) {
    temp.w[i]=elem[i];
    //printf("new: %d\n", elem[i]);
  }
  for (size_t i = n; i < 7; i++) {
    temp.w[i]=0;
  //  //printf("new: %d\n", elem[i]);
  }

  (*istniejace)[hash].push_back(temp);
  return 1;

  //}
  //return 1;
};


//hashing function via Wikipedia
uint32_t murmur3_32(const uint8_t* key, size_t len, uint32_t seed) {
  uint32_t h = seed;
  if (len > 3) {
    const uint32_t* key_x4 = (const uint32_t*) key;
    size_t i = len >> 2;
    do {
      uint32_t k = *key_x4++;
      k *= 0xcc9e2d51;
      k = (k << 15) | (k >> 17);
      k *= 0x1b873593;
      h ^= k;
      h = (h << 13) | (h >> 19);
      h = (h * 5) + 0xe6546b64;
    } while (--i);
    key = (const uint8_t*) key_x4;
  }
  if (len & 3) {
    size_t i = len & 3;
    uint32_t k = 0;
    key = &key[i - 1];
    do {
      k <<= 8;
      k |= *key--;
    } while (--i);
    k *= 0xcc9e2d51;
    k = (k << 15) | (k >> 17);
    k *= 0x1b873593;
    h ^= k;
  }
  h ^= len;
  h ^= h >> 16;
  h *= 0x85ebca6b;
  h ^= h >> 13;
  h *= 0xc2b2ae35;
  h ^= h >> 16;
  return h;
}

bool ifEgsist(array<list<lEl>, 324031> * istniejace, que_wiadr* elem, unsigned short n){
  ////printf("IE -1");
  const uint32_t Seed  = 0x811C9DC5; // 2166136261
  ////printf("IE 0");
  unsigned int hash = murmur3_32((uint8_t*)elem->w,2*n,Seed);
  hash%=324031;
  ////printf("IE 1");
  ////printf("%d\n", istniejace[hash]);
  if(insert(istniejace, hash, elem->w, n)){
    ////printf("IE 2");
    return 0;
  }

  else
    return 1;
}

void printW(que_wiadr elem, unsigned short n, int lKomb, int lKrok){
  printf("%d: ( ", lKomb);
  for (int i = 0; i < n-1; i++) {
    printf("%d, ", elem.w[i]);
  }
  printf("%d) %d\n", elem.w[n-1],lKrok);
}

int main(){

int d=0;
scanf("%d\n", &d);
//printf("d: %d\n",d);

  for (int ii = 0; ii < d; ii++)
  {
    array<list<lEl>, 324031> istniejace;
    //for (size_t i = 0; i < 324031; i++) {
    //  if(!istniejace[i]->empty()){
        //istniejace[i]->clear();
      //}
    //}
    int lKomb=1;
    int lKrok=0;
    unsigned short n=0;
    scanf("%hu", &n);
    //printf("n: %d\n",n );
    short wiadra[n];
    for (int i = 0; i < n; i++) {
      scanf(" %hu", &(wiadra[i]));
      //printf("wiadra: %d \n", wiadra[i] );
    }
    ////printf("\n");
    queue<que_wiadr> kolejka;
    que_wiadr first;
    for (int i = 0; i < n; i++) {
      first.w[i]=wiadra[i];
    }
    first.level=0;
    kolejka.push(first);
    //printW(first, n, lKomb, lKrok);

    ////printf("001\n" );
    while(!kolejka.empty()){
      que_wiadr actual = kolejka.front();
      for (int i = 0; i < n; i++) {
        if(actual.w[i]>0){
          que_wiadr temp = actual;
          temp.w[i]=0;
          ////printf("01\n" );
          if(!ifEgsist(&istniejace, &temp, n)){
            ////printf("a\n" );
            ++temp.level;
            ++lKomb;
            temp.level>lKrok?lKrok=temp.level : 0;
            kolejka.push(temp);
            //printW(temp, n, lKomb, lKrok);
            ////printf("a\n" );
          }
          ////printf("02\n" );
        }
      }
      for (int i = 0; i < n; i++) {
        ////printf("0\n" );
        if(actual.w[i]<wiadra[i]){
          for (int j = 0; j < i; j++) {
            que_wiadr temp = actual;
            short temp_j=  temp.w[i] + temp.w[j] - wiadra[i];
            temp.w[i]+temp.w[j]<wiadra[i]? temp.w[i]+=temp.w[j] : temp.w[i] = wiadra[i];
            temp_j > 0 ? temp.w[j] = temp_j : temp.w[j] = 0 ;
            ////printf("1\n" );
            if(!ifEgsist(&istniejace, &temp, n)){
              ++temp.level;
              ++lKomb;
              temp.level>lKrok?lKrok=temp.level : 0;
              kolejka.push(temp);
              //printW(temp, n, lKomb, lKrok);
            }
            ////printf("2\n" );
          }
          for (int j = i+1; j < n; j++) {
            que_wiadr temp = actual;
            short temp_j=  temp.w[i] + temp.w[j] - wiadra[i];
            temp.w[i]+temp.w[j]<wiadra[i]? temp.w[i]+=temp.w[j] : temp.w[i] = wiadra[i];
            temp_j > 0 ? temp.w[j] = temp_j : temp.w[j] = 0 ;
            ////printf("3\n" );
            if(!ifEgsist(&istniejace, &temp, n)){
              ++temp.level;
              ++lKomb;
              temp.level>lKrok?lKrok=temp.level : 0;
              kolejka.push(temp);
              //printW(temp, n, lKomb, lKrok);
            }
            ////printf("4\n" );
          }
        }
      }
      kolejka.pop();
    }

    ////printf("\n\n\n");
    printf("%d %d\n", lKomb, lKrok);

  }
	return 0;
}
