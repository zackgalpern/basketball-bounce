class Scoreboard {
  
  int currScore;
  int easyHighScore;
  int hardHighScore;
  
  //the Scoreboard constructor sets the current score equal to 0.
  Scoreboard() {
    currScore = 0;
  }
  
  //drawScoreboard draws the scoreboard in the upper right
  //corner of the game window. It displays the current score
  //and will update with each score change.
  void drawScoreboard() {
    fill(0);
    rectMode(CENTER);
    square(width-60, 60, 120);
    
    fill(#F5A30A);
    textSize(24);
    text("SCORE", width-60, height/6-40);
    setScore(currScore);
  }
  
  //getter
  int getScore() {
    return currScore; 
  }
  
  //setter which also prints the score to the scoreboard.
  void setScore(int score) {
    currScore = score; 
    
    fill(#F5A30A);
    textSize(48);
    text(score, width-60, height/5+5);
  }
  
  //setHighScore sets the high score depending on the game mode
  //that was chosen by the player.
  void setHighScore(int score, int level) {
    if(level == 1)
      easyHighScore = score;
    if(level == 2)
      hardHighScore = score;
  }
  
  //printHighScore prints the high score, depending on which
  //level was chosen, to the Menu screen.
  void printHighScore(int level) {
    if(level == 1) { //easy
      fill(255);
      textSize(24);
      String s = "Easy High Score:" + easyHighScore;
      text(s, width/2, height/2-80);
    }
    if(level == 2) { //hard
      fill(255);
      textSize(24);
      String s = "Hard High Score:" + hardHighScore;
      text(s, width/2, height/2+26);
    }
  }
  
  //updateScore increments the current score by 1 and then
  //sets the score equal to the current score.
  void updateScore() {
    currScore++;
    setScore(currScore);
  }
  
  //isHighScore checks, based on which game mode was chosen
  //by the player, if a certain score is higher than the
  //previous high score. It returns true if the score is indeed
  //the new high score, and false otherwise.
  boolean isHighScore(int score, int level) {
    if(level == 1) {
      if(score > easyHighScore) {
        easyHighScore = score;
        return true;
      }
      else
        return false;
    }
    else
      if(score > hardHighScore) {
        hardHighScore = score;
        return true;
      }
      else
        return false;
  }
  
}
