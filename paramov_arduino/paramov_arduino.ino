#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#define ONE_WIRE_BUS D2
int flexpin1 = A0;
int flexpin2 = D1;
const int numReadings = 10;  // Number of readings to average for stability
int sensorValues1[numReadings];  // Array to store sensor readings
int sensorValues2[numReadings];  // Array to store sensor readings
int readIndex = 0;

OneWire oneWire(ONE_WIRE_BUS);

DallasTemperature sensors(&oneWire);

float Celsius = 0;
float Fahrenheit = 0;


#define FIREBASE_HOST "paramov-b4f20-default-rtdb.firebaseio.com" //Your Firebase Project URL goes here without "http:" , "" and "/"
#define FIREBASE_AUTH "VdGxUcAqgZ30qPer5O3WkUsr0wfKIEwWEv7H2ww7" //Your Firebase Database Secret goes here

#define WIFI_SSID "Iotvb" //WiFi SSID to which you want NodeMCU to connect
#define WIFI_PASSWORD "vanshaj123" //Password of your wifi network

// Declare the Firebase Data object in the global scope
FirebaseData firebaseData;

/* 4, Define the FirebaseAuth data for authentication data */
FirebaseAuth auth;

/* Define the FirebaseConfig data for config data */
FirebaseConfig config;


void setup() {
  sensors.begin();
  Serial.begin(9600);
  // pinMode(flexpin1, INPUT_PULLUP);
  // pinMode(flexpin2, INPUT_PULLUP);
  Serial.println("Serial communication started\n\n");

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD); //try to connect with wifi
  Serial.print("Connecting to ");
  Serial.print(WIFI_SSID);

  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }

Serial.println();
  Serial.print("Connected to ");
  Serial.println(WIFI_SSID);
  Serial.print("IP Address is : ");
  Serial.println(WiFi.localIP()); //print local IP address
// Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH); // connect to firebase

/* Assign the database URL and database secret(required) */
  config.database_url = FIREBASE_HOST;
  config.signer.tokens.legacy_token = FIREBASE_AUTH;
  Firebase.begin(&config, &auth);

  Firebase.reconnectWiFi(true);
  delay(1000);
}


void loop() {
  sensors.requestTemperatures();

  Celsius = sensors.getTempCByIndex(0);
  Fahrenheit = sensors.toFahrenheit(Celsius);

  Serial.print(Celsius);
  Serial.print(" C  ");
  Serial.print(Fahrenheit);
  Serial.println(" F");
  int flexVal1;
  int flexVal2;
  flexVal1 = analogRead(flexpin1);
  // Serial.print("Test: ");
  // Serial.print(flexVal1);
  // Store reading in array for averaging
  sensorValues1[readIndex] = flexVal1;
  flexVal2 = analogRead(flexpin2);
  sensorValues2[readIndex] = flexVal2;
  // Increment read index and handle overflow
  readIndex = (readIndex + 1) % numReadings;

  // Calculate average sensor reading
  float avgSensorValue1 = calculateAverage(sensorValues1);
  float avgSensorValue2 = calculateAverage(sensorValues2);
  // Convert sensor value to degrees (assuming linear relationship)
  float angle1 = map(avgSensorValue1, 0.0, 1023.0, 0.0, 180.0);  // Adjust range based on sensor behavior
  float angle2 = map(avgSensorValue2, 0.0, 1023.0, 0.0, 180.0);  // Adjust range based on sensor behavior
  Serial.print("Sensor1: ");
  Serial.print(angle1);
  // Serial.print(" Sensor2: ");
  // Serial.println(angle2);
  delay(1000);
// Firebase Error Handling And Writing Data At Specifed Path******************

if (Firebase.setInt(firebaseData, "/need1", int(angle1))) { // On successful Write operation, function returns 1
Serial.println("Value Uploaded Successfully");
           delay(1000);

 }
// if (Firebase.setInt(firebaseData, "/need2", int(angle2))) { // On successful Write operation, function returns 1
// Serial.println("Value Uploaded Successfully");
//            delay(1000);

//  }
if (Firebase.setInt(firebaseData, "/temperature", int(Fahrenheit))) { // On successful Write operation, function returns 1
Serial.println("Value Uploaded Successfully");
           delay(1000);

 }
else {
Serial.println(firebaseData.errorReason());
}
}



int calculateAverage(int values[]) {
  int sum = 0;
  for (int i = 0; i < numReadings; i++) {
    sum += values[i];
  }
  return sum / numReadings;
}

float map(float value, float low1, float high1, float low2, float high2) {
  return (value - low1) * (high2 - low2) / (high1 - low1) + low2;
}
