class Ball {
  
  //need location, velocity, and acceleration PVectors
  //to manage ball gravity
  
  PVector loc;
  PVector vel;
  PVector acc;
  
  final float xLoc = 120;
  
  PImage ball = loadImage("basketball.png");
  
  //the Ball constructor sets the location, velocity, and
  //acceleration of the ball. The x location is always at xLoc (120)
  //and the initial height is at height/2.
  Ball() {
    //original ball location
    loc = new PVector(xLoc, height/2);
    //ball not moving initially
    vel = new PVector(0, 0);
    //no acceleration initially
    acc = new PVector();
  }
  
  //getter
  float getY() {
    return loc.y;
  }
  
  //getter
  float getX() {
    return xLoc; 
  }
  
  //adds a force to the ball object by adding a force vector pd
  //(gravity)
  void pushDrop(PVector pd) {
    acc.add(pd); 
  }
  
  //moveBall moves the ball based on gravity added to acceleration,
  //velocity added onto location, and acceleration added onto
  //velocity. The limit of velocity is set to 4, which is
  //perfect for the game. The acceleration is set back to 0 at the
  //end of the function.
  void moveBall() {
    pushDrop(grav);
    loc.add(vel);
    vel.add(acc);
    vel.limit(4);
    acc.set(0, 0, 0);
  }
  
  //drawBall draws an ellipse at xLoc and the current y location
  //based on the force applied.
  void drawBall() {
    fill(#FA8320);
    ellipse(xLoc, loc.y, 30, 30);  
  }
  
}
