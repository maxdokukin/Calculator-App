class Calculator
{
  Button[][] buttons = new Button[5][4];
  
  String scr = new String("");
  
  double a, b, c;
  
  long rT = 0;
    
  char op = 'd';
  
  boolean showRes = false;
  
  Calculator()
  {
    setup_calc();
  }
  
  
  
  void setup_calc()
  {
    char[][] conf = new char[5][4];
        
    conf[0][0] = 's'; conf[0][1] = 's'; conf[0][2] = 's'; conf[0][3] = 's';
    conf[1][0] = '7'; conf[1][1] = '8'; conf[1][2] = '9'; conf[1][3] = '+';
    conf[2][0] = '4'; conf[2][1] = '5'; conf[2][2] = '6'; conf[2][3] = '-';
    conf[3][0] = '1'; conf[3][1] = '2'; conf[3][2] = '3'; conf[3][3] = 'x';
    conf[4][0] = '.'; conf[4][1] = '0'; conf[4][2] = '='; conf[4][3] = '/';
    
    
    for(int i = 0; i < 5; i++)
      for(int j = 0; j < 4; j++)
      {
        if(conf[i][j] == 's')
          buttons[i][j] = new Button('s', 's', i * 100, j * 100);
        
        else if(conf[i][j] >= '0' && conf[i][j] <= '9')
          buttons[i][j] = new Button('n', conf[i][j], i * xMPL, j * yMPL);
          
        else if(conf[i][j] == '=')
          buttons[i][j] = new Button('o', '=', i * xMPL, j * yMPL);          
        
        else if(conf[i][j] == 'x')
          buttons[i][j] = new Button('o', 'x', i * xMPL, j * yMPL);      
          
        else if(conf[i][j] == '+')
          buttons[i][j] = new Button('o', '+', i * xMPL, j * yMPL);      
          
        else if(conf[i][j] == '-')
          buttons[i][j] = new Button('o', '-', i * xMPL, j * yMPL);
        
        else if(conf[i][j] == '/')
          buttons[i][j] = new Button('o', '/', i * xMPL, j * yMPL);
          
        else if(conf[i][j] == '.')
          buttons[i][j] = new Button('o', '.', i * xMPL, j * xMPL);
    }
  }
  
  void show()
  {
    for(int i = 0; i < 5; i++)
      for(int j = 0; j < 4; j++)
      {
        if(buttons[i][j].pressed && (mouseX < buttons[i][j].x || mouseX > buttons[i][j].x + xMPL) || 
                                    (mouseY < buttons[i][j].y || mouseY > buttons[i][j].y + yMPL))
           buttons[i][j].pressed = false;
          
        buttons[i][j].show();
      }
      
    
    float ttSize = tSize;  
    
    for(float xPos = width - textWidth(scr) - 5; xPos < 0; textSize(ttSize--))
      xPos = width - textWidth(scr) - 5;
      
    text(scr, width - textWidth(scr) - 5, yMPL - tSize * 0.3);
    
    textSize(tSize);
    
  }
  
  
  void flushScr()
  {
    readValue();

    scr = "";
    showRes = false;
  }
  
  
  
  void readValue()
  {
    if(!scr.isEmpty())
      if(a == 0)
        a = Double.parseDouble(scr);
      else
        b = Double.parseDouble(scr);
  }
  
  
  void resetHolds()
  {
    for(int i = 0; i < 5; i++)
      for(int j = 0; j < 4; j++)
        buttons[i][j].hold = false;
  }
  
  void count()
  {    
    resetHolds();
          
    switch(op)
    {
      case'+':
        c = a + b;
      break;      
      
      case'-':
        c = a - b;
      break;      
      
      case'x':
        c = a * (float) b;
      break;      
      
      case'/':
        c = a / (float) b;
      break;
    }
        
    scr = Double.toString(c);
    
    a = 0;
    
    showRes = true;
    rT = millis();
  }
  
  void press(boolean s)
  {
    if(showRes && millis() - rT > 100) //after '=' pressed logic
    {
      flushScr();
      
      if(buttons[int(mouseY / yMPL)][int(mouseX / xMPL)].sign == '=')
      {
        a = c;
        count();
        return;
      }
      else if(buttons[int(mouseY / yMPL)][int(mouseX / xMPL)].mode == 'n')            
      {
        scr += buttons[int(mouseY / yMPL)][int(mouseX / xMPL)].sign;
        
        a = 0;
        b = 0;
        c = 0;
        
        readValue();
       
        return;
      }
    }
      
    buttons[int(mouseY / yMPL)][int(mouseX / xMPL)].pressed = s;
    
    if(buttons[int(mouseY / yMPL)][int(mouseX / xMPL)].mode == 's') //flush when screen touched
    {
      flushScr();
      a = 0;
      b = 0;
      c = 0;
    }
      
    if(s)
      switch(buttons[int(mouseY / yMPL)][int(mouseX / xMPL)].mode)
      {
        case 's':
        break;
        
        case 'o': 
          if(buttons[int(mouseY / yMPL)][int(mouseX / xMPL)].sign == '.')
          {
            if(scr.indexOf('.') == -1)  //two dots protection
              scr += '.';
              
            return;
           }
        
          resetHolds();
  
          buttons[int(mouseY / yMPL)][int(mouseX / xMPL)].hold = true;
          
          flushScr();
          
          if(buttons[int(mouseY / yMPL)][int(mouseX / xMPL)].sign != '=')  //operator assignature
            op = buttons[int(mouseY / yMPL)][int(mouseX / xMPL)].sign;
          else
            count();
        
        break;
        
        default:
          scr += buttons[int(mouseY / yMPL)][int(mouseX / xMPL)].sign;
        break;
      }
  }
}
