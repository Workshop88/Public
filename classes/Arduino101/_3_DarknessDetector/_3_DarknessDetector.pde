/*
  Darkness Detector
 
 Increases the brightness of an LED when 
 when ambient light decreases.  Uses a 
 voltage divider to measuer light with
 a photocell.
 
 The circuit:
 * LED attached from pin 9 to ground 
 * Photocell attached to pin A0 from +5V
 * 10K resistor attached to pin A0 from ground
 
 
 created 2011
 by Russ Lankenau (rlankenau@workshop88.com)
 
 This example code is in the public domain.
 
 */

// constants won't change. They're used here to 
// set pin numbers:
const int sensorPin = A0;     // the number of the pushbutton pin
const int ledPin =  9;      // the number of the LED pin

int intensity = 0;
int max_measured = -1;
int min_measured = 1024;

void setup() {
  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);      
  // initialize the pushbutton pin as an input:
  pinMode(sensorPin, INPUT);     
}

void loop(){
  // read the state of the pushbutton value:
  int measured_value = analogRead(sensorPin);
  if(measured_value < min_measured)
    min_measured = measured_value;
  if(measured_value > max_measured)
    max_measured = measured_value;

  intensity = 255 - 255 * (float)(measured_value-min_measured)/(max_measured-min_measured);
  analogWrite(ledPin, intensity);

}
