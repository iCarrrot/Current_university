#include <iostream>
#include <fstream>
#include <time.h>
using namespace std;
size_t size = 396000000;
size_t *prechar= new size_t [256];
size_t *preshort= new size_t [65536];
size_t char_bits(unsigned char c)
{
  return __builtin_popcount(c);
}

size_t short_bits(unsigned short s)
{
  return __builtin_popcount(s);
}

size_t proc(unsigned char tab[], size_t s)
{
  size_t counter = 0;
  for (size_t i = 0; i < s; i++) {
    counter += __builtin_popcount(tab[i]);
  }
  return counter;
}

size_t brute(unsigned char tab[],size_t s)
{
  size_t counter = 0;
  for(size_t i = 0; i < s; i++)
  {
    while (tab[i]) {
      if(tab[i] & 1)
        counter++;
      tab[i] >>= 1;
    }
  }
  return counter;
}

size_t prec256(unsigned char tab[],size_t s)
{
  size_t counter = 0;
  for(size_t i = 0; i < s; i++)
    counter += prechar[tab[i]];
  return counter;
}

size_t prec65536(unsigned short tab[],size_t s)
{
  size_t counter = 0;
  for(size_t i = 0; i < s; i++)
    counter += preshort[tab[i]];
  return counter;
}

size_t mask(unsigned int tab[], size_t s)
{
  size_t counter = 0;
  for (size_t i = 0; i < s; i++) {
    unsigned int v = tab[i] - ((tab[i] >> 1) & 0x55555555);
    v = (v & 0x33333333) + ((v >> 2) & 0x33333333);
    counter += ((v + (v >> 4) & 0xF0F0F0F) * 0x1010101) >> 24;
  }
  return counter;
}

int main() {
  srand(time(NULL));

  unsigned char *mem1;
  unsigned char *mem2;
  unsigned char *mem3;
  unsigned short *mem4;
  unsigned int *mem5;


  mem1 = new unsigned char [size];
  mem2 = new unsigned char [size];
  mem3 = new unsigned char [size];
  mem4 = new unsigned short [size/2];
  mem5 = new unsigned int [size/4];
  //mem3 = new unsigned short [2000000];
  fstream file;
  file.open("plik.bin", ios::in|ios::binary);
  if(file.is_open())
  {
    printf("ok\n");
    for (size_t i = 0; i < size; i++) {
      file >> mem1[i];
    }
    file.close();
  }
  else
    printf("blad\n");

  for (size_t i = 0; i < size; i++) {
    mem2[i] = mem1[i];
    mem3[i] = mem1[i];
  }
  for (size_t i = 0; i < size; i+=2) {
    mem4[i/2] = (unsigned short)((unsigned short)(mem1[i] << 8) + (unsigned short)mem1[i+1]);
  }
  for (size_t i = 0; i < size; i+=4) {
    mem5[i/4] = (unsigned int)((unsigned int)((unsigned int)((unsigned int)((unsigned int)((unsigned int)(mem1[i] << 8) + (unsigned int)mem1[i+1])<<8)+(unsigned int)mem1[i+2]) << 8) + (unsigned int)mem1[i+3]);
  }
  for(unsigned char i = 0; i < 255; i++)
    prechar[i] = char_bits(i);
  prechar[255] = char_bits(255);
  for(unsigned short i = 0; i < 65535; i++)
    preshort[i] = short_bits(i);
  preshort[65535] = short_bits(65535);

  
  clock_t t5 = clock();
  size_t m = mask(mem5,size/4);
  t5 = clock() - t5;
  std::cout <<"maska: czas "<< t5 << endl << m << endl;
  clock_t t3 = clock();
  size_t c = prec256(mem3,size);
  t3 = clock()-t3;
  std::cout <<"precalc256: czas "<< t3 << endl << c << endl;
  clock_t t4 = clock();
  size_t s = prec65536(mem4,size/2);
  t4 = clock()-t4;
  std::cout <<"precalc65536: czas "<< t4 << endl << s << endl;
  clock_t t2 = clock();
  size_t p = proc(mem2,size);
  t2 = clock()-t2;
  std::cout <<"proc: czas "<< t2 << endl << p << endl;

  delete[] preshort;
  delete[] prechar;
  delete[] mem3;
  delete[] mem1;
  delete[] mem2;
  delete[] mem4;
  return 0;
}
