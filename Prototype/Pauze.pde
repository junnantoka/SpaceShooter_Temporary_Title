class Pauze {
  boolean pauze = false;
  float pauzeX;
  float pauzeY;
  int speedX;
  int speedY;
  int timer = 0;
  final int SPEED = 10;
  void setup() {
    pauzeX = random(10, 1590);
    pauzeY = random(10, 790);
    if (random(1, 2) >= 1.5) {
      speedX = SPEED;
    } else {
      speedX = -SPEED;
    }
    if (random(1, 2) >= 1.5) {
      speedY = SPEED;
    } else {
      speedY = -SPEED;
    }
  }
  void pauzeGame() {
    
    if(timer == 0){
    if ((keyPressed) && pauze == true) {
      pauze= false;
      timer++;
 
    }
    else if ((keysPressed['p']||keysPressed['P']) && pauze == false) {
      pauze= true;
      timer++;
    }
   
    }
     if(!keyPressed)timer = 0;
    if (pauze ==true) {
      pauzeX += speedX;
      pauzeY += speedY;

      if (pauzeX <=0 ) {
        speedX = SPEED;
      }
      if (pauzeX + 250 >=1600 ) {
        speedX = -SPEED;
      }
      if (pauzeY <=0 ) {
        speedY = SPEED;
      }
      if (pauzeY + 50 >= 900 ) {
        speedY = -SPEED;
      }
    }
  }
  void draw() {
    if (pauze== true) {
      image(pauzeImg, pauzeX, pauzeY);
      textSize(20);
      fill(#FAE523);
      text("press any key to continue", 725, 610);
    }
  }
}
