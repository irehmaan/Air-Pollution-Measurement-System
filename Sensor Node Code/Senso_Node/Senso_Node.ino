#include <WiFi.h>
#include <HTTPClient.h>
#include<DHT.h>
#include <MQ135.h>
#include <Adafruit_BMP085.h>
#include <ArduinoJson.h>
// DHT11 configurations
#define DHTPIN 19
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);

//MQ135 config.
//MQ135 mq(34);

// BMP180 config
Adafruit_BMP085 bmp;

const char* ssid = "JioFiber_4G";
const char* password = "Playgod@98";


//Your Domain name with URL path or IP address with path
String serverName = "http://192.168.29.77:5000/receive_data";

// the following variables are unsigned longs because the time, measured in
// milliseconds, will quickly become a bigger number than can be stored in an int.
unsigned long lastTime = 0;
// Timer set to 10 minutes (600000)
//unsigned long timerDelay = 600000;
// Set timer to 5 seconds (5000)
unsigned long timerDelay = 5000;
unsigned long datacollectionlastTime = 0;
unsigned long datacollectiondelay = 5000;



struct SensorsData {
  int temp;
  float humidity;
  float pressure;
  float ppm;
  int altitude;
  int seaLevelPressure;
  int realAltitude;
}; 

 SensorsData readSensors() {
  SensorsData sen;
  // read DHT11
  sen.temp = dht.readTemperature();
  sen.humidity = dht.readHumidity();

  // read BMP 180
  sen.pressure = bmp.readPressure()/100; // Pressure in hPa
  sen.altitude = bmp.readAltitude();
  sen.seaLevelPressure = bmp.readSealevelPressure();
  sen.realAltitude = bmp.readAltitude(101500);

  // read MQ135
  sen.ppm = analogRead(34);

  return sen;
  
 }


void setup() {
  Serial.begin(115200);
  dht.begin();
  bmp.begin();

  WiFi.begin(ssid, password);
  Serial.println("Connecting");
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to WiFi network with IP Address: ");
  Serial.println(WiFi.localIP());
 
  Serial.println("Timer set to 5 seconds (timerDelay variable), it will take 5 seconds before publishing the first reading.");
}

void loop() {

  SensorsData sen = readSensors();
  // Create a JSON object
  DynamicJsonDocument jsonDoc(256);
 
  jsonDoc["temprature"]= sen.temp;
  jsonDoc["humidity"]= sen.humidity;
  jsonDoc["pressure"]= sen.pressure;
  jsonDoc["altitude"]= sen.altitude;
  jsonDoc["seaLevelPressure"]= sen.seaLevelPressure;
  jsonDoc["realAltitude"]= sen.realAltitude;
  jsonDoc["ppm"]= sen.ppm;


  // Converting JSON object to string
  String jsonStr;
  serializeJson(jsonDoc, jsonStr);
  
  
  //Send an HTTP POST request every 10 minutes
  if ((millis() - lastTime) > timerDelay) {
    //Check WiFi connection status
    SensorsData sen = readSensors();
    if(WiFi.status()== WL_CONNECTED){
      HTTPClient http;

      String serverPath = serverName;
      
      // Your Domain name with URL path or IP address with path
      http.begin(serverPath.c_str());
      http.addHeader("Content-Type", "application/json");
      
      // If you need Node-RED/server authentication, insert user and password below
      //http.setAuthorization("REPLACE_WITH_SERVER_USERNAME", "REPLACE_WITH_SERVER_PASSWORD");
     //  String payload = "{\"temperature\": 25, \"humidity\": 50}";

        int httpResponseCode = http.POST(jsonStr);
      // Send HTTP GET request
//      int httpResponseCode = http.GET();
      
      if (httpResponseCode>0) {
        Serial.print("HTTP Response code: ");
        Serial.println(httpResponseCode);
        String payload = http.getString();
        Serial.println(payload);
      }
      else {
        Serial.print("Error code: ");
        Serial.println(httpResponseCode);
      }
      // Free resources
      http.end();
    }
    else {
      Serial.println("WiFi Disconnected");
    }
    lastTime = millis();
  }

 

}
