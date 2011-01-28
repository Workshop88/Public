import cc.arduino.*;

class ArduinoHud
{  
  color off = color(0, 0, 0);
  color on = color(50, 205, 50);
  color black = color(0,0,0);
  
  int w=1000,h=770;
  int box_width = 20;
  int spacing;
  
  int digital_top = 50;
  int label_left = 20;
  int graph_left = 100;
  int analog_top = 150;
  int chart_top = 170;
  int analog_label_start = 640;
  int a_spacing;
  
  Arduino arduino;
  
  
  ArduinoHud(Arduino a)
  {
    size(w, h);
    arduino = a;
    
    spacing = (w-14*box_width)/14;
    a_spacing = (w-6*box_width)/6 ;
    
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
    text("Digital", label_left, digital_top);
    for (int i = 0; i <= 13; i++) {
      if (arduino.digitalRead(i) == Arduino.HIGH)
        fill(on);
      else
        fill(off);
      
      box_left = w - ((i+1) * box_width + (i)*spacing) - spacing/2;

      box_top = digital_top + 40;
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
    fill(on);
    text("1024", 55, chart_top+8);
    text("0", 85, analog_label_start+5);
    for(int i=0;i<6;i++)
    {
       box_left = (((i+1) * box_width + (i)*a_spacing) + a_spacing/2 - box_width/2);
       box_top = analog_label_start + 30;
       draw_analog_symbol(i, box_left, analog_label_start + 30, box_width);
       fill(on);
       text("A" + i, box_left - box_width/2, box_top + box_width+10);
    }
    
  }
  
  void draw_analog_symbol(int i, int x, int y, int sz)
  {
    switch(i)
    {
      case 0:
        fill(off);
        triangle(x-sz/2, y+sz/2, x+sz/2, y+sz/2, x, y-sz/2);
        break;
      case 1:
        fill(on);
        triangle(x-sz/2, y+sz/2, x+sz/2, y+sz/2, x, y-sz/2);
        break;
      case 2:
        fill(off);
        triangle(x-sz/2, y-sz/2, x+sz/2, y-sz/2, x, y+sz/2);
        break;
      case 3:
        fill(on);
        triangle(x-sz/2, y-sz/2, x+sz/2, y-sz/2, x, y+sz/2);
        break;
      case 4:
        fill(off);
        ellipse(x, y, sz, sz);
        break;
      case 5: 
        fill(on);
        ellipse(x, y, sz, sz);
        break;   
    }
  }
}
