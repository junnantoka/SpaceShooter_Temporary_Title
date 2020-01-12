boolean wobbleShot = false;
int wobbleShotTimer = 0;
int bulletWobbleX, bulletWobbleY = 0;
int visibilitybullet =3;
class PlayerBullet {
  float bPLocationX, bPLocationY, bPSize, chSpeedX, chSpeedY, bPXRef, bPYRef, bPXRefEnd, bPYRefEnd, bPLocationXEnd, bPLocationYEnd, sideVariationX, sideVariationY;
  boolean pBLinks, pBRechts, pBOmhoog, pBNaarbeneden, shoot;
  int afstand, snelheid;
  final int maxAfstand = 400;
  final int reset = 0;
  final int interval = 10;
  int makingSound = 0;
  int visibilityTimer = 0;

  void construct() {
    //sets starting values
    bPLocationX = width/2;
    bPLocationY = height/2;
    bPSize = 75;
    snelheid = 30;
  }

  void draw() {
    //draws bullets
    if (shoot) {
      if (visibilityTimer <visibilitybullet) {
        visibilityTimer++;
      }
      if (visibilityTimer ==visibilitybullet) {
        image(playerBullet, bPLocationXEnd+wobbleX+bulletWobbleX, bPLocationYEnd+wobbleY+bulletWobbleY, bPSize, bPSize);
      }
    }
  }

  void detectie() {




    //checks if a key is pressed and gives direction to the bullets movement
    if (keysPressed[UP] || keysPressed[DOWN] || keysPressed[LEFT] || keysPressed[RIGHT]) {
      pBTimer++;
      if (pBTimer == 1) {
        reset();
        if (!(bPLocationX == width/2)) {
        }
        bPXRef = xRef;
        bPYRef = yRef;
        chSpeedX = character.xSpeed/2;
        chSpeedY = character.ySpeed/2;
        wobbleShotTimer = 1;
        wobbleShot = true;
        if (!pew.isPlaying()) {
          pew.loop();
        }
        if (keysPressed[UP]) {

          sideVariationY = random(-10, 10);

          pBOmhoog = true;
        } else if (keysPressed[DOWN]) {

          sideVariationY = random(-10, 10);
          pBNaarbeneden = true;
        }
        if (keysPressed[LEFT]) {

          sideVariationX = random(-10, 10);
          pBLinks = true;
        } else if (keysPressed[RIGHT]) {

          sideVariationX = random(-10, 10);
          pBRechts = true;
        } 
        beweging++;
        shoot = true;
      }

      if (beweging == bullets-1) {
        beweging = reset;
      }
    } else {
      pew.stop();
    }
    if ((!keysPressed[UP] && !keysPressed[DOWN] && !keysPressed[LEFT] && !keysPressed[RIGHT])|| pBTimer== interval) {
      pBTimer = reset;
    } else if (pBTimer> 0) {
      pBTimer++;
    }
    if (pBTimer == interval) {
      pBTimer = reset;
    }
    wobble ();
  }
  void move() {
    //moves bullet and returns to begining after having travelled a certain distance
    if (shoot) {
      bPLocationY += chSpeedY;
      bPLocationX += chSpeedX;

      bPXRefEnd = bPXRef - xRef;
      bPYRefEnd = bPYRef - yRef;

      bPLocationXEnd = bPLocationX - bPXRefEnd; 
      bPLocationYEnd = bPLocationY - bPYRefEnd;

      if (pBOmhoog == true) {
        bPLocationY -= snelheid ;
      }
      if (pBLinks == true) {
        bPLocationX -= snelheid;
      }
      if (pBNaarbeneden == true) {
        bPLocationY += snelheid;
      }
      if (pBRechts == true) {
        bPLocationX += snelheid;
      }

      bPLocationY += sideVariationX;

      bPLocationX += sideVariationY;

      afstand++;
      if (afstand == maxAfstand|| (bPLocationXEnd <= 0 && bPLocationXEnd >= width && bPLocationYEnd <= 0 && bPLocationYEnd >= height)) {
        reset();
      }
    }
  }
  void reset() {
 //sets all values back to original values
    bPLocationX = width/2;
    bPLocationY = height/2;
    pBNaarbeneden = false;
    pBOmhoog = false;
    pBRechts = false;
    pBLinks = false;
    afstand = reset;
    shoot = false;
    snelheid = 30;
    bPXRefEnd = 0; 
    bPXRef = 0;
    bPYRefEnd = 0; 
    bPYRef = 0;
    visibilityTimer=0;
    makingSound = 0;
  }
  void wobble () {
    //makes the screen shake
    if (wobbleShotTimer ==0) {
      bulletWobbleX = 0;
      bulletWobbleY = 0;
    }
    if (wobbleShotTimer == 1) { 
      if (keysPressed[UP]) {

        bulletWobbleY = 10;
      } else if (keysPressed[DOWN]) {

        bulletWobbleY = -10;
      }
      if ( keysPressed[LEFT]) {
        bulletWobbleX = 10;
      } else if ( keysPressed[RIGHT]) {
        bulletWobbleX = -10;
      }
      wobbleShotTimer--;
    }
  }
}
