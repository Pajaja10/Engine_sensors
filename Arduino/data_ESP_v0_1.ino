//-----------------------------------------------
//---------------ESP-WROOM-32--------------------
//-----------------------------------------------
//-----------------------------------------------

//-----------------------------------------------
// Multiplexer 16 kanálů CD74HC4067--------------

// nastavení ovládacích pinů S0-S3 multiplexeru
const char pinS0 = 27;
const char pinS1 = 14;
const char pinS2 = 25;
const char pinS3 = 26;

// nastavení výstupního pinu SIG multiplexeru
const char pinSIG = 12;

//Proměnné analogu
byte napetiSIG[16];

//-----------------------------------------------
// Termočlánky MAX6675---------------------------

#include "max6675.h"    //knihovna

//nastavení pinů
const int thermoDO  = 15;
const int thermoCLK =  2;
const int thermoCS0 = 35;
const int thermoCS1 = 32;
const int thermoCS2 = 33;
const int thermoCS3 = 34;

MAX6675 thermo0(thermoCLK, thermoCS0, thermoDO);
MAX6675 thermo1(thermoCLK, thermoCS1, thermoDO);
MAX6675 thermo2(thermoCLK, thermoCS2, thermoDO);
MAX6675 thermo3(thermoCLK, thermoCS3, thermoDO);

//Proměnné termočlánku
unsigned int thermo[4];

//-----------------------------------------------
// Bluetooth-------------------------------------
#include <Wire.h>

#include "BluetoothSerial.h"

#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run `make menuconfig` to and enable it
#endif

BluetoothSerial SerialBT;

//-----------------------------------------------
// CAN-bus-------------------------------------

#include <CAN.h>

unsigned char dataCan[4][7];    // 4 řádky se 6 proměnnýma

//-----------------------------------------------
// Interupt-------------------------------------

//nastavení pinů
const char encoder_pin0 = 13;
const char encoder_pin1 = 16;
const char encoder_pin2 = 36;
const char encoder_pin3 = 39;

//čas prvního a posledního pulzu
volatile unsigned int startTime[] = {0,0,0,0};
volatile unsigned int stopTime[] = {0,0,0,0};

//interval aktualizace
volatile const unsigned int updateInterval = 4;

//čítače
volatile unsigned int pulseCount[4] = {0,0,0,0};
volatile static unsigned long last_interrupt_time[] = {0,0,0,0};
volatile unsigned long interrupt_time[4];

//počet pulzů na otáčku
const unsigned int blades = 2;

//spočítané otáčky
unsigned int RPM[4];

int k = 0;

//-----------------------------------------------
// Proměnné pro loop-----------------------------

unsigned long newmillis;
unsigned long oldmillis = 0;
byte randNumber;

//-----------------------------------------------------------------------------------------------------------  
// -----------------SETUP------------------------
  
void setup() {
  //----------------------------------------------- 
  //Multiplexer
  // nastavení ovládacích pinů jako výstupních
  pinMode(pinS0, OUTPUT); 
  pinMode(pinS1, OUTPUT); 
  pinMode(pinS2, OUTPUT); 
  pinMode(pinS3, OUTPUT);
  Wire.begin();

  //max
  //pinMode(thermoCS0, OUTPUT); 
 // pinMode(thermoCS1, OUTPUT); 
 // pinMode(thermoCS2, OUTPUT); 
 // pinMode(thermoCS3, OUTPUT);
  
  //----------------------------------------------- 
  // komunikace po sériové lince rychlostí 9600 baud
  Serial.begin(9600);
  
  //----------------------------------------------- 
  // Bluetooth
  SerialBT.begin("DATA-EA81"); //Bluetooth device name

  //----------------------------------------------- 
  // CAN-bus
  if (!CAN.begin(500E3)) {
    Serial.println("Starting CAN failed!");
    while (1);
  }
  
  //----------------------------------------------- 
  // interrupt
  pinMode(encoder_pin0, INPUT);
  pinMode(encoder_pin1, INPUT);
  pinMode(encoder_pin2, INPUT);
  pinMode(encoder_pin3, INPUT);
  attachInterrupt(digitalPinToInterrupt(encoder_pin0), intcounter0, HIGH);
  attachInterrupt(digitalPinToInterrupt(encoder_pin1), intcounter1, HIGH);
  attachInterrupt(digitalPinToInterrupt(encoder_pin2), intcounter2, HIGH);
  attachInterrupt(digitalPinToInterrupt(encoder_pin3), intcounter3, HIGH);
}
//------------------------------------------------------------------------------------------------------------
// -----------------LOOP-------------------------

void loop() {
  newmillis = millis();
  counter();
  nactiAnalog();
  for (int i = 0; i<4; i++){
    for (int j = 0; j<7; j++) {
      dataCan[i][j] = napetiSIG[j];
    }
  }
  // Nacitani sensorů
  if (newmillis - oldmillis > 200 ) {
     for (int i=0; i<1; i++){
     canSender(i);
     }
    nactiThermo();
    tiskni();
    tiskniBT();
    //for (int i = 0; i<7; i++){
      //dataCan[0][i] = napetiSIG[i];
    //}
    //canSender(0);
    oldmillis = millis();
    }

    
 

  
  
  //canSender(0);

}

//-------------------------------------------------------------------------------------------------------------
// ---------------načítání analogu---------------

int nactiAnalog(){
  // pomocné pole s ovládacími piny pro jejich nastavení
  int ovladaciPiny[] = {pinS0, pinS1, pinS2, pinS3};
  // tabulka všech možných kombinací ovládacích pinů
  int kanaly[16][4]={
    {0,0,0,0},  // kanál  0
    {1,0,0,0},  // kanál  1
    {0,1,0,0},  // kanál  2
    {1,1,0,0},  // kanál  3
    {0,0,1,0},  // kanál  4
    {1,0,1,0},  // kanál  5
    {0,1,1,0},  // kanál  6
    {1,1,1,0},  // kanál  7
    {0,0,0,1},  // kanál  8
    {1,0,0,1},  // kanál  9
    {0,1,0,1},  // kanál 10
    {1,1,0,1},  // kanál 11
    {0,0,1,1},  // kanál 12
    {1,0,1,1},  // kanál 13
    {0,1,1,1},  // kanál 14
    {1,1,1,1}   // kanál 15
  };
  // nastavení kombinace ovládacích pinů
  // pomocí smyčky for
  for (int i = 0; i < 16; i ++){
    for (int j = 0; j < 4; j ++){
     digitalWrite(ovladaciPiny[j], kanaly[i][j]);
    }
    // načtení analogové hodnoty z pinu SIG
    napetiSIG[i] = analogRead(pinSIG);
  }
}
//-----------------------------------------------
// ---------------tisk do serialu----------------


void tiskni(){
  //Serial.println("Tisknu data");
  
  //analog-multiplexer
  for (int i = 0; i < 16; i++){
    Serial.print(napetiSIG[i]);
    Serial.print(",");
  }
  
  //termočlánky
  for (int i = 0; i < 4; i++){
    //Serial.print(thermo[i]);
    //Serial.print(",");
  }
  //counter
  for (int i = 0; i < 4; i++){
    //Serial.print(RPM[i]);
    if (i != 4) Serial.print(",");
  }
  Serial.println();
}

//-----------------------------------------------
// -------------tisk do serialuBT----------------


void tiskniBT(){
  SerialBT.println("Tisknu data");
  
  //analog-multiplexer
  for (int i = 0; i < 16; i++){
    SerialBT.print(napetiSIG[i]);
    SerialBT.print(",");
  }
  
  //termočlánky
  for (int i = 0; i < 4; i++){
    SerialBT.print(thermo[i]);
    if (i != 4) SerialBT.print(",");
  }
  SerialBT.println();
}


//-----------------------------------------------
// -----------načítání termočlánků---------------

void nactiThermo(){
  thermo[0] = (thermo0.readCelsius()/0.25);
  thermo[1] = (thermo1.readCelsius()/0.25);
  thermo[2] = (thermo2.readCelsius()/0.25);
  thermo[3] = (thermo3.readCelsius()/0.25);
}


//-----------------------------------------------
// -----------posílání CAN-BUS-------------------

void canSender(int c){
  //Serial.println(c);
  CAN.beginPacket(0x12,8);
  //CAN.write('$');
  CAN.write(c);
  for(int i=0; i<7; i++){
    CAN.write(dataCan[c][i]);
    //Serial.println(dataCan[c][i]);
  }
  CAN.endPacket();
}


//-----------------------------------------------
// ----------------interrupt---------------------
void intcounter0(){
  //Update count
  interrupt_time[0] = millis();
  if (interrupt_time[0] - last_interrupt_time[0] > 10) {
    pulseCount[0]++;
    if (pulseCount[0] == 1) {startTime[0] = millis(); stopTime[0] = 0;}       //pokud první načti start, vynuluj stop
    if (pulseCount[0] == updateInterval) stopTime[0] = millis();           //pokud např 4x poslední načti stop
    last_interrupt_time[0] = interrupt_time[0];
  }
  
  }

void intcounter1(){
  //Update count
  interrupt_time[1] = millis();
  if (interrupt_time[1] - last_interrupt_time[1] > 10) {
    pulseCount[1]++;
    if (pulseCount[1] == 1) {startTime[1] = millis(); stopTime[1] = 0;}       //pokud první načti start, vynuluj stop
    if (pulseCount[1] == updateInterval) stopTime[1] = millis();           //pokud např 4x poslední načti stop
    last_interrupt_time[1] = interrupt_time[1];
  }
  
  }void intcounter2(){
  //Update count
  interrupt_time[2] = millis();
  if (interrupt_time[2] - last_interrupt_time[2] > 10) {
    pulseCount[2]++;
    if (pulseCount[2] == 1) {startTime[2] = millis(); stopTime[2] = 0;}       //pokud první načti start, vynuluj stop
    if (pulseCount[2] == updateInterval) stopTime[2] = millis();           //pokud např 4x poslední načti stop
    last_interrupt_time[2] = interrupt_time[2];
  }
  
  }void intcounter3(){
  //Update count
  interrupt_time[3] = millis();
  if (interrupt_time[3] - last_interrupt_time[3] > 10) {
    pulseCount[3]++;
    if (pulseCount[3] == 1) {startTime[3] = millis(); stopTime[3] = 0;}       //pokud první načti start, vynuluj stop
    if (pulseCount[3] == updateInterval) stopTime[0] = millis();           //pokud např 4x poslední načti stop
    last_interrupt_time[3] = interrupt_time[3];
  }
  
  }

void counter(){
  for (int i = 0; i < 4; i++){
    if (stopTime[i] != 0) {
      RPM[i]= ((stopTime[i]- startTime[i]) / (updateInterval-1) * blades); 
      pulseCount[i] = 0;
    }
  }
}
