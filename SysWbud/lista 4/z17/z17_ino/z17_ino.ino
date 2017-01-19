int L = 0; 
int B = 11; 
int Low=4;
int High=5;
int Rec=2;
int Play=3;
int Red=10;
int Stop = 1;
int Green=9;

const int length=1000;

int change =0;
int l=0;
int b=0;
int low=0;
int high=0;
int play=0;
int rec=0;

int record[length];b
int r=0;
int licznik=0;
int endOfSong=0;
int p=0;
int iter=0;
int fin =1 ;
int start=0;
int stp=0;

void setup(void) {
  Serial.begin(9600);  
  pinMode(B, OUTPUT);
  pinMode(Green, OUTPUT);
  pinMode(Red, OUTPUT);
  pinMode(L, INPUT);
  pinMode(Low, INPUT);
  pinMode(High, INPUT);
  pinMode(Rec, INPUT);
  pinMode(Play, INPUT);
  pinMode(Stop, INPUT);

}

void loop(void) {
  Serial.print("light: ");
  Serial.print(l);
  Serial.print(" buzzer: ");
  Serial.print(b);
  Serial.print(" low button: ");
  Serial.print(rec);
  Serial.print(" high button: ");
  Serial.print(play);
  Serial.print("\n");
  l=analogRead(L);
  low=analogRead(Low);
  high=analogRead(High);
  rec=analogRead(Rec);
  play=analogRead(Play);
  stp=analogRead(Stop);
  if (low==1023){
    change-=10;
  }
  if (high==1023){
    change+=10;
  }
  b=map(l,0,1023,40,2000)+change;
  if(p!=1){
    if (b<=40)
      noTone(B);
    else
      tone(B,b);
  }
  if(rec==1023){
    r=1;
  }  
  if(r==1 && stp!=1023 ){
    digitalWrite(Red,HIGH);
    b>=40?record[licznik]=b:record[licznik]=0;
    if(licznik<length-1){
      licznik++;}
    else{
      licznik=0;
      endOfSong=1;
    }
  }
  if(r==1 && stp==1023 ){
    r=0;
    if(endOfSong==1){
       start=licznik+1;
       fin=length;
    }
    else{
      start=0;
      fin=licznik;
    }
    licznik=0; 
    digitalWrite(Red,LOW); 
  }
  
  if(play==1023){
    p=1;
    iter=start;
  }
 
  if(p==1 && stp!=1023){
    record[iter]>40?tone(B,record[iter]):noTone(B);
    iter++;
    iter%=fin;
    digitalWrite(Green,HIGH);
  }
  if(p==1 && stp==1023){
    p=0;
    iter=start;
    digitalWrite(Green,LOW);
  }
    
  delay(10);
  
  
}



