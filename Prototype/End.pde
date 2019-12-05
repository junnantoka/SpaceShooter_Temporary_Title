class End {

  boolean end, button = false;
  void setup() {
  }

  void draw() {
    fill(255, 0, 0);
    textSize(100);
    text("GAME OVER", width/2, height/3);
    fill(255);

    image(startImg, width / 2, height/ 2, 500,300);

  }

  void update() {
    //detect of het spel verder mag van de speler
    if (keysPressed['p']||keysPressed['P']) {
      end = false;
      reset();
      timer++;
      if (random(0, 1) >=0.5) {
        clickA.play();
      } else {
        clickB.play();
      }
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

    for (int i = 0; i < bulletP.length; i++) {
      bulletP[i].reset();
    }
    wave.construct();
    character.reset();
    bossTotal= 1;
    enemyCounter= 0;
    enemiesRequired =enemiesRequiredStart;
    bossSpawn =false;
    for (int i =0; i < boss.length; i++) {
      boss[i].reset();
    }
  }
}
