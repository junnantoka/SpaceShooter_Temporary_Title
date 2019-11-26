class End {
  
  boolean end, button = false;
  void setup() {
    
  }
  
  void draw() {
    fill(255, 0, 0);

    text("GAME OVER", 100, 100);
    fill(255);
    rect(width / 2 - 100, height/ 2 - 50, 200, 100);
    fill(0);
    textSize(20);
    text("press p to restart", width / 2 - 80, height/ 2);
  }

  void update() {
    if (keysPressed['p']||keysPressed['P']) {
      end = false;
      reset();
      timer++;
    }
  }
  
  void reset() {
    for (int i = 0; i <enemy.length; i++) {
      enemy[i].reset();
    }
    for (int i = 0; i < healthDrop.length; i++) { 
      healthDrop[i].reset();
    }
    for (int i = 0; i <eBullet.length; i++) {
      eBullet[i].reset();
    }
    
    health.reset();
    highscore.score = 0;
    highscore.reset();
    yRef = 0;
    xRef = 0;
    
    for (int i = 0; i <bulletP.length; i++) {
      bulletP[i].reset();
    }
    character.reset();
  }
}
