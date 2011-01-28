import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

color off = color(4, 79, 111);
color on = color(84, 145, 158);

int[] values = { Arduino.LOW, Arduino.LOW, Arduino.LOW, Arduino.LOW,
 Arduino.LOW, Arduino.LOW, Arduino.LOW, Arduino.LOW, Arduino.LOW,
 Arduino.LOW, Arduino.LOW, Arduino.LOW, Arduino.LOW, Arduino.LOW };

void setup() {
  size(640, 480);
  
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[1], 57600);
  
  for (int i = 0; i <= 13; i++)
    arduino.pinMode(i, Arduino.INPUT);
    
  /* Load the font */
  PFont f;
  f = loadFont("
}

void draw() {
  background(off);
  stroke(on);
  
  for (int i = 0; i <= 13; i++) {
    if (values[i] == Arduino.HIGH)
      fill(on);
    else
      fill(off);
    
      
    rect(420 - i * 30, 30, 20, 20);
  }
}

void mousePressed()
{  
  int pin = (450 - mouseX) / 30;
 
  if(pin < 0 || pin > 13)
    return;
  
  if (values[pin] == Arduino.LOW) {
    arduino.digitalWrite(pin, Arduino.HIGH);
    values[pin] = Arduino.HIGH;
  } else {
    arduino.digitalWrite(pin, Arduino.LOW);
    values[pin] = Arduino.LOW;
  }
}
