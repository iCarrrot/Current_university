int led,ledT;
int led3 = 9;  
int led1 = 10; 
int led2 = 11; 
int bright1=0;
int bright2=0;
int bright3=0;
int brightR1=0;
int brightR2=0;
int brightR3=0;
int del=5;
const unsigned char sinus[] = {
  1, 1, 1, 1, 1, 1, 1, 1,
  1, 1, 1, 1, 1, 1, 1, 1,
  1, 1, 1, 2, 2, 2, 2, 2,
  2, 2, 3, 3, 3, 3, 3, 3,
  4, 4, 4, 4, 4, 5, 5, 5,
  5, 6, 6, 6, 6, 7, 7, 7,
  8, 8, 8, 8, 9, 9, 9, 10,
  10, 10, 11, 11, 11, 12, 12, 13,
  13, 13, 14, 14, 15, 15, 15, 16,
  16, 17, 17, 18, 18, 18, 19, 19,
  20, 20, 21, 21, 22, 22, 23, 23,
  24, 24, 25, 25, 26, 26, 27, 27,
  28, 29, 29, 30, 30, 31, 31, 32,
  33, 33, 34, 34, 35, 36, 36, 37,
  38, 38, 39, 39, 40, 41, 41, 42,
  43, 43, 44, 45, 46, 46, 47, 48,
  48, 49, 50, 50, 51, 52, 53, 53,
  54, 55, 56, 56, 57, 58, 59, 59,
  60, 61, 62, 62, 63, 64, 65, 66,
  66, 67, 68, 69, 70, 70, 71, 72,
  73, 74, 75, 75, 76, 77, 78, 79,
  80, 80, 81, 82, 83, 84, 85, 86,
  87, 87, 88, 89, 90, 91, 92, 93,
  94, 95, 95, 96, 97, 98, 99, 100,
  101, 102, 103, 104, 105, 106, 106, 107,
  108, 109, 110, 111, 112, 113, 114, 115,
  116, 117, 118, 119, 120, 121, 122, 122,
  123, 124, 125, 126, 127, 128, 129, 130,
  131, 132, 133, 134, 135, 136, 137, 138,
  139, 140, 141, 142, 143, 144, 145, 146,
  147, 148, 149, 150, 151, 152, 153, 154,
  155, 156
};

void setup(void) {
  Serial.begin(9600);  
  pinMode(led3, OUTPUT);
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
}
void loop(void) {
    analogWrite(led1,255);
    analogWrite(led2,255);
    analogWrite(led3,255);
    brightR1=random(0,256);
    brightR2=random(0,256);
    brightR3=random(0,256);
  for (int i=0;i<sizeof(sinus);i++){
    bright1=map(sinus[i],0,156,255,brightR1);
    bright2=map(sinus[i],0,156,255,brightR2);
    bright3=map(sinus[i],0,156,255,brightR3);
    analogWrite(led1,bright1);
    analogWrite(led2,bright2);
    analogWrite(led3,bright3);
    delay(del);
  }
  delay(del*100);
  for (int i=sizeof(sinus)-1;i>=0;i--){
    bright1=map(sinus[i],0,156,255,brightR1);
    bright2=map(sinus[i],0,156,255,brightR2);
    bright3=map(sinus[i],0,156,255,brightR3);
    analogWrite(led1,bright1);
    analogWrite(led2,bright2);
    analogWrite(led3,bright3);
    delay(del);
  }
  delay(del*100);
}








