class Hoop {
  float top, bottom;
  float hoopX = width-150;

  //The hoop constructor sets the top and bottom
  //positions for both game modes to be a random float
  //between 80 and 160 (positions).
  Hoop() {
     top = random(80, 160);
     bottom = random(80, 160);
  }
  
  //getter
  float getX() {
    return hoopX; 
  }
  
  //getter based on the game mode
  float getY(String which) {
    if(which == "top")
      return top;
    if(which == "bottom")
      return bottom;
    return 0;
  }
  
  //drawHoop draws the hoops to be avoided by the basketball.
  void drawHoop() {
    pushStyle();
    fill(255);
    rect(hoopX, top, 110, 80, 20);
    fill(255, 0, 0);
    rect(hoopX, top-27, 40, 25);
    fill(255);
    rect(hoopX, top-27, 30, 15);
    fill(#B7B5B5);
    rect(hoopX, top-100, 10, 120);
    noFill();
    stroke(255, 0 ,0);
    strokeWeight(5);
    arc(hoopX, top-50, 50, 20, -PI/3, 5*PI/3);
    popStyle();
    
    pushStyle();
    fill(255);
    rect(hoopX, height-bottom, 110, 80, 20);
    fill(255, 0, 0);
    rect(hoopX, height-bottom+27, 40, 25);
    fill(255);
    rect(hoopX, height-bottom+27, 30, 15);
    fill(#B7B5B5);
    rect(hoopX, height-bottom+100, 10, 120);
    noFill();
    stroke(255, 0 ,0);
    strokeWeight(5);
    arc(hoopX, height-bottom+50, 50, 20, -PI/3, 5*PI/3);
    popStyle();
  }
  
  //moveHoop moves the hoop over by 3 pixels at each call (constantly)
  void moveHoop() {
      hoopX -= 3;
  }
  
  //collision checks if the ball collides with the hoop or goes
  //out of bounds. It returns true if the ball y position is lower
  //than the bottom or higher than the top. If the ball x position
  //is in the range of the hoop and then if the y position is at
  //or above the hoop's then the function also returns true. 
  //Returning true signals a collision. Else, false is returned.
  boolean collision(Ball bball) {
      if(bball.getY() > height || bball.getY() < 0)
        return true; 
      if((bball.getX() > hoopX-55) && (bball.getX() < hoopX+55))
        if((bball.getY() < (top+50)) || (bball.getY() > (height-bottom-50)))
          return true;
    return false;
  }
}
