class Start {
  boolean start = true;

  void draw() {
    textSize(150);
    image(titleCard,width / 2, height/4);
    image(startImg, width / 2, height/ 2 +200, 500,300);
    image(movement, width/4-75, height/2, 500,500);
    image(shooting, width/4*3+75, height/2, 500,500);
  }

  void update() {
    //Detect if the game can start
    if (keysPressed['P']||keysPressed['p']) {
      firstScreen.stop();
      titlescreen.loop();
      start = false;
      goSettings =false;
      goAchievement = false;
      timer++;
      if (random(0, 1) >=0.5) {
        clickA.play();
      } else {
        clickB.play();
      }
    }
  }
}