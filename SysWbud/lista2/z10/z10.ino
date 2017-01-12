
int led1 = 12;  
int led2 = 11;  
int led3 = 10;  
int led4 = 9;  
int led5 = 8;  
int t[]={2,1,2,8};

void setup(void) {
  Serial.begin(9600);  
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);
  pinMode(led4, OUTPUT);
  pinMode(led5, OUTPUT);

}
void cyfra(int c, float d){
    digitalWrite(led1,0);   
    digitalWrite(led2,0);   
    digitalWrite(led3,0);   
    digitalWrite(led4,0);   
    digitalWrite(led5,0);
  
  if (c==1){
    digitalWrite(led1,0);   
    digitalWrite(led2,0);   
    digitalWrite(led3,1);   
    digitalWrite(led4,0);   
    digitalWrite(led5,0);
 delay(d);
   digitalWrite(led1,0);   
    digitalWrite(led2,1);   
    digitalWrite(led3,0);   
    digitalWrite(led4,0);   
    digitalWrite(led5,0);
 delay(d);
    digitalWrite(led1,1);   
    digitalWrite(led2,1);   
    digitalWrite(led3,1);   
    digitalWrite(led4,1);   
    digitalWrite(led5,1);
 delay(d);
  }
if(c==2){
   digitalWrite(led1,1);   
    digitalWrite(led2,0);   
    digitalWrite(led3,0);   
    digitalWrite(led4,1);   
    digitalWrite(led5,1);
 delay(d);
   digitalWrite(led1,1);   
    digitalWrite(led2,0);   
    digitalWrite(led3,1);   
    digitalWrite(led4,0);   
    digitalWrite(led5,1);
 delay(d);
    digitalWrite(led1,1);   
    digitalWrite(led2,1);   
    digitalWrite(led3,0);   
    digitalWrite(led4,0);   
    digitalWrite(led5,1);
 delay(d);
}
if(c==3){
   digitalWrite(led1,1);   
    digitalWrite(led2,0);   
    digitalWrite(led3,1);   
    digitalWrite(led4,0);   
    digitalWrite(led5,1);
 delay(d);
   digitalWrite(led1,1);   
    digitalWrite(led2,0);   
    digitalWrite(led3,1);   
    digitalWrite(led4,0);   
    digitalWrite(led5,1);
 delay(d);
    digitalWrite(led1,1);   
    digitalWrite(led2,1);   
    digitalWrite(led3,1);   
    digitalWrite(led4,1);   
    digitalWrite(led5,1);
 delay(d);
}
if(c==4){
   digitalWrite(led1,1);   
    digitalWrite(led2,1);   
    digitalWrite(led3,1);   
    digitalWrite(led4,0);   
    digitalWrite(led5,0);
 delay(d);
   digitalWrite(led1,0);   
    digitalWrite(led2,0);   
    digitalWrite(led3,1);   
    digitalWrite(led4,0);   
    digitalWrite(led5,0);
 delay(d);
    digitalWrite(led1,0);   
    digitalWrite(led2,1);   
    digitalWrite(led3,1);   
    digitalWrite(led4,1);   
    digitalWrite(led5,1);
 delay(d);
}
if(c==5){
   digitalWrite(led1,1);   
    digitalWrite(led2,1);   
    digitalWrite(led3,1);   
    digitalWrite(led4,0);   
    digitalWrite(led5,1);
 delay(d);
   digitalWrite(led1,1);   
    digitalWrite(led2,0);   
    digitalWrite(led3,1);   
    digitalWrite(led4,0);   
    digitalWrite(led5,1);
 delay(d);
    digitalWrite(led1,1);   
    digitalWrite(led2,0);   
    digitalWrite(led3,1);   
    digitalWrite(led4,1);   
    digitalWrite(led5,1);
 delay(d);
}
if(c==6){
   digitalWrite(led1,1);   
    digitalWrite(led2,1);   
    digitalWrite(led3,1);   
    digitalWrite(led4,1);   
    digitalWrite(led5,1);
 delay(d);
   digitalWrite(led1,1);   
    digitalWrite(led2,0);   
    digitalWrite(led3,1);   
    digitalWrite(led4,0);   
    digitalWrite(led5,1);
 delay(d);
    digitalWrite(led1,1);   
    digitalWrite(led2,0);   
    digitalWrite(led3,1);   
    digitalWrite(led4,1);   
    digitalWrite(led5,1);
 delay(d);
}
if(c==7){
   digitalWrite(led1,1);   
    digitalWrite(led2,0);   
    digitalWrite(led3,0);   
    digitalWrite(led4,0);   
    digitalWrite(led5,0);
 delay(d);
  digitalWrite(led1,1);   
    digitalWrite(led2,0);   
    digitalWrite(led3,0);   
    digitalWrite(led4,0);   
    digitalWrite(led5,0);
 delay(d);
    digitalWrite(led1,1);   
    digitalWrite(led2,1);   
    digitalWrite(led3,1);   
    digitalWrite(led4,1);   
    digitalWrite(led5,1);
 delay(d);
}
if(c==8){
   digitalWrite(led1,1);   
    digitalWrite(led2,1);   
    digitalWrite(led3,1);   
    digitalWrite(led4,1);   
    digitalWrite(led5,1);
 delay(d);
  digitalWrite(led1,1);   
    digitalWrite(led2,0);   
    digitalWrite(led3,1);   
    digitalWrite(led4,0);   
    digitalWrite(led5,1);
 delay(d);
    digitalWrite(led1,1);   
    digitalWrite(led2,1);   
    digitalWrite(led3,1);   
    digitalWrite(led4,1);   
    digitalWrite(led5,1);
 delay(d);
}
if(c==9){
   digitalWrite(led1,1);   
    digitalWrite(led2,1);   
    digitalWrite(led3,1);   
    digitalWrite(led4,0);   
    digitalWrite(led5,1);
 delay(d);
  digitalWrite(led1,1);   
    digitalWrite(led2,0);   
    digitalWrite(led3,1);   
    digitalWrite(led4,0);   
    digitalWrite(led5,1);
 delay(d);
    digitalWrite(led1,1);   
    digitalWrite(led2,1);   
    digitalWrite(led3,1);   
    digitalWrite(led4,1);   
    digitalWrite(led5,1);
 delay(d);
}
if(c==0){
   digitalWrite(led1,1);   
    digitalWrite(led2,1);   
    digitalWrite(led3,1);   
    digitalWrite(led4,1);   
    digitalWrite(led5,1);
 delay(d);
  digitalWrite(led1,1);   
    digitalWrite(led2,0);   
    digitalWrite(led3,0);   
    digitalWrite(led4,0);   
    digitalWrite(led5,1);
 delay(d);
    digitalWrite(led1,1);   
    digitalWrite(led2,1);   
    digitalWrite(led3,1);   
    digitalWrite(led4,1);   
    digitalWrite(led5,1);
 delay(d);
}
if(c==69){
   digitalWrite(led1,0);   
    digitalWrite(led2,0);   
    digitalWrite(led3,0);   
    digitalWrite(led4,0);   
    digitalWrite(led5,0);
 delay(d);
  digitalWrite(led1,0);   
    digitalWrite(led2,1);   
    digitalWrite(led3,0);   
    digitalWrite(led4,1);   
    digitalWrite(led5,0);
 delay(d);
    digitalWrite(led1,0);   
    digitalWrite(led2,0);   
    digitalWrite(led3,0);   
    digitalWrite(led4,0);   
    digitalWrite(led5,0);
 delay(d);
}
if(c==96){
   digitalWrite(led1,0);   
    digitalWrite(led2,0);   
    digitalWrite(led3,0);   
    digitalWrite(led4,0);   
    digitalWrite(led5,0);
 delay(d);
  digitalWrite(led1,0);   
    digitalWrite(led2,0);   
    digitalWrite(led3,0);   
    digitalWrite(led4,0);   
    digitalWrite(led5,0);
 delay(d);
    digitalWrite(led1,0);   
    digitalWrite(led2,0);   
    digitalWrite(led3,0);   
    digitalWrite(led4,0);   
    digitalWrite(led5,0);
 delay(d);
}

    digitalWrite(led1,0);   
    digitalWrite(led2,0);   
    digitalWrite(led3,0);   
    digitalWrite(led4,0);   
    digitalWrite(led5,0);
}
int d1=10;
int d2=2;
int time=250;
void loop(void) {
  if(time==0){
    t[3]++;
  }
  if(t[3]>9){
    t[3]=0;
    t[2]++;
  }
  if(t[2]>5){
    t[2]=0;
    t[1]++;
  }
  if(t[0]*10+t[1]==24){
    t[0]=0;
    t[1]=0;
  }
  else if(t[1]>9){
  t[1]=0;
  t[0]++;
  }
  
  
  cyfra(t[0],d2);
  delay(d1);
  cyfra(t[1],d2);
  delay(d1);
  
  if(time%8<4)
    cyfra(69,d2);
  else
    cyfra(96,d2);
    
  delay(d1);
  cyfra(t[2],d2);
  delay(d1);
  cyfra(t[3],d2);


    delay(250-5*d2-5*d1);
  time+=4;
  time = time %(60*4);

}







