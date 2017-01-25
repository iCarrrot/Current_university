#include <Tone.h>

Tone freq1;
Tone freq2;
//                           0     1     2     3     4     5     6     7     8     9    *,10  #,11  A,12  B,13  C,14  D,15
const int DTMF_freq1[] = { 1336, 1209, 1336, 1477, 1209, 1336, 1477, 1209, 1336, 1477,  1209, 1477, 1633, 1633, 1633, 1633 };
const int DTMF_freq2[] = {  941,  697,  697,  697,  770,  770,  770,  852,  852,  852,  941,  941,  697,  770,  852,  941  };

const int TONE_LENGTH = 500;     // Min 40 for detection on LED (ms)
const int TONE_WAIT = 550;       // This is how long to wait after triggering a DTMF call (ms)
const int TONE_LOOP_WAIT = 0; // Wait this long after loop (ms)

/* BEST DURING ANALYSIS / TUNING
const int TONE_LENGTH = 17;     // Min 40 for detection on LED (ms)
const int TONE_WAIT = 20;       // This is how long to wait after triggering a DTMF call (ms)
*/

void setup()
{
  Serial.begin(9600);
  freq1.begin(11);
  freq2.begin(12);
}

void playDTMF(uint8_t number, long duration)
{
  freq1.play(DTMF_freq1[number], duration);
  freq2.play(DTMF_freq2[number], duration);
}


void loop()
{
  String numer = "";
 
    if (Serial.available() > 0) {  
        numer = Serial.readStringUntil('\n');  
    }
   if (numer.length()>0){
     for(int i=0; i<numer.length();i++){
       uint8_t cyfra=0;
       if(numer[i]=='*'){
         cyfra=10;
         //Serial.println(cyfra);
       }
       else if (numer[i]=='#'){
         cyfra=11;
       }
       else{
         cyfra=numer[i] - 48;
       }
       playDTMF(cyfra, TONE_LENGTH);
       Serial.print(cyfra);
       Serial.print(" ");
       delay(TONE_WAIT);

     }
     Serial.print("\n");
     
   }
}

