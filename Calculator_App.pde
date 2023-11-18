Calculator cal;

float xMPL, yMPL, tSize;

void setup()
{
  size(600, 750);
  
  xMPL = width / 4;
  yMPL = height / 5;
  
  tSize = height / 6.25;
  
  cal = new Calculator();
}


void draw()
{
  cal.show();
}



void mousePressed()
{
  cal.press(true);
}



void mouseReleased()
{
  cal.press(false);
}
