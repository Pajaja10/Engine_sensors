//-----------------------------------------------
//---------------ESP-WROOM-32--------------------
//-----------------------------------------------
//-----------------------------------------------
/*
//--------------WIFI updater------------------------
// IP: 192.168.1.130

#include <WiFi.h>
#include <WiFiClient.h>
#include <WebServer.h>
#include <ESPmDNS.h>
#include <Update.h>

const char* host = "esp32";
const char* ssid = "u_nas_doma";
const char* password = "asdf1234";

WebServer server(80);


const char* loginIndex =
 "<form name='loginForm'>"
    "<table width='20%' bgcolor='A09F9F' align='center'>"
        "<tr>"
            "<td colspan=2>"
                "<center><font size=4><b>ESP32 Login Page</b></font></center>"
                "<br>"
            "</td>"
            "<br>"
            "<br>"
        "</tr>"
        "<tr>"
             "<td>Username:</td>"
             "<td><input type='text' size=25 name='userid'><br></td>"
        "</tr>"
        "<br>"
        "<br>"
        "<tr>"
            "<td>Password:</td>"
            "<td><input type='Password' size=25 name='pwd'><br></td>"
            "<br>"
            "<br>"
        "</tr>"
        "<tr>"
            "<td><input type='submit' onclick='check(this.form)' value='Login'></td>"
        "</tr>"
    "</table>"
"</form>"
"<script>"
    "function check(form)"
    "{"
    "if(form.userid.value=='admin' && form.pwd.value=='admin')"
    "{"
    "window.open('/serverIndex')"
    "}"
    "else"
    "{"
    " alert('Error Password or Username')"
    "}"
    "}"
"</script>";



const char* serverIndex =
"<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>"
"<form method='POST' action='#' enctype='multipart/form-data' id='upload_form'>"
   "<input type='file' name='update'>"
        "<input type='submit' value='Update'>"
    "</form>"
 "<div id='prg'>progress: 0%</div>"
 "<script>"
  "$('form').submit(function(e){"
  "e.preventDefault();"
  "var form = $('#upload_form')[0];"
  "var data = new FormData(form);"
  " $.ajax({"
  "url: '/update',"
  "type: 'POST',"
  "data: data,"
  "contentType: false,"
  "processData:false,"
  "xhr: function() {"
  "var xhr = new window.XMLHttpRequest();"
  "xhr.upload.addEventListener('progress', function(evt) {"
  "if (evt.lengthComputable) {"
  "var per = evt.loaded / evt.total;"
  "$('#prg').html('progress: ' + Math.round(per*100) + '%');"
  "}"
  "}, false);"
  "return xhr;"
  "},"
  "success:function(d, s) {"
  "console.log('success!')"
 "},"
 "error: function (a, b, c) {"
 "}"
 "});"
 "});"
 "</script>";
//---------------------------------------------------------
*/

//-----------------------------------------------
// Multiplexer 16 kanálů CD74HC4067--------------

// nastavení ovládacích pinů S0-S3 multiplexeru
#include <ESP32AnalogRead.h>
ESP32AnalogRead adc; //potlačení nelinearity

const unsigned char pinS0 = 27;
const unsigned char pinS1 = 14;
const unsigned char pinS2 = 25;
const unsigned char pinS3 = 26;

// nastavení výstupního pinu SIG multiplexeru
const unsigned char pinSIG = 12;

//Proměnné analogu
float napetiSIG[16];
float hodnotaAnalog[16];

//teplota:
#include <math.h>

//const float beta = 3997.3; //the beta of the thermistor
//const float RT = 10000; //the value of the pull-down resistor
//const float RT0 = 15;
//const float T0 = 273.15;

//-----------------------------------------------
// Termočlánky MAX6675---------------------------

#include "max6675.h"    //knihovna

//nastavení pinů
const unsigned char thermoDO  = 15;
const unsigned char thermoCLK =  2;
//const int thermoCS0 = 35;   // bohužel mám  na input only!!!!! takže neumí vypnout
const unsigned char thermoCS1 = 32;
const unsigned char thermoCS2 = 33;
//const int thermoCS3 = 34;   // bohužel mám  na input only!!!!! takže neumí vypnout

//MAX6675 thermo0(thermoCLK, thermoCS0, thermoDO);
MAX6675 thermo1(thermoCLK, thermoCS1, thermoDO);
MAX6675 thermo2(thermoCLK, thermoCS2, thermoDO);
//MAX6675 thermo3(thermoCLK, thermoCS3, thermoDO);

//Proměnné termočlánku
int thermo[2];

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

//-----------------------------------------
//----BMP280------------------------------

#include <Adafruit_BMP280.h>
#include <Adafruit_Sensor.h>
#define BMP280_ADRESA (0x76)
Adafruit_BMP280 bmp;
float teplota;

//-----------------------------------------------
// Proměnné pro loop-----------------------------

unsigned long newmillis;
unsigned long oldmillis = 0;


//-----------------------------------------------------------------------------------------------------------  
// -----------------SETUP------------------------
  
void setup() {
  //----------------------------------------------- 
  // komunikace po sériové lince rychlostí 9600 baud, spuštění I2C
  Serial.begin(9600);
  Wire.begin();
 
  /*//-------------WIFI updater-------------------------
  // Connect to WiFi network
  WiFi.begin(ssid, password);
  Serial.println("");

  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

 
  if (!MDNS.begin(host)) { //http://esp32.local
    Serial.println("Error setting up MDNS responder!");
    while (1) {
      delay(1000);
    }
  }
  Serial.println("mDNS responder started");

  server.on("/", HTTP_GET, []() {
    server.sendHeader("Connection", "close");
    server.send(200, "text/html", loginIndex);
  });
  server.on("/serverIndex", HTTP_GET, []() {
    server.sendHeader("Connection", "close");
    server.send(200, "text/html", serverIndex);
  });

  server.on("/update", HTTP_POST, []() {
    server.sendHeader("Connection", "close");
    server.send(200, "text/plain", (Update.hasError()) ? "FAIL" : "OK");
    ESP.restart();
  }, []() {
    HTTPUpload& upload = server.upload();
    if (upload.status == UPLOAD_FILE_START) {
      Serial.printf("Update: %s\n", upload.filename.c_str());
      if (!Update.begin(UPDATE_SIZE_UNKNOWN)) { //start with max available size
        Update.printError(Serial);
      }
    } else if (upload.status == UPLOAD_FILE_WRITE) {

      if (Update.write(upload.buf, upload.currentSize) != upload.currentSize) {
        Update.printError(Serial);
      }
    } else if (upload.status == UPLOAD_FILE_END) {
      if (Update.end(true)) { //true to set the size to the current progress
        Serial.printf("Update Success: %u\nRebooting...\n", upload.totalSize);
      } else {
        Update.printError(Serial);
      }
    }
  });
  server.begin();
*/
  //------------------------------------------------------
  //Multiplexer
  // nastavení ovládacích pinů jako výstupních
  pinMode(pinS0, OUTPUT); 
  pinMode(pinS1, OUTPUT); 
  pinMode(pinS2, OUTPUT); 
  pinMode(pinS3, OUTPUT);
  adc.attach(pinSIG);
  
  

  //----------------------------------------------- 
  // Bluetooth
  SerialBT.begin("DATA-EA81"); //Bluetooth device name

  //----------------------------------------------- 
  // CAN-bus
  if (!CAN.begin(500E3)) {
    Serial.println("Starting CAN failed!");
    while (1);
  }
 //-------------------------------------------------
 //BMP280
 bmp.begin(BMP280_ADRESA);

}
//------------------------------------------------------------------------------------------------------------
// -----------------LOOP-------------------------

void loop() {
  //-----------------WIFi updaret-------------
 /* server.handleClient();
  delay(1);*/
  //----------------------
  
  newmillis = millis(); // začátek cyklu
 
  // Nacitani sensorů
  if (newmillis - oldmillis > 250 ) {
    nactiThermo();
    teplota = bmp.readTemperature();
    nactiAnalog();
    upravaDat();
    tiskniBT();
    oldmillis = millis();
    }


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
    napetiSIG[i] = String(adc.readVoltage()).toFloat();
    SerialBT.println(napetiSIG[i]+10);
  }
}

//-----------------------------------------Uprava dat------------------------------

void upravaDat() {
  for (int i = 0; i < 16; i ++){
    if ( i == 0) {hodnotaAnalog[i] = napetiSIG[i]* 3.3 * 5 /4095 ;}
    if (i > 0 && i < 5) { hodnotaAnalog[i] = napetiSIG[i] * 3.3/4095 + 0.1;      // ESP má problém od 0, začíná od 0,1 do 3,2; realne napeti na pinu
                          hodnotaAnalog[i] = hodnotaAnalog[i] * 220 / (3.3 - hodnotaAnalog[i]);    //obyč dělič napětí, výstup odpor na čidle, pull-up 10k POZOR dal jsem 220R
                          //hodnotaAnalog[i] = 418.47 * pow(hodnotaAnalog[i], -0.364);   //rovnice dle excel - celá křivka
                          hodnotaAnalog[i] = -32.89 * log(hodnotaAnalog[i]) + 231.58;  //rovnice dle excel - pouze část křivky kolem 100°C
                   }
    }
}
//-----------------------------------------------
// ---------------tisk do serialu----------------


void tiskni(){
  //Serial.println("Tisknu data");
  
  //analog-multiplexer
  for (int i = 0; i < 3; i++){
    Serial.print(hodnotaAnalog[i]);
    Serial.print(",");
  }
    Serial.println();

  for (int i = 0; i < 3; i++){
    Serial.print(napetiSIG[i]);
    Serial.print(",");
  }
    Serial.println(); 
  //termočlánky
  for (int i = 0; i < 4; i++){
    Serial.print(thermo[i]);
    Serial.print(",");
  }
  /*/counter
  for (int i = 0; i < 4; i++){
    //Serial.print(RPM[i]);
    if (i != 4) Serial.print(",");
  }*/
  Serial.println();
}

//-----------------------------------------------
// -------------tisk do serialuBT----------------


void tiskniBT(){
 //BMP280
  SerialBT.println("----------Tisknu data:---------------");
  SerialBT.print("Vnitřní teplota: ");
  SerialBT.print(teplota);
  SerialBT.println("°C");
 
 //termočlánky
  SerialBT.print("Teplota termočlánků: ");
  for (int i = 0; i < 2; i++){
    SerialBT.print(thermo[i]);
    if (i != 1) SerialBT.print(",");
  }
  SerialBT.println();
 
  //Napětí baterky
  SerialBT.print("Napětí baterky: ");
  SerialBT.print(hodnotaAnalog[0]);
  SerialBT.println("V");
 
  
  //Teploty-multiplexer
  SerialBT.print("Teplota VDO: ");
  for (int i = 1; i < 5; i++){
    SerialBT.print(hodnotaAnalog[i]);
    if (i != 4) SerialBT.print(",");
  }
  SerialBT.println();
 /*
 //Hladiny-multiplexer
  SerialBT.print("Hladina: ");
  for (int i = 5; i < 7; i++){
    SerialBT.print(hodnotaAnalog[i]);
    if (i != 6) SerialBT.print(",");
  }
  SerialBT.println();
 */
}


//-----------------------------------------------
// -----------načítání termočlánků---------------

void nactiThermo(){
  //thermo[0] = (thermo0.readCelsius()/0.25);
  thermo[0] = (thermo1.readCelsius());
  thermo[1] = (thermo2.readCelsius());
  //thermo[3] = (thermo3.readCelsius()/0.25);
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
