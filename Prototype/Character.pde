class Character {

  //character variables
  float xLocation;
  float yLocation;
  int size=100;
  int maxSpeed=15;
  int yDir=0;
  int xDir=0;
  float ySpeed=0;
  float xSpeed=0;
  boolean yMove, xMove;
  float slowDown = 0.5;
  
  float rotateSpeed = 1;
  
  void construct() {
    yLocation=height/2;
    xLocation=width/2;
  }
  void displayCh() {
    fill(255);
    //rotate(radians(rotateSpeed));
    imageMode(CENTER);
    image(playerShip, xLocation, yLocation);
    
    //circle(xLocation, yLocation, size);
    
  }


  void moveCh() {
    yRef -= ySpeed;
    xRef -= xSpeed;

    if (keysPressed['w']||keysPressed['W']) {
      ySpeed-= 2;
      yDir = 1;
      if (ySpeed < -maxSpeed) {
        ySpeed = -maxSpeed;
      }
    } 
    else if ((!keysPressed['w']||!keysPressed['W'])&& ySpeed < 0 && yDir == 1) {
      ySpeed+=slowDown;
    }

    if (keysPressed['s']||keysPressed['S']) {
      ySpeed+= 2;
      yDir= 2;
      if (ySpeed > maxSpeed) {
        ySpeed = maxSpeed;
      }
    } 
    else if ((!keysPressed['s']||!keysPressed['S'])&& ySpeed > 0 && yDir == 2) {
      ySpeed-= slowDown;
    }

    if (keysPressed['a']||keysPressed['A']) {
      xSpeed-= 2;
      xDir = 1;
      if (xSpeed < -maxSpeed) {
        xSpeed = -maxSpeed;
      }
    } 
    else if ((!keysPressed['w']||!keysPressed['W'])&& xSpeed < 0 && xDir == 1) {
      xSpeed+= slowDown;
    }

    if (keysPressed['d']||keysPressed['D']) {
      xSpeed+= 2;
      xDir= 2;
      if (xSpeed > maxSpeed) {
        xSpeed = maxSpeed;
      }
    } 
    else if ((!keysPressed['d']||!keysPressed['D'])&& xSpeed > 0 && xDir == 2) {
      xSpeed-= slowDown;
    }
  }
  //is de chCollision niet ded codesd
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
  void reset(){
    ySpeed = 0;
    xSpeed = 0;
  }
}
