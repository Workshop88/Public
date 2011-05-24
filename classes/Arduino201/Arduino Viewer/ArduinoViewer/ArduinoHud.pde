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
  int a_pos = 0;
  int graph_width=800;
  int init_finished = 0;
  int symbol_interval = 100;
  
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

    stroke(on);
    fill(off); 
    if(init_finished == 0)
    {
      background(off);
      
      rect(79, chart_top-20, graph_width+42, analog_label_start-chart_top+40);
      init_finished=1;
    }
  

    
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
    stroke(off);
    if(a_pos == 0)
      rect(100+a_pos-20, chart_top-10, 40, analog_label_start-chart_top+20);
    else 
      rect(100+a_pos, chart_top-10, 20, analog_label_start-chart_top+20);
    fill(on);
    stroke(on);
    text("1024", 35, chart_top+8);
    text("0", 65, analog_label_start+5);
    for(int i=0;i<6;i++)
    {
       /* Draw the position. The reading is 1024 - the value because it is easier than flipping the graph Y axis.*/
       int reading = 1024 - arduino.analogRead(i);
       fill(on);
       point(100+a_pos, chart_top + reading*(analog_label_start-chart_top)/1024);
       if(a_pos%symbol_interval == 0)
       {
         draw_analog_symbol(i, 100+a_pos - box_width/2, chart_top + reading*(analog_label_start-chart_top)/1024, box_width/2);         
       }
      
       box_left = (((i+1) * box_width + (i)*a_spacing) + a_spacing/2 - box_width/2);
       box_top = analog_label_start + 30;
       draw_analog_symbol(i, box_left, analog_label_start + 35, box_width);
       fill(on);
       text("A" + i, box_left - box_width/2, box_top + box_width+15);
    }
    a_pos = (a_pos+1) % graph_width;
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
