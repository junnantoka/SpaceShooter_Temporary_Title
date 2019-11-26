class Pauze {
  boolean pauze = false;
  float pauzeX, pauzeY;
  int speedX, speedY;
  int timerPauze = 0;
  final int SPEED = 10;
  final int MINX = 10;
  final int MAXX = 1590;
  final int MINY = 10;
  final int MAXY = 790;
  final int TEXTSIZE = 20;
  final int TEXTX = 725;
  final int TEXTY = 610;
  
  void setup() {
    pauzeX = random(MINX, MAXX);
    pauzeY = random(MINY, MAXY);
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
    
    if(timerPauze == 0){
      if ((keyPressed) && pauze == true) {
        pauze= false;
        timerPauze++;
        timer++;
      }else if ((keysPressed['p']||keysPressed['P']) && pauze == false) {
        pauze= true;
        timerPauze++;
      }
    }
    if(!keyPressed){
      timerPauze = 0;
    }
    if (pauze ==true) {
      pauzeX += speedX;
      pauzeY += speedY;
      if (pauzeX -125 <=0 ) {
        speedX = SPEED;
      }
      if (pauzeX + 125 >= width ) {
        speedX = -SPEED;
      }
      if (pauzeY - 25<=0 ) {
        speedY = SPEED;
      }
      if (pauzeY + 25 >= height ) {
        speedY = -SPEED;
      }
    }
  }
  
  void draw() {
    if (pauze == true) {
      image(pauzeImg, pauzeX, pauzeY);
      textSize(TEXTSIZE);
      fill(#FAE523);
      text("press any key to continue", TEXTX, TEXTY);
    }
  }
}
