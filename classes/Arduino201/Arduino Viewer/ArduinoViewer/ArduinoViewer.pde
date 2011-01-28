import processing.serial.*;

Arduino arduino;
ArduinoHud hud;


void setup() {

  arduino = new Arduino(this, Arduino.list()[1], 57600);

  hud=new ArduinoHud(arduino);
  
  for (int i = 0; i <= 13; i++)
    arduino.pinMode(i, Arduino.INPUT);

}

void draw() {

  hud.draw();
  
}

