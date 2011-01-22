/*
  Darkness Detector
 
 Increases the brightness of an LED when 
 when ambient light decreases.  Uses a 
 voltage divider to measuer light with
 a photocell.
 
 The circuit:
 * LED attached from pin 9 to ground 
 * Photocell attached to pin A0 from ground
 * 10K resistor attached to pin A0 from +5V
 
 
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

  /*
    Explanation of the auto-detection calculation:
    
    On each pass through the loop function, we update the min_measured and
    max_measured variables if our measured reading is outside of the range we've
    seen so far.  
    
    Our current reading will always be in the range [min,max]. (The square brackets
    mean that our current reading can be equal to one or the other.)
    
    We want to set our output intensity so that when our 'measured_value' reading is equal to the
    minimum, our output intensity is 0, and if our reading is equal to the max, our output is intensity
    is 255 (the maximum for PWM).  
    
    All four of the variables can be visualized as follows:
    
                        min               measured_value             max        
    Input      0        200                    575                   900        1023   
               |---------[----------------------*---------------------]-----------|
    Output               0                     136                   255 
                                            intensity
    
    To do this conversion, we use some fancy C casting.  The way this gets evaluated is as follows:
    
    intensity = 255 * (float)(575 - 200)/(900-200);
    
    Step 1: Evaluate everything inside parens
    
    intensity = 255 * (float)375/700
    
    Step 2: Do the cast (we do this so that we do floating point math, instead of integer math, which just discards decimals)
    
    intensity = 255 * 375.0f / 700
    
    Step 4: Evaluate the multiplication and division in left to right order.  This is a two step-process, with two implicit type 
            conversions.
            
    Step 4a: 255 is cast to a float since it is multiplied by a float.
    
    intensity = 95625.0f / 700 
    
    Step 4b: 95625.0f is cast to an integer because it is being divided by an integer.
    
    intensity = 136
    
    
  */
  intensity = 255 * (float)(measured_value-min_measured)/(max_measured-min_measured);
  analogWrite(ledPin, intensity);

}
