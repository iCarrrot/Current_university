int X = 0; 
int Y = 1; 
int B =5;
int R=9;
int G=8;
int x=0;
int y=0;
int randomR=0;
int randomG=0;
int maxX=512;
int maxY=512;
int r=0;
int g=0;
int mov=0;
int start=1;
int a=0;
int b=0;

void setup(void) {
  Serial.begin(9600);  
  pinMode(X, INPUT);
  pinMode(Y, INPUT);
  pinMode(B, INPUT);
  pinMode(R, OUTPUT);
  pinMode(G, OUTPUT);



}

void loop(void) {
  int b=analogRead(B); 
  Serial.print("r: ");
  Serial.print(r);
  Serial.print(" g: ");
  Serial.print(g);
  Serial.print(" ranR: ");
  Serial.print(randomR);
  Serial.print(" ranG: ");
  Serial.print(randomG);
  Serial.print(" \n");
  if (start==1){
    randomR=random(0,1024);
    randomG=random(0,1024);
  }
  if(b==1023||start==1){
    analogWrite(R,randomR/4);
    analogWrite(G,randomG/4);
    delay(500);
    analogWrite(R,0);
    analogWrite(G,0);
    start=0;
    
  }
  x = analogRead(X);
  y = analogRead(Y);
  if(abs(x-512)>abs(maxX-512) && mov==1){
    maxX=x;
  }
  if(abs(y-512)>abs(maxY-512) && mov==1){
    maxY=y;
  }
  if(abs(x-512)>=15 && abs(y-512)>=15 && mov==0){
    mov++;
  }
  
  if(abs(x-512)<15 && abs(y-512)<15 && mov==1){
    r=maxX;
    g=maxY;
    analogWrite(R,r/4);
    analogWrite(G,g/4);
    delay(500);
    analogWrite(R,0);
    analogWrite(G,0);
    maxX=512;
    maxY=512;
    mov=0;
  }
  if(abs(r-randomR)<400 && abs(g-randomG)<400){
    
    analogWrite(R,r/4);
    analogWrite(G,g/4);
    delay(100);
    analogWrite(R,0);
    analogWrite(G,0);
    delay(100);
    analogWrite(R,r/4);
    analogWrite(G,g/4);
    delay(100);
    analogWrite(R,0);
    analogWrite(G,0);
    delay(100);
    analogWrite(R,r/4);
    analogWrite(G,g/4);
    delay(100);
    analogWrite(R,0);
    analogWrite(G,0);
    start=1;
  }

  


}



