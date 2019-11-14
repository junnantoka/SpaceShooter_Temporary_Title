class Character {

  //character variables
  float xLocation;
  float yLocation;
  int size=100;
  int maxSpeed=10;
  int yDir=0;
  int xDir=0;
  float ySpeed=0;
  float xSpeed=0;
  float healthLost;
  boolean yMove, xMove;
  float slowDown = 0.5;
  
  void construct(){
    yLocation = height / 2;
    xLocation = width / 2;
  }
  
  void displayCh() {
    fill(255);
    circle(xLocation, yLocation, size);
  }

  void moveCh() {
    yRef -= ySpeed;
    xRef -= xSpeed;
    
    if (keysPressed['w']||keysPressed['W']) {
      ySpeed--;
      yDir = 1;
      if (ySpeed < -maxSpeed) {
        ySpeed = -maxSpeed;
      }
    } else if ((!keysPressed['w']||!keysPressed['W'])&& ySpeed < 0 && yDir == 1) {
      ySpeed+=slowDown;
    }

    if (keysPressed['s']||keysPressed['S']) {
      ySpeed++;
      yDir= 2;
      if (ySpeed > maxSpeed) {
        ySpeed = maxSpeed;
      }
    } else if ((!keysPressed['s']||!keysPressed['S'])&& ySpeed > 0 && yDir == 2) {
      ySpeed-= slowDown;
    }
    
    if (keysPressed['a']||keysPressed['A']) {
      xSpeed--;
      xDir = 1;
      if (xSpeed < -maxSpeed) {
        xSpeed = -maxSpeed;
      }
    } else if ((!keysPressed['w']||!keysPressed['W'])&& xSpeed < 0 && xDir == 1) {
      xSpeed+= slowDown;
    }

    if (keysPressed['d']||keysPressed['D']) {
      xSpeed++;
      xDir= 2;
      if (xSpeed > maxSpeed) {
        xSpeed = maxSpeed;
      }
    } else if ((!keysPressed['d']||!keysPressed['D'])&& xSpeed > 0 && xDir == 2) {
      xSpeed-= slowDown;
    }
  }
  void chCollision() {
    if (xLocation+(size/2)>width) {
      xSpeed=0;
      xLocation--;
    }
    if (xLocation-(size/2)<0) {
      xSpeed=0;
      xLocation++;
    }
    if (yLocation+(size/2)>height) {
      ySpeed=0;
      yLocation--;
    }
    if (yLocation-(size/2)<0) {
      ySpeed=0;
      yLocation++;
    }
  }
  //©Nordin El Hadaoui
  void playerHealth() { 
    if (health <= 3) { //start with 3 health, healthbar is full
      fill(255, 0, 0);
      stroke(255);
      rect(250, 50, 300, 25);
    }
    if (health <= 2) {
      fill(0);
      rect(350, 50, 100, 25);
    }
    if (health <= 1) {
      fill(0);
      rect(300, 50, 200, 25);
    }
    if (health <= 0) { //when health reaches 0, game ends
      textSize(100);
      fill(0);
      rect(250, 50, 300, 25);
      fill(255);
      text("GAME OVER", 800, 200);
      frameRate(0);
      if (h.score>h.highscoreOnStartup) {
        h.highscore[0] = h.score;
        saveStrings("Highscore.txt", str(h.highscore));
      }
    }
  }
}
