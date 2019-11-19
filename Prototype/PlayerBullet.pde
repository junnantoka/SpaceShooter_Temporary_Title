//stijns deel
class PlayerBullet {
  float bPLocationX, bPLocationY, bPSize, chSpeedX, chSpeedY, bPXRef, bPYRef, bPXRefEnd, bPYRefEnd, bPLocationXEnd, bPLocationYEnd;
  boolean pBLinks, pBRechts, pBOmhoog, pBNaarbeneden, ja;
  int afstand, snelheid;
  final int maxAfstand = 400;
  final int reset=0;
  final int interval = 10;

  void construct() {
    //sets starting values
    bPLocationX= c.xLocation;
    bPLocationY= c.yLocation;
    bPSize= 30;
    snelheid= 15;
  }

  void draw() {
    //draws green balls
    if (ja) {
      fill(#2DFA46);
      bPXRefEnd= bPXRef - xRef;
      bPYRefEnd= bPYRef - yRef;

      bPLocationXEnd=bPLocationX -bPXRefEnd; 
      bPLocationYEnd=bPLocationY - bPYRefEnd;

      image(playerBullet, bPLocationXEnd, bPLocationYEnd);
    }
  }
  void detectie() {
    //checks if a key is pressed and gives direction to the balls movement
    if (keysPressed[UP]||keysPressed[DOWN]||keysPressed[LEFT]||keysPressed[RIGHT]) {
      pBTimer++;
      if (pBTimer==1) {
        ja = true;
        bPXRef+= xRef;
        bPYRef+= yRef;

        chSpeedX = c.xSpeed/2;
        chSpeedY = c.ySpeed/2;
        if (keysPressed[UP]) {

          pBOmhoog = true;
        } else if (keysPressed[DOWN]) {

          pBNaarbeneden= true;
        }
        if (keysPressed[LEFT]) {

          pBLinks = true;
        } else if (keysPressed[RIGHT]) {

          pBRechts= true;
        } 
        beweging++;
      }

      if (beweging == bullets-1) {
        beweging= reset;
      }

      if ((!keysPressed[UP]&&!keysPressed[DOWN]&&!keysPressed[LEFT]&&!keysPressed[RIGHT])|| pBTimer== interval) {
        pBTimer= reset;
      }
    }
  }
  void move() {
    //moves bullet and returns to begining
    if (ja) {
      bPLocationY+=chSpeedY;
      bPLocationX+=chSpeedX;
      if (pBOmhoog == true) {
        bPLocationY-= snelheid ;
      }
      if (pBLinks == true) {
        bPLocationX-= snelheid;
      }
      if (pBNaarbeneden == true) {
        bPLocationY+= snelheid;
      }
      if (pBRechts == true) {
        bPLocationX+= snelheid;
      }

      afstand++;
      if (afstand == maxAfstand) {
        reset();
      }
    }
  }
  void reset() {
    bPLocationX= c.xLocation;
    bPLocationY= c.yLocation;
    pBNaarbeneden= false;
    pBOmhoog= false;
    pBRechts = false;
    pBLinks = false;
    afstand = reset;
    ja = false;
  }
}
//eind stijns deel
