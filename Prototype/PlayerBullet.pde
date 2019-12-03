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
    bPLocationX = character.xLocation;
    bPLocationY = character.yLocation;
    bPSize = 150;
    snelheid = 30;
  }

  void draw() {
    //draws green balls
    if (ja) {
      fill(#2DFA46);
      bPXRefEnd = bPXRef - xRef;
      bPYRefEnd = bPYRef - yRef;

      bPLocationXEnd = bPLocationX - bPXRefEnd; 
      bPLocationYEnd = bPLocationY - bPYRefEnd;

      image(playerBullet, bPLocationXEnd, bPLocationYEnd, bPSize, bPSize);
    }
  }
  void detectie() {
    //checks if a key is pressed and gives direction to the balls movement
    if (keysPressed[UP] || keysPressed[DOWN] || keysPressed[LEFT] || keysPressed[RIGHT]) {
      pBTimer++;
      
      if (pBTimer==1) {
        ja = true;
        bPXRef+= xRef;
        bPYRef+= yRef;
        bPLocationX = character.xLocation;
        bPLocationY = character.yLocation;
        chSpeedX = character.xSpeed/2;
        chSpeedY = character.ySpeed/2;
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
    else if (pBTimer> 0){
      pBTimer++;
    }
    if ( pBTimer== interval) {
        pBTimer= reset;
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
      if (afstand == maxAfstand|| (bPLocationXEnd <= 0 && bPLocationXEnd >= width && bPLocationYEnd <= 0 && bPLocationYEnd >= height)) {
        reset();
      }
    }
  }
  void reset() {
    bPLocationX = character.xLocation;
    bPLocationY = character.yLocation;
    pBNaarbeneden= false;
    pBOmhoog= false;
    pBRechts = false;
    pBLinks = false;
    afstand = reset;
    ja = false;
    bPSize= 150;
    snelheid= 30;
    bPXRefEnd = 0; 
    bPXRef = 0;
    bPYRefEnd = 0; 
    bPYRef = 0;
  }
}
//eind stijns deel
