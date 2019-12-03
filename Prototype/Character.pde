Particle[] particle;
float startX, startY;
float angleMove, jitterMove, anglePlayer, jitterPlayer;
boolean moving = false;

int particles = 100;
class Character {

  //character variables
  float xLocation, acc;
  float yLocation;
  int size=100;
  int maxSpeed=15;
  int yDir=0;
  int xDir=0;
  float ySpeed=0;
  float xSpeed=0;
  boolean yMove, xMove, newP;
  float slowDown = 1;
  float rotateSpeed = 1;

  //particle vars
  int pCount, pInterval;
  int frame;

  void construct() {

    yLocation = height/2;
    xLocation = width/2;

    pInterval = 1;
    particle = new Particle[particles];
    for (int i = 0; i < particle.length; i++) {
      particle[i] = new Particle();
    }
    acc = 2;

    yRef = height/2;
    xRef = width/2;
    startX = xRef;
    startY = yRef;
  }
  void displayCh() {
    fill(255);

    //particles 
    for (int i = 0; i<particle.length; i++) {
      particle[i].display();
    }


    angleMove = angleMove + jitterMove;
    float playerMoveRotation = angleMove;
    translate(xLocation, yLocation);

    if (moving) {
      jitterMove =  0.07;
      rotate(playerMoveRotation);
    }

    imageMode(CENTER);
    

    if (!start.start) {
      jitterPlayer =  0.05;
    anglePlayer = anglePlayer + jitterPlayer;
    float playerRotation = anglePlayer;
    rotate(playerRotation);
      image(playerShip, 0, 0);
    }
  }


  void moveCh() {
    //particles 
    for (int i = 0; i<particle.length; i++) {
      particle[i].move();
    }

    yRef -= ySpeed;
    xRef -= xSpeed;

    if (keysPressed['w']||keysPressed['W']) {
      moving = true;
      ySpeed-= acc;
      yDir = 1;
      newP = true;
      if (ySpeed < -maxSpeed) {
        ySpeed = -maxSpeed;
      }
    } else if ((!keysPressed['w'] || !keysPressed['W'])&& ySpeed < 0 ) {
      moving = false;
      ySpeed+=slowDown;
    }

    if (keysPressed['s'] || keysPressed['S']) {
      moving = true;
      ySpeed+= acc;
      yDir= 2;      
      newP = true;
      if (ySpeed > maxSpeed) {
        ySpeed = maxSpeed;
      }
    } else if ((!keysPressed['s'] || !keysPressed['S']) && ySpeed > 0) {
      moving = false;
      ySpeed-= slowDown;
    }

    if (keysPressed['a']||keysPressed['A']) {
      moving = true;
      xSpeed-= acc;
      xDir = 1;      
      newP = true;
      if (xSpeed < -maxSpeed) {
        xSpeed = -maxSpeed;
      }
    } else if ((!keysPressed['w'] || !keysPressed['W']) && xSpeed < 0) {
      moving = false;
      xSpeed+= slowDown;
    }

    if (keysPressed['d']||keysPressed['D']) {
      moving = true;
      xSpeed+= acc;
      xDir= 2;      
      newP = true;
      if (xSpeed > maxSpeed) {
        xSpeed = maxSpeed;
      }
    } else if ((!keysPressed['d']||!keysPressed['D'])&& xSpeed > 0) {
      moving = false;
      xSpeed-= slowDown;
    }
    if (!keysPressed['w'] && !keysPressed['W'] && !keysPressed['s'] && !keysPressed['S'] && ySpeed > -slowDown && ySpeed < slowDown) {
      ySpeed = 0;
    }
    if (!keysPressed['a'] && !keysPressed['A'] && !keysPressed['d'] && !keysPressed['D'] && xSpeed > -slowDown && xSpeed < slowDown) {
      xSpeed = 0;
    }


    if (!keysPressed['w'] && !keysPressed['W'] && !keysPressed['a'] && !keysPressed['A'] && !keysPressed['s']&&!keysPressed['S']&&!keysPressed['d']&&!keysPressed['D']) {
      newP = false;
    }

    if (newP) {
      frame++;
      if (frame > pInterval) {
        particle[pCount].construct();
        frame = 0;
        pCount++;
      }
      if (pCount >= particle.length) {
        pCount = 0;
      }
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
  void reset() {
    ySpeed = 0;
    xSpeed = 0;
  }
}
