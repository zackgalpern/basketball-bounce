//The biggest difficulty in completing this project
//was definitely drawing and moving the hoops. It took 
//lots of research and trial and error to move each element
//of each hoop accordingly. It was also very difficult to 
//update the score with each gap clear. I ended up
//not being able to solve this issue, so the scores
//are a bit off at the beginning of each game. I also kept receiving
//many NullPointerException errors, which were resolved by
//making sure that each ball and hoop object were correctly
//declared and initialized before the implementation of each.

import processing.sound.*;

PImage bkgd;
PFont scoreFont;
PVector grav = new PVector(0, 0.5);
SoundFile song, buzzer, blip;

Scoreboard board = new Scoreboard();

int score = 0;

Ball bball;
Hoop hp;
ArrayList<Hoop> hoops = new ArrayList<Hoop>();
int hoopNum = hoops.size();

final int MENUSCREEN = 0;
final int GAMESCREEN_EASY = 1;
final int GAMESCREEN_HARD = 2;
final int HELPSCREEN = 3;
final int QUIT = 4;
final int EASY_HIGH = 1;
final int HARD_HIGH = 2;
int screenState;

int fakeScore;

//Declares and initializes all the objects:
//background image, each sound, font.
//Initializes bball as a new Ball object.
//Sets the screen state to the Menu screen.
//Plays the background song.
void setup() {
  size(626, 473);

  //initialize images
  bkgd = loadImage("arena.jpg");
  

  //initialize sounds
  song = new SoundFile(this, "song.wav");
  song.amp(0.5);
  buzzer = new SoundFile(this, "buzzer.wav");
  buzzer.amp(0.2);
  blip = new SoundFile(this, "blip.wav");
  blip.amp(0.2);

  //initialize font
  scoreFont = createFont("DangerOnTheMotorway-xV10.ttf", 32);
  textFont(scoreFont);

  bball = new Ball();

  //set screen state to 0 (menu state)
  screenState = MENUSCREEN;
  
  playSound(song);
  
  fakeScore = 0;
}

//Draw handles the case for each screen state.
//It constantly checks which screen should be up and
//draws the screen accordingly by calling each screen's
//function.
void draw() {
  background(bkgd);
  
  if(screenState == MENUSCREEN) {
    drawMenu();
    board.printHighScore(EASY_HIGH);
    board.printHighScore(HARD_HIGH);
  }
  else if(screenState == GAMESCREEN_EASY) {
    drawEasyGame();
  }
  else if(screenState == GAMESCREEN_HARD) {
    drawHardGame();
  }
  else if(screenState == HELPSCREEN) {
    drawHelpScreen(); 
  }
  else if(screenState == QUIT)
    quit();
}

//drawMenu draws the start menu. It sets up each button
//and highlights the text in the button if the mouse
//is inside of the button. drawMenu also utilizes
//the mouseClicked() function at the bottom of the code
//to change the screen based on which button is clicked.
void drawMenu() {
  fill(#F5A30A);
  textAlign(CENTER);
  textSize(40);
  text("Basketball Bounce", width/2, 105);

  rectMode(CENTER);
  rect(width/2, 200, 160, 65, 20);
  fill(0);
  text("EASY", width/2, 217);

  fill(#F5A30A);
  rect(width/2, 300, 160, 65, 20);
  fill(0);
  text("HARD", width/2, 317);
  
  fill(#F5A30A);
  rect(width/2, 400, 160, 65, 20);
  fill(0);
  text("QUIT", width/2, 417);
  
  fill(#F5A30A);
  rect(width/2+200, 400, 160, 65, 20);
  fill(0);
  text("HELP", width/2+200, 417);

  if(mouseX > width/2-80 && mouseX < width/2+80 && mouseY > 200-65/2 && mouseY < 200+65/2) {
    fill(255);
    text("EASY", width/2+1, 217);
  }
  
  if(mouseX > width/2-80 && mouseX < width/2+80 && mouseY > 300-65/2 && mouseY < 300+65/2) {
    fill(255);
    text("HARD", width/2, 317);
  }
  
  if(mouseX > width/2-80 && mouseX < width/2+80 && mouseY > 400-65/2 && mouseY < 400+65/2) {
    fill(255);
    text("QUIT", width/2, 417);
  }
  
  if(mouseX > width/2+200-80 && mouseX < width/2+200+80 && mouseY > 400-65/2 && mouseY < 400+65/2) {
    fill(255);
    text("HELP", width/2+200, 417);
  }
}

//drawEasyGame draws and begins the easy game mode. It draws
//the scoreboard and then at each frameCount%75==0 it adds a
//new hoop to the hoops ArrayList. The for loop then moves each
//hoop and redraws it at its new position constantly. Also inside
//the for loop, there is a collision check. If the positions of the
//ball and the hoops cross each other, the game ends. Before the
//game ends, however, the function checks of the current score
//of the user is the high score, and will set the new high score
//accordingly. It then resets the cur=rent score back to 0.
//The buzzer will sound, the ball object will be reset and the screen
//state changes back to the Menu. If the spacebar is pressed
//(technically any key will suffice, but the player
//does not need to know this), then a new "up" force is applied
//to the ball. The ball is drawn and moved according
//to the key input.
void drawEasyGame() {
  board.drawScoreboard();
  
   if(frameCount % 75 == 0) {
     hoops.add(new Hoop());
     fakeScore++;
     if(fakeScore > 2)
       board.updateScore();
   }
    
   for(int i = hoops.size()-1; i >= 0; i--) {
     Hoop hp = hoops.get(i);
     hp.moveHoop();
     hp.drawHoop();
     
     if(hp.collision(bball)) {
        if(board.isHighScore(board.getScore(), EASY_HIGH)) {
          board.setHighScore(board.getScore(), EASY_HIGH);
          board.setScore(0);
        }
     playSound(buzzer);
     bball = new Ball();
     screenState = MENUSCREEN;
     board.setScore(0);
     hoops.clear();
     //frameCount = 0;
     break;
    }
   }
   
   for(int i = hoops.size()-1; i >= 0; i--) {
     
   }
  
  if(keyPressed) {
    PVector up = new PVector(0, -5);
    bball.pushDrop(up);
  }
  
  bball.drawBall();
  bball.moveBall();
}

//drawHardGame draws and begins the hard game mode. It draws
//the scoreboard and then at each frameCount%50==0 it adds a
//new hoop to the hoops ArrayList. The for loop then moves each
//hoop and redraws it at its new position constantly. Also inside
//the for loop, there is a collision check. If the positions of the
//ball and the hoops cross each other, the game ends. Before the
//game ends, however, the function checks of the current score
//of the user is the high score, and will set the new high score
//accordingly. It then resets the current score back to 0.
//The buzzer will sound, the ball object will be reset and the screen
//state changes back to the Menu. If the spacebar is pressed
//(technically any key will suffice, but the player
//does not need to know this), then a new "up" force is applied
//to the ball. The ball is drawn and moved according
//to the key input.
void drawHardGame() {
  board.drawScoreboard();
  
  if(frameCount % 50 == 0) {
     hoops.add(new Hoop());
     fakeScore++;
     if(fakeScore > 2)
       board.updateScore();
  }

     
   for(int i = hoops.size()-1; i >= 0; i--) {
     Hoop hp = hoops.get(i);
     hp.moveHoop();
     hp.drawHoop();
  
      if(hp.collision(bball)) {
        if(board.isHighScore(board.getScore(), HARD_HIGH)) {
          board.setHighScore(board.getScore(), HARD_HIGH);
          board.setScore(0);
        }
      playSound(buzzer);
      bball = new Ball();
      screenState = MENUSCREEN;
      board.setScore(0);
      hoops.clear();
      break;
    }
   }
  
  if(keyPressed) {
    PVector up = new PVector(0, -5);
    bball.pushDrop(up);
  }
  
  bball.drawBall();
  bball.moveBall();
}

//drawHelpScreen draws the How to Play instructions screen.
//It displays the text of how to play. In this menu there
//also exists a button which will set the screen state back 
//to the Menu and will bring the player there
//(this is done in mousePressed()).
void drawHelpScreen() {
   fill(#F5A30A);
   textSize(44);
   text("How to Play", width/2, height/2-150);
   textSize(22);
   fill(255);
   text("Use your mouse to select a level.", width/2, height/2-60);
   text("Use your space bar to bounce", width/2, height/2-20);
   text("the ball. It's that simple!", width/2, height/2+20);
   text("Avoid the hoops and don't", width/2, height/2+60);
   text("go out of bounds!", width/2, height/2+100);
   textSize(44);
   
   fill(#F5A30A);
   rect(width/2, 400, 160, 65, 20);
   fill(0);
   text("BACK", width/2, 422);
   if(mouseX > width/2-80 && mouseX < width/2+80 && mouseY > 400-65/2 && mouseY < 400+65/2) {
    fill(255);
    text("BACK", width/2, 422);
  }
}

//playSound plays the sound file that is passed into it.
void playSound(SoundFile sound) {
  sound.play(); 
}

//quit quits the game.
void quit() {
  exit();
}

//mouseClicked is activated with each click of the mouse button.
//Depending on the current screen state, the function will
//either play a sound or set the screen state to another screen
//based on the position of the mouse when it is clicked.
void mouseClicked() {
  //MENU SCREEN
  if(screenState == MENUSCREEN) {
    if(mouseX > width/2-80 && mouseX < width/2+80 && mouseY > 200-65/2 && mouseY < 200+65/2) {
      playSound(blip);
      screenState = GAMESCREEN_EASY; 
    }
  
    if(mouseX > width/2-80 && mouseX < width/2+80 && mouseY > 300-65/2 && mouseY < 300+65/2) {
      playSound(blip);
      screenState = GAMESCREEN_HARD; 
    }
    
    if(mouseX > width/2-80 && mouseX < width/2+80 && mouseY > 400-65/2 && mouseY < 400+65/2) {
      playSound(blip);
      screenState = QUIT; 
    }
    
    if(mouseX > width/2+200-80 && mouseX < width/2+200+80 && mouseY > 400-65/2 && mouseY < 400+65/2) {
      playSound(blip);
      screenState = HELPSCREEN;
    }
    
    if(screenState == QUIT) {
       quit();
    }
  }
  //HELPSCREEN
  if(screenState == HELPSCREEN) {
     if(mouseX > width/2-80 && mouseX < width/2+80 && mouseY > 400-65/2 && mouseY < 400+65/2) {
      playSound(blip);
      screenState = MENUSCREEN; 
    }
  }

}
