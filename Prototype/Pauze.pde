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
// when p is pressed the game will stop and the pauze menu will be visible 
// or the game will continue and the pauze menu wil be invisible
    if (timerPauze == 0) {
      if ((keysPressed['p']||keysPressed['P']) && pauze == true) {
        titlescreen.loop();
        altSong.stop();
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
        altSong.loop();
        titlescreen.stop();
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
   
  }

  void draw() {
    if (pauze == true) {
      fill(BLACK);
      rect(-1, -1, width+1, height+1);
      image(highscoreTab, width/2, height/2, 721, 750);
      image(movement, width/6, height/2, 350, 350);
      image(shooting, width/6*5, height/2, 350, 350);
      textSize(TEXTSIZE);
      fill(TEXTCOLOR);
      text("Press START to continue", width/18*7, height/14*11);
      text("Press M to delete data", width/18*7, height/14*11 + TEXTSIZE*2);
    }
  }
}
