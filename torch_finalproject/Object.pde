class Object{ 
  float x, y;
  float oriX, oriY;
  float diameter = 25;
  int yDist = (int)random(50, 150);
  float vy = 2;
  boolean objectCaptured = false;
  boolean objectVisible = false;
 
  //paramterized constructor
  Object(int oriX, int oriY){
    this.oriX = oriX;
    this.oriY = oriY;
    x = oriX;
    y = oriY;
    objectCaptured = false;
    objectVisible = false;
  } 
  
  //object movement system
  void move() {
    if(y == (oriY + yDist) || y == (oriY - yDist) || y >= height-diameter || y <= 0+diameter){
      vy *= -1;
    }
    y+=vy;
    display();
  }
  
  //display object
  void display() {
    fill(255);
    ellipse(oriX, y, diameter, diameter);
  }
  
  //checks if an object is under player's flashlight --> if so, display object
  void isObjectVisible(float playerX, float playerY){
    //distance between player and object
    float distance = dist(playerX, playerY, x, y);
    //player flashlight diameter = 100;
    if(distance < 100){
      display();
      objectVisible = true;
    }
    else{
      objectVisible = false;
    }
  }

  void checkCapture() {
    if (objectVisible && !objectCaptured && mousePressed && dist(mouseX, mouseY, x, y) < 10) {
      objectCaptured = true;
      println("Object captured!");
    }
  }
}
