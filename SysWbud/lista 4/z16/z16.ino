/** 
 * ****************************************************** *
 * Arduino Knight Rider - Leds & Theme                    *
 * Gamboa <gamboa AT_NO_SPAM pdvel.com>                   *
 * First Arduino project (Yeah this is a disclaimer :P)   *
 * ****************************************************** *
 */


#define NOTE_B0  31
#define NOTE_C1  33
#define NOTE_CS1 35
#define NOTE_D1  37
#define NOTE_DS1 39
#define NOTE_E1  41
#define NOTE_F1  44
#define NOTE_FS1 46
#define NOTE_G1  49
#define NOTE_GS1 52
#define NOTE_A1  55
#define NOTE_AS1 58
#define NOTE_B1  62
#define NOTE_C2  65
#define NOTE_CS2 69
#define NOTE_D2  73
#define NOTE_DS2 78
#define NOTE_E2  82
#define NOTE_F2  87
#define NOTE_FS2 93
#define NOTE_G2  98
#define NOTE_GS2 104
#define NOTE_A2  110
#define NOTE_AS2 117
#define NOTE_B2  123
#define NOTE_C3  131
#define NOTE_CS3 139
#define NOTE_D3  147
#define NOTE_DS3 156
#define NOTE_E3  165
#define NOTE_F3  175
#define NOTE_FS3 185
#define NOTE_G3  196
#define NOTE_GS3 208
#define NOTE_A3  220
#define NOTE_AS3 233
#define NOTE_B3  247
#define NOTE_C4  262
#define NOTE_CS4 277
#define NOTE_D4  294
#define NOTE_DS4 311
#define NOTE_E4  330
#define NOTE_F4  349
#define NOTE_FS4 370
#define NOTE_G4  392
#define NOTE_GS4 415
#define NOTE_A4  440
#define NOTE_AS4 466
#define NOTE_B4  494
#define NOTE_C5  523
#define NOTE_CS5 554
#define NOTE_D5  587
#define NOTE_DS5 622
#define NOTE_E5  659
#define NOTE_F5  698
#define NOTE_FS5 740
#define NOTE_G5  784
#define NOTE_GS5 831
#define NOTE_A5  880
#define NOTE_AS5 932
#define NOTE_B5  988
#define NOTE_C6  1047
#define NOTE_CS6 1109
#define NOTE_D6  1175
#define NOTE_DS6 1245
#define NOTE_E6  1319
#define NOTE_F6  1397
#define NOTE_FS6 1480
#define NOTE_G6  1568
#define NOTE_GS6 1661
#define NOTE_A6  1760
#define NOTE_AS6 1865
#define NOTE_B6  1976
#define NOTE_C7  2093
#define NOTE_CS7 2217
#define NOTE_D7  2349
#define NOTE_DS7 2489
#define NOTE_E7  2637
#define NOTE_F7  2794
#define NOTE_FS7 2960
#define NOTE_G7  3136
#define NOTE_GS7 3322
#define NOTE_A7  3520
#define NOTE_AS7 3729
#define NOTE_B7  3951
#define NOTE_C8  4186
#define NOTE_CS8 4435
#define NOTE_D8  4699
#define NOTE_DS8 4978

/* NOTES AND TONES */
const int pinTone = 8;

typedef struct {
  int note;
  int tempo;
} notesType;

const notesType aNotes[] = {
    // 1
    {NOTE_A4, 250}, {NOTE_AS4, 125}, {NOTE_A4, 125}, 
    {NOTE_A4, 125}, {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_GS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_A4, 250}, {NOTE_AS4, 125}, {NOTE_A4, 125}, 
    {NOTE_A4, 125}, {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_GS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_G4, 250}, {NOTE_GS4, 125}, {NOTE_G4, 125}, 
    {NOTE_G4, 125}, {NOTE_GS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    {NOTE_GS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    {NOTE_FS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    {NOTE_G4, 250}, {NOTE_GS4, 125}, {NOTE_G4, 125}, 
    {NOTE_G4, 125}, {NOTE_GS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    {NOTE_GS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    {NOTE_FS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    // 2
    {NOTE_A4, 250}, {NOTE_AS4, 125}, {NOTE_A4, 125}, 
    {NOTE_A4, 125}, {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_GS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_A4, 250}, {NOTE_AS4, 125}, {NOTE_A4, 125}, 
    {NOTE_A4, 125}, {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_GS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_G4, 250}, {NOTE_GS4, 125}, {NOTE_G4, 125}, 
    {NOTE_G4, 125}, {NOTE_GS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    {NOTE_GS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    {NOTE_FS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    {NOTE_G4, 250}, {NOTE_GS4, 125}, {NOTE_G4, 125}, 
    {NOTE_G4, 125}, {NOTE_GS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    {NOTE_GS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    {NOTE_FS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    // 3
    {NOTE_A4, 250}, {NOTE_AS4, 125}, {NOTE_A4, 125}, 
    {NOTE_A4, 125}, {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_GS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_A4, 250}, {NOTE_AS4, 125}, {NOTE_A4, 125}, 
    {NOTE_A4, 125}, {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_GS4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, {NOTE_A4, 125}, 
    {NOTE_G4, 250}, {NOTE_GS4, 125}, {NOTE_G4, 125}, 
    {NOTE_G4, 125}, {NOTE_GS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    {NOTE_GS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    {NOTE_FS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    {NOTE_G4, 250}, {NOTE_GS4, 125}, {NOTE_G4, 125}, 
    {NOTE_G4, 125}, {NOTE_GS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    {NOTE_GS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    {NOTE_FS4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, {NOTE_G4, 125}, 
    // solo 
    {NOTE_A4, 250}, {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_E5, 1500}, 
    {NOTE_A5, 250}, {NOTE_AS5, 125}, {NOTE_A5, 125}, {NOTE_E5, 1500}, 
    {NOTE_A4, 250}, {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_E5, 250}, {NOTE_A5, 250}, {NOTE_G5, 2000}, 
    {NOTE_A4, 250}, {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_E5, 1500}, 
    {NOTE_A5, 250}, {NOTE_AS5, 125}, {NOTE_A5, 125}, {NOTE_E5, 1500}, 
    {NOTE_A4, 250}, {NOTE_AS4, 125}, {NOTE_A4, 125}, {NOTE_E5, 250}, {NOTE_A5, 250}, {NOTE_AS5, 2500}, {NOTE_G5, 250}, {NOTE_A5, 500}
};

int noteIndex = -1;
int totalNotes;

unsigned long tonePrevTime = 0;
int noteDelay = aNotes[(noteIndex + 1)].tempo;


/* LEDS */
const int pinLed[] = {3, 5, 6, 9, 10, 11}; /* PWM pins */

int ledIndex = -2;
int ledOrder = 1;
const int ledHighValue = 255; /* not used */
const int ledFadeValue = 70;
const int ledOffValue = 0; /* not used */
int totalLeds;

unsigned long ledPrevTime = 0;
const int ledDelay = 125;

unsigned long curTime = 0; 

/* CONTROLER/SWITCH */
int pinControlOut = 13;
int pinControlIn = 12;
int controlDelay = 1000;
unsigned long controlPrevTime = 0;
int isLedControlerOn = 0;

int _playLed = 0;
int _playNote = 0;

/* SETUP */
void setup() {
    
    pinMode(pinTone, OUTPUT); 
    pinMode(pinControlOut, OUTPUT);
    pinMode(pinControlIn, INPUT);

    digitalWrite(pinControlOut, HIGH);
    isLedControlerOn = 1;

    resetLeds(1);

    totalLeds = sizeof(pinLed) / sizeof(int); 
    totalNotes = sizeof(aNotes) / sizeof(notesType); 
}

/* LOOP */
void loop() {

    //unsigned long curTime = millis();
    curTime = millis();
  
    /* CONTROLER/SWITCH */
    if(curTime - controlPrevTime > controlDelay) {
        controlPrevTime = curTime;
        if(digitalRead(pinControlIn) == HIGH) {
            if(isLedControlerOn == 1) {
                digitalWrite(pinControlOut, LOW);
                isLedControlerOn = 0;
                _playLed = 1;
                _playNote = 1;
            } else {
                digitalWrite(pinControlOut, HIGH);
                isLedControlerOn = 1;
                resetLeds(0);
                resetTones();
            }
        }
    }

    /* LEDS */
    if(curTime - ledPrevTime > ledDelay && _playLed == 1) { 
        ledPrevTime = curTime;

        if(ledIndex > -2 && ledIndex < (totalLeds - 1)) { 
            if(pinLed[(ledIndex + 1)] == 11 || pinLed[(ledIndex + 1)] == 3) { // hack to tone() & analogWrite on pin 3 & 11
                digitalWrite(pinLed[(ledIndex + 1)], HIGH);
            } else {
                analogWrite(pinLed[(ledIndex + 1)], ledFadeValue);
            }
            //analogWrite(pinLed[(ledIndex + 1)], ledFadeValue);
        }
        if(ledIndex > -1 && ledIndex <  totalLeds) {
            //analogWrite(pinLed[ledIndex], ledHighValue);
            digitalWrite(pinLed[ledIndex], HIGH);
        }
        if(ledIndex > 0 && ledIndex < (totalLeds + 1)) { 
            if(pinLed[(ledIndex - 1)] == 11 || pinLed[(ledIndex - 1)] == 3) { // hack to tone() & analogWrite on pin 3 & 11
                digitalWrite(pinLed[(ledIndex - 1)], HIGH);
            } else {
                analogWrite(pinLed[(ledIndex - 1)], ledFadeValue);
            }
            //analogWrite(pinLed[(ledIndex - 1)], ledFadeValue);
        }
        if(ledOrder == 1 && ledIndex > 1 && ledIndex < (totalLeds + 2)) { 
            //analogWrite(pinLed[(ledIndex - 2)], ledOffValue);
            digitalWrite(pinLed[(ledIndex - 2)], LOW);
        } else if(ledOrder == -1 && ledIndex > -3 && ledIndex < (totalLeds - 2)) { 
            //analogWrite(pinLed[(ledIndex + 2)], ledOffValue);
            digitalWrite(pinLed[(ledIndex + 2)], LOW);
        }

        ledIndex += ledOrder;

        if(ledIndex == (totalLeds + 2) && ledOrder == 1) {
            ledOrder = -1;
        } else if(ledIndex == -3 && ledOrder == -1){
            ledOrder = 1;
        }
    }
  
  
    /* NOTES AND TONES */ 
    if(curTime - tonePrevTime >= noteDelay && _playNote == 1) {
        noteIndex++;
        tonePrevTime = curTime;
        noTone(pinTone);
        tone(pinTone, aNotes[noteIndex].note, aNotes[noteIndex].tempo);

        noteDelay = aNotes[noteIndex].tempo;

        if(noteIndex >= totalNotes) {
            noteIndex = -1;
            noteDelay = 10;
        }
    }
  
} 

/**
 * Reset or init leds 
 */
void resetLeds(int setPinMode) {
    int i;
    _playLed = 0;
    for(i=0; i < (sizeof(pinLed) / sizeof(int)); i++) {
        if(setPinMode == 1) {
            pinMode(pinLed[i], OUTPUT);
        }
        //analogWrite(pinLed[i], 0);
        digitalWrite(pinLed[i], LOW);
    }
    ledIndex = -2;
    ledOrder = 1;
}

/**
 * Reset tones 
 */
void resetTones() {
    _playNote = 0;
    noteIndex = -1;
    noteDelay = aNotes[(noteIndex + 1)].tempo;
} 


