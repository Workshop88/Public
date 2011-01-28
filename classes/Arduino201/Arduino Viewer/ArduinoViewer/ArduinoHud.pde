import cc.arduino.*;

class ArduinoHud
{  
  color off = color(0, 0, 0);
  color on = color(50, 205, 50);
  color black = color(0,0,0);
  
  int w=1024,h=768;
  int box_width = 20;
  int spacing;
  
  int label_left = 20;
  int graph_left = 100;
  int analog_top = 100;
  int chart_top = 110;
  int analog_label_start = 640;
  
  Arduino arduino;
  
  
  ArduinoHud(Arduino a)
  {
    size(w, h);
    arduino = a;
    
    spacing = (w-14*box_width)/14;
    
    /* Load the font */
    PFont f;
    f = loadFont("Consolas-20.vlw");
    textFont(f);
  }
  
  void draw()
  {
    int box_left, box_top;
  
    background(off);
    stroke(on);
    
    fill(on);
    /* Draw the 'digital io' section */
    text("Digital", label_left, 20);
    for (int i = 0; i <= 13; i++) {
      if (arduino.digitalRead(i) == Arduino.HIGH)
        fill(on);
      else
        fill(off);
      
      box_left = w - ((i+1) * box_width + (i)*spacing) - spacing/2;

      box_top = 50;
      rect(box_left, box_top, box_width, box_width);
      fill(on);
      /* Bump single-digit numbers over. */
      if(i<10)
        box_left+=5;
      text(i, box_left, box_top-10);
    }
    
    fill(on);
    text("Analog", label_left, analog_top);
    fill(off);
    rect(100, chart_top, width-200, analog_label_start-chart_top);
    
  }
}
