int light = 0; 
int buzzer = 42; 
int x=0;
int a=1;
int maxi=1024;
void setup(void) {
  Serial.begin(9600);  
  pinMode(buzzer, OUTPUT);
  pinMode(light, INPUT);

}

void loop(void) {
  if(a==1){
    maxi=analogRead(light);
    maxi*=1.2;
    a=0;
  }
  Serial.print("max:  ");
  Serial.print(maxi);
  
  Serial.print("\n");
  x=analogRead(light);
  Serial.print(x);
  int b=map(x,0,maxi,65535,32);
  b<0?b=0:b=b;
  tone(buzzer, b);
  
  Serial.print("\n");
  Serial.print(b);
  Serial.print("\n");
  delay(100);//poczekaj 0,1s
}



