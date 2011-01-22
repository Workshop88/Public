/*
    Darkness Detector
     
     Increases the brightness of an LED when 
     when ambient light decreases.  Uses a 
     voltage divider to measure light with
     a photocell.
     
     The circuit:
     * LED attached from pin 9 to ground 
     * Photocell attached to pin A0 from ground
     * 10K resistor attached to pin A0 from +5V
     
    by Russ Lankenau (rlankenau@workshop88.com)

    Copyright (C) 2011  Russ Lankenau
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 */

// constants won't change. They're used here to 
// set pin numbers:
const int sensorPin = A0;     // the number of the pushbutton pin
const int ledPin =  9;      // the number of the LED pin

/* Output intensity */
int intensity = 0;

/* 
  Maximum value measured so far 
  Start it low so any reading updates it.
*/
int max_measured = -1;

/* 
  Minimum value measured so far.
  Start it high so any reading updates it.
*/  
int min_measured = 1024;

void setup() {
  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);      
  // initialize the photocell pin as an input:
  pinMode(sensorPin, INPUT);     
}

void loop(){

  /* Read the current value from the photocell. */
  int measured_value = analogRead(sensorPin);
  
  /* If the current reading is less than the current minimum, update the minimum. */
  if(measured_value < min_measured)
    min_measured = measured_value;
    
  /* If the current reading is greater than the current maximum, update the maxiumum. */
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
  
  /* Set the output to the intensity we just calculated */
  analogWrite(ledPin, intensity);

}
