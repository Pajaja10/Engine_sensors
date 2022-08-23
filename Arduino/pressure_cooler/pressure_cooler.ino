int tlakPin = 4;

int tlakRaw = 0;
float tlakV = 0;
float tlakOhm = 0;
float tlak = 0;


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:

  tlakRaw = analogRead(tlakPin);   //převodník
  tlakV = tlakRaw * 3.3 / 4095 ;     // realne napeti na pinu, ESP neumí od 0 ale od 0,1
  //teplotaOhm = teplotaV * 220 / (3.3 - teplotaV);// odpor čidla

  //***********rovnice dle excel, 2 typy, cela křivka + kolem 100°C 

  // nastavení kolem 100 dává super hodnotu, doma asi 25, na vástupu asi 22, ta první 44
  //teplota1 = 418.47 * pow(teplotaOhm, -0.364);   //rovnice dle excel - celá křivka


  Serial.print( "Teplota: ");  Serial.print( tlakRaw); Serial.print( " "); 
  Serial.print( tlakV); Serial.println( " V, "); 
  //Serial.print( teplotaOhm); Serial.print( " Ohm, "); 
  //Serial.print( teplota1); Serial.print( " stupne, ");
  //Serial.print( teplota2); Serial.println( " stupne ");

  delay(500);
}
