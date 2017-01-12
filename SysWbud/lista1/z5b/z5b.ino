int led1 = 44;  
int led2 = 46;  
int led3 = 38;  
int led4 = 50;  
int led5 = 52;  

void setup(void) {
  Serial.begin(9600);  
  pinMode(led3, OUTPUT);

}
void loop(void) {

    digitalWrite(led1,120);   
    digitalWrite(led2,120);   
    digitalWrite(led3,255);   
    digitalWrite(led4,120);   
    digitalWrite(led5,255);   


}







