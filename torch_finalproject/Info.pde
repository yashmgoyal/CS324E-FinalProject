class Info{
  boolean forward = false;
  int numPage = 1;
  int bounce = 10;
  
  String line1 = "In the dark, we find ";
  String line2 = "hidden treasures...";
  String currentLine1 = "";
  String currentLine2 = "";
  boolean line1Finish = false;
  boolean skip = false;
  int i = 0;
  int i2 = 0;
  
  boolean speedClick = false;
  boolean hoverOne = false;
  boolean hoverTwo = false;
  boolean hoverThree = false;
  int speedClickX, speedClickY;
  
  boolean soundOn = true;
  color green = color(5, 180, 24);
  color gHighlight = color(127, 204, 136);
  color red = color(199, 36, 26);
  color rHighlight = color(223, 115, 108);
  color gray = color(100);
  color on = green;
  color off = gray;
  
  void startPage(){
    startPageBox();
    textFont(font);
    fill(255);
    textAlign(CENTER);
    
    //tabbing between the two start pages using arrow button functionality
    if(!forward){
       startPage1();
       pressForwardButton();
    }
    else{
      startPage2();
      pressBackwardButton();
    }
  }
  
  void startPageBox(){
    rect(150, 100, 700, 600);
    fill(0);
    rect(165, 115, 670, 570);
  }
  
  void startPage1(){
    textSize(60);
    text("Welcome to", width/2, height/2 - 100 - bounce);
    text("Light Chase", width/2, height/2 - 40 - bounce);
    
    textSize(20);
    //typing out animation of subtitle lines
    //pressing space will skip all the the typing animation
    if(!skip){
      //prints out a new letter every 20 frames --> ensures letters appear one by one
      if(frameCount%20 == 0 && i<line1.length()){
        currentLine1 = currentLine1 + line1.charAt(i);
        i++;
        if(i == line1.length()){
          line1Finish = true;
        }
      }
      text(currentLine1, width/2, height/2 + 60 - bounce);

      //prints second part of the line only after the first line has finished
      if(line1Finish){
        //prints out a new letter every 20 frames --> ensures letters appear one by one
        if(frameCount%20 == 0 && i2<line2.length()){
          currentLine2 = currentLine2 + line2.charAt(i2);
          i2++;
          
          if(i2 == line2.length()){
            typing.stop();
          }
        }
      }
      text(currentLine2, width/2, height/2 + 90 - bounce);
    
      bounce();
      
      if(keyPressed && key == ' '){
        typing.stop();
        skip = true;
      }
    }
    else{
      text("In the dark, we find ", width/2, height/2 + 60 - bounce);
      text("hidden treasures...", width/2, height/2 + 90 - bounce);
      typingFinished = true;
      bounce();
    }
    
  }
  
  //displays rules
  void startPage2(){
    typing.stop();
    textSize(60);
    text("How to Play:", width/2, height/2 - 160 - bounce);
    textSize(20);
    text("The objective of Light Chase", width/2, height/2 - 110);
    text("is to control a beam a light", width/2, height/2 - 80);
    text("to find objects in the dark.", width/2, height/2 - 50);
    
    text("- move mouse to move the light", width/2, height/2 + 10);
    text("- click on illuminated objects", width/2, height/2 + 40);
    text("  to collect it", width/2, height/2 + 70);
    
    textSize(30);
    text("Press 'S' to", width/2, height/2 + 140 - bounce);
    text("start the game.", width/2, height/2 + 190 - bounce);
    
    bounce();
  }
  
  //bounces the text every 50 frames --> makes sure the text arent bouncing too crazy
  void bounce(){
    if(frameCount%50 == 0){
      if(bounce == 10){
        bounce = 0;
      }
      else{    
        bounce = 10;
      }
    }
  }
  
  //when forward button is pressed, move start page to the next page
  void pressForwardButton(){
    //is mouse on rectangle part of the arrow button
    if((720<mouseX && mouseX<770) && (630<mouseY && mouseY<650)){
      fill(150);
      if(mousePressed){
        click.play();
        forward = true;
      }
    }
    //is mouse on triangle part of the arrow button
    else if(((615<mouseY && mouseY<=640 && mouseX<(mouseY-615 + 770)) && 770<mouseX) || ((640<=mouseY && mouseY<665 && mouseX<(665-mouseY + 770)) && 770<mouseX)){
      fill(150);
      if(mousePressed){
        click.play();
        forward = true;
      }
    }
    else{
      fill(255);
    }
    //arrow button
    noStroke();
    rect(720, 630, 50, 20);
    //top left point, middle right point, bottom left point 
    triangle(770, 615, 795, 640, 770, 665);
    fill(255);
  }
  
  //when backward button is pressed, move start page back one page
  void pressBackwardButton(){
    if((230<mouseX && mouseX<280 && 630<mouseY && mouseY<650)){
      fill(150);
      if(mousePressed){
        click.play();
        forward = false;
        skip = true;
      }
    }
    //is mouse on triangle part of the arrow button
    else if(((615<mouseY && mouseY<=640 && mouseX>(230 - mouseY+615)) && mouseX<230) || ((640<=mouseY && mouseY<665 && mouseX>(230 - 665+mouseY)) && mouseX<230)){
      fill(150);
      if(mousePressed){
        click.play();
        forward = false;
        skip = true;
      }
    }
    else{
      fill(255);
    }
    //arrow button
    noStroke();
    rect(230, 630, 50, 20);
    //top left point, middle right point, bottom left point 
    triangle(230, 615, 205, 640, 230, 665);
    fill(255);
  }
  
  void settingPage(){
    startPageBox();
    textFont(font);
    fill(255);
    textAlign(CENTER);
    textSize(60);
    text("Settings", width/2, height/2 - 130 - bounce);
    
    //bar for speed settings
    textSize(25);
    text("speed:", width/2, height/2 - 50);
    fill(255);
    rect(250, 400, 500, 10);
    //vertical buttons for bar --> increasing speed from left to right, 3 options
    hoverOne = isHoverSpeed(250, 380);
    hoverTwo = isHoverSpeed(490, 380);
    hoverThree = isHoverSpeed(740, 380);
    if(speedClick){
      drawSpeedClick();
    }
    fill(255);
    rect(250, 380, 10, 50);
    rect(490, 380, 10, 50);
    rect(740, 380, 10, 50);
    
    //sound
    text("sound:", width/2, height/2 + 100);
    isHoverSound();
    //sound on button
    fill(on);
    rect(width/2 - 40, height/2 + 130, 40, 40);
    //sound off button
    fill(off);
    rect(width/2, height/2 + 130, 40, 40);
    
    //doesn't play sound if user has chosen to mute
    if(!soundOn){
      click.stop();
      typing.stop();
    }
    
    fill(255);
    text("press 'x' to close settings", width/2, height/2 + 250);
  }
  
  //checks which button mouse is hovering over
  boolean isHoverSpeed(int x, int y){
    if(x<mouseX && mouseX<(x+10) && y<mouseY && mouseY<(y+50)){
      fill(160);
      if(mousePressed){
        //functions as radio button checktivity
        if(speedClick){
          speedClick = true;
        }
        else{
          speedClick = !speedClick;
        }
        speedClickX = x;
        speedClickY = y;
        click.play();
      }
      rect(x-5, y-5, 20, 60);
      return true;
    }
    else{
      fill(0);
      rect(x-5, y-5, 20, 60);
      return false;
    }
  }
  
  //when a button is clicked, draw a red highlight around selected button
  void drawSpeedClick(){
    fill(red);
    rect(speedClickX-5, speedClickY-5, 20, 60);
  }
  
  //is mouse over sound button
  void isHoverSound(){
    //sound on button, highlight when mouse hovers over it
    if(((width/2-40)<mouseX && mouseX<width/2) && (height/2+130<mouseY && mouseY<(height/2+170))){
      on = gHighlight;
      if(mousePressed){
        off = gray;
        on = green;
        soundOn = true;
      }
    }
    //sound off button, highlight when mouse hovers over it
    else if((width/2<mouseX && mouseX<(width/2+40)) && (height/2+130<mouseY && mouseY<(height/2+170))){
      off = rHighlight;
      if(mousePressed){
        on = gray;
        off = red;
        soundOn = false;
      }
    }
    //not on buttons
    else{
      //when on button has color/is active, the other is gray
      if(soundOn){
        on = green;
        off = gray;
      }
      else{
        on = gray;
        off = red;
      }
    }
  }
}
