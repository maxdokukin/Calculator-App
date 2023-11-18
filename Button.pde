class Button
{
  char mode, sign;
  
  float x, y;  
  boolean pressed, hold;
  
  Button(char m, char s, float x_, float y_)
  {
    this.mode = m;
    this.sign = s;
    this.y = x_;
    this.x = y_;
  }
  
  
  void show()
  {
    switch(mode)
    {
      case 's':
        stroke(222, 222, 222);
        fill(222, 222, 222); 
      break;
        
      case 'o':
        stroke(0);
      
        if(pressed || hold)
          fill(34, 77, 23);  
        else
          fill(9, 148, 65);  
      break;
    
      case 'n':  
        stroke(0);
        
        if(pressed)
          fill(96, 168, 48);  
        else
          fill(159, 218, 64);
      break;
    }
    
    rect(x, y, x + xMPL, y + yMPL);
    
    if(mode == 'n' || mode == 'o')
    {
      textSize(tSize);
      
      fill(70);
      
      text(sign, x + (xMPL - textWidth(sign)) / 2, y + tSize);
    }
  }
}
