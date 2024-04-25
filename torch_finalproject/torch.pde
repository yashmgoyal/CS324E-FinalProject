import processing.sound.*;
SoundFile click;
SoundFile typing;

float playerX, playerY;
float lightAngle;

int numObjects;
Object[] objectList;

boolean infoScreen = true;
boolean typingFinished = false;
boolean settingScreen = false;
boolean isTyping = true;

PFont font;
Info info;

void setup() {
  size(1000, 800);  
  //adding in sound
  click = new SoundFile(this, "mouse_click.wav");
  typing = new SoundFile(this, "typing.wav");
  
  playerX = width / 2;
  playerY = height / 2;
  lightAngle = PI / 4;
  
  numObjects = (int)random(5, 15);
  objectList = new Object[numObjects];
  for(int i=0; i<numObjects; i++){
    //Object(float x, float y)
    objectList[i] = new Object((int)random(40, width - 40), (int)random(20, height - 20));
  }
  
  font = createFont("joystix.ttf", 30);
  info = new Info();
  
  typing.loop();
}

void draw() {
  background(0);
  //startPage as default
  if(infoScreen){
    info.startPage();
  } 
  
  //game is running
  else{
    playerX = mouseX;
    playerY = mouseY;
    drawPlayer();
    
    for(Object i : objectList){
      i.isObjectVisible(playerX, playerY);
      i.move();
    }  
  }
  
  //pull up settings
  if(settingScreen){
    info.settingPage();
  }
}

void drawPlayer() {
  float lightEndX = playerX + cos(lightAngle) * 100;
  float lightEndY = playerY + sin(lightAngle) * 100;
  
  float flashlightRadius = 200;
  noStroke();
  fill(255, 255, 0, 100);
  ellipse(playerX, playerY, flashlightRadius, flashlightRadius);
  
}

void keyPressed() {
  if(keyPressed && (key == 's' || key == 'S')){
    typing.stop();
    infoScreen = false;
  }
  
  if(keyPressed && (key == 'x' || key == 'X')){
    //pauses/resumes typing sound if settings is opened before typing animation is finished
    if(isTyping){
      typing.stop();
    }
    else{
      if(infoScreen && !typingFinished){
        typing.loop();
      }
    }
    isTyping = !isTyping;
    settingScreen = !settingScreen;
  }
}
