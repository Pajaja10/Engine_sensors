//**************TEMP COOLER*************
// pull-up 10k

/*
37.8℃ — 450 ±45 Ohm
104.4℃ — 46.6 ±2.3 Ohm
100℉ — 450.0 ±45.0 Ohm
150℉ — 158.20 ±15.82 Ohm
200℉ — 64.30 ±6.43 Ohm
250℉ — 29.25 ±2.93 Ohm
300℉ — 14.96 ±2.25 Ohm
*/

#include <math.h> 

int teplotniPin = 4;
int napetiPin = 2;

int teplotaRaw = 0;
float teplotaV = 0;
float teplotaOhm = 0;
float teplota1 = 0;
float teplota2 = 0;

int napetiRaw = 0;
float napetiV = 0;

void setup() {
  Serial.begin(9600);
  //analogReference(EXTERNAL);
  
 
}

void loop() {

  teplotaRaw = analogRead(teplotniPin);   //převodník
  teplotaV = teplotaRaw * 3.3 / 4095 ;     // realne napeti na pinu, ESP neumí od 0 ale od 0,1
  teplotaOhm = teplotaV * 220 / (3.3 - teplotaV);// odpor čidla

  //***********rovnice dle excel, 2 typy, cela křivka + kolem 100°C 

  // nastavení kolem 100 dává super hodnotu, doma asi 25, na vástupu asi 22, ta první 44
  teplota1 = 418.47 * pow(teplotaOhm, -0.364);   //rovnice dle excel - celá křivka
  teplota2 = -32.89 * log(teplotaOhm) + 231.58;  //rovnice dle excel - pouze část křivky kolem 100°C 

  Serial.print( "Teplota: ");  Serial.print( teplotaRaw); Serial.print( " "); 
  Serial.print( teplotaV); Serial.print( " V, "); 
  Serial.print( teplotaOhm); Serial.print( " Ohm, "); 
  Serial.print( teplota1); Serial.print( " stupne, ");
  Serial.print( teplota2); Serial.println( " stupne ");



  napetiRaw = analogRead(napetiPin);
  napetiV = napetiRaw * 3.3 / 4095;

  Serial.print( "Napeti: ");  Serial.print( napetiRaw); Serial.print( " "); Serial.println( napetiV);
  
                    //hodnotaAnalog[i] = 418.47 * pow(hodnotaAnalog[i], -0,364);   //rovnice dle excel - celá křivka
                    //hodnotaAnalog[i] = -32.89 * log(hodnotaAnalog[i]) + 231,58;  //rovnice dle excel - pouze část křivky kolem 100°C
  delay(200);
}
