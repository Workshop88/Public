import processing.serial.*;

Arduino arduino;
ArduinoHud hud;


void setup() {

  if(Arduino.list().length > 1) {
    arduino = new Arduino(this, Arduino.list()[1], 57600);
  
    hud=new ArduinoHud(arduino);
    
    for (int i = 0; i <= 13; i++)
      arduino.pinMode(i, Arduino.INPUT);
  } else {
    
    exit(); 
  }

}

void draw() {

  hud.draw();
  
}

