//stijns deel
class PlayerBullet {
  float bPLocationX, bPLocationY, bPSize, chSpeedX, chSpeedY, bPXRef, bPYRef, bPXRefEnd, bPYRefEnd, bPLocationXEnd, bPLocationYEnd, sideVariationX, sideVariationY;
  boolean pBLinks, pBRechts, pBOmhoog, pBNaarbeneden, shoot;
  int afstand, snelheid;
  final int maxAfstand = 400;
  final int reset = 0;
  final int interval = 10;

  void construct() {
    //sets starting values
    bPLocationX = character.xLocation;
    bPLocationY = character.yLocation;
    bPSize = 75;
    snelheid = 30;
  }

  void draw() {
    //draws bullets
    if (shoot) {
      fill(#2DFA46);

      image(playerBullet, bPLocationXEnd+wobbleX, bPLocationYEnd+wobbleY, bPSize, bPSize);
    }
  }

  void detectie() {

    //checks if a key is pressed and gives direction to the balls movement
    if (keysPressed[UP] || keysPressed[DOWN] || keysPressed[LEFT] || keysPressed[RIGHT]) {
      pBTimer++;
      if (pBTimer == 1) {
        reset();
        
        bPXRef += xRef;
        bPYRef += yRef;
        bPLocationX = character.xLocation;
        bPLocationY = character.yLocation; 
        chSpeedX = character.xSpeed/2;
        chSpeedY = character.ySpeed/2;
        wobble.wobble(2, 3);

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
    }  
    if ((!keysPressed[UP] && !keysPressed[DOWN] && !keysPressed[LEFT] && !keysPressed[RIGHT])|| pBTimer== interval) {
      pBTimer = reset;
    } else if (pBTimer> 0) {
      pBTimer++;
    }
    if (pBTimer == interval) {
      pBTimer = reset;
    }
  }
  void move() {
    //moves bullet and returns to begining
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
    bPLocationX = character.xLocation;
    bPLocationY = character.yLocation;
    pBNaarbeneden = false;
    pBOmhoog = false;
    pBRechts = false;
    pBLinks = false;
    afstand = reset;
    shoot = false;
    bPSize = 75;
    snelheid = 30;
    bPXRefEnd = 0; 
    bPXRef = 0;
    bPYRefEnd = 0; 
    bPYRef = 0;
  }
}
//eind stijns deel
