int led3 = 9;  
const int minBut = 2; 
int s=100;
int list[100];
int var=0;
int Case=-1;
int licznik=0;
int czas=1;
int fst=1;
int wait=0;
int wait2=0;
int op=1500;
void setup(void) {
  Serial.begin(9600);  
  pinMode(led3, OUTPUT);
  pinMode(minBut, INPUT);
}
void loop(void) {
  if (fst){
    fst=0;
    for(int i=0;i<s;i++){
      list[i]=0;
    }
  }
  if(digitalRead(minBut)==HIGH)
    wait=1;
  if(digitalRead(minBut)==HIGH)
    wait2=1;
  else
    wait2=0;
  if((list[licznik]<(op/czas)||wait2==1) && wait){
    Case=digitalRead(minBut)+var;
   // Serial.print(Case);
    switch (Case){
    case 0:
    case 3:
      licznik++;
      var=2-var;
    case 1:
    case 2:
      list[licznik]++;
     // Serial.print(" ");
     // Serial.println(list[licznik]);
      delay(czas);
      break;
    }
  }
  else if (wait){
    list[licznik]=0;
    for(int i=0;i<s;i++){
     // Serial.print("i: ");
     // Serial.print(i);
     // Serial.print(" list[i]: ");
    //  Serial.println(list[i]);
      while(list[i]>0 && i%2==0){
        analogWrite(led3, 255);
        delay(czas);
        list[i]--;
      }
      if (list[i]==0)
        analogWrite(led3, 0);
      while(list[i]>0 && i%2==1){
        analogWrite(led3, 0);
        delay(czas);
        list[i]--;
      }
    }
    licznik=0;
    var=0;

    for(int i=0;i<s;i++){
      list[i]=0;
    }
    wait=0;
  }
}







