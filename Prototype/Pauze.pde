class Pauze {
  int pauzedTime = 0;
  boolean pauze = false;
  float pauzeX, pauzeY;
  int speedX, speedY;
  int timerPauze = 0;
  int BLACK = 0;
  final int SPEED = 10;
  final int MINX = 10;
  final int MAXX = 1590;
  final int MINY = 10;
  final int MAXY = 790;
  final int TEXTSIZE = 26;
  final int TEXTCOLOR = 250;

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

    if (timerPauze == 0) {
      if ((keysPressed['p']||keysPressed['P']) && pauze == true) {
        pauze= false;
        goSettings =false;
        goAchievement = false;
        timerPauze++;
        timer++;
        if (random(0, 1) >=0.5) {
          clickA.play();
        } else {
          clickB.play();
        }
      } else if ((keysPressed['p']||keysPressed['P']) && pauze == false) {
        pauze= true;
        timerPauze++;
        timer++;
        if (random(0, 1) >=0.5) {
          clickA.play();
        } else {
          clickB.play();
        }
      }
    }
    if (timerPauze == 10) {
      timerPauze = 0;
    }
    if (timerPauze>0) {
      timerPauze++;
    }
    if (pauze ==true) {
      pauzedTime++;
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
      fill(BLACK);
      rect(-1, -1, width+1, height+1);
      image(highscoreTab, width/2, height/2, 721, 750);
      image(movement, width/6, height/2, 350, 350);
      image(shooting, width/6*5, height/2, 350, 350);
      //image(pauzeImg, pauzeX, pauzeY);
      textSize(TEXTSIZE);
      fill(TEXTCOLOR);
      text("Press START to continue", width/18*7, height/14*11);
      text("Press A to change name", width/18*7, height/14*11 + TEXTSIZE*2);
    }
  }
}
