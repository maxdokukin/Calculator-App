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
          fill(162, 20, 179);  
        else
          fill(215, 83, 230);  
      break;
    
      case 'n':  
        stroke(0);
        
        if(pressed)
          fill(132, 132, 155);  
        else
          fill(192, 192, 226);
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
