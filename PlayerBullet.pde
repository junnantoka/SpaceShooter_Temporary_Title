
//stijns deel
class PlayerBullet {
  float bPLocationX, bPLocationY, bPSize, chSpeedX, chSpeedY;
  boolean pBLinks, pBRechts, pBOmhoog, pBNaarbeneden, ja;
  int afstand, snelheid;
  final int maxAfstand = 400;
  final int reset=0;
  final int interval = 10;
  float bPXRef;
  float bPYRef;
  float bPXRefEnd;
  float bPYRefEnd;
   float bPLocationXEnd, bPLocationYEnd;
  

  void construct() {
    //sets starting values
    bPLocationX = c.xLocation;
    bPLocationY = c.yLocation;
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
      
      ellipse(bPLocationXEnd,bPLocationYEnd, bPSize, bPSize);
      
     
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
        
        if (pBOmhoog == true) {
          bPLocationY-= snelheid;
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
          pBNaarbeneden= false;
          pBOmhoog= false;
          pBRechts = false;
          pBLinks = false;
          afstand = reset;
          ja = false;
        }
        
      } else {
        bPLocationX= c.xLocation;
        bPLocationY= c.yLocation;
      }
    }
  }
  //eind stijns deel
