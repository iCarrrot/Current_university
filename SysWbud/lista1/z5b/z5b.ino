int led3 = 9;  
const int minBut = 2; 
int s=1024;
bool fst=1;
bool list[1024];
int licznik1=0;
int licznik2=-1000;
void setup(void) {
  Serial.begin(9600);  
  pinMode(led3, OUTPUT);
  pinMode(minBut, INPUT);
}
void loop(void) {
  if (fst){
    fst=0;
    for(int i=0;i<s;i++){
      list[i]=LOW;
          }
     digitalWrite(led3,HIGH);
     delay(10);
     digitalWrite(led3,LOW);
     delay(50);
     digitalWrite(led3,HIGH);
     delay(10);
     digitalWrite(led3,LOW);
     delay(50);   
  }
  list[licznik1]=digitalRead(minBut);
  licznik2++;
  if (licznik2>=0){
    licznik2=licznik2 % 1001;
    digitalWrite(led3,list[licznik2]);   
  }
  licznik1++;
  licznik1=licznik1 % 1001;
  delay(1);
}







