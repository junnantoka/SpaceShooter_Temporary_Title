class End {

  boolean end, button = false;
  int timerEnd= 0;
  int opacityGameOver, opacityTitleCard,  opacityStarting, opacitycontrols=0;
  void setup() {
  }

  void draw() {
    timerEnd++;
    if ( timerEnd <=50){
    fill(255, 0, 0, opacityGameOver);
    textSize(100);
    opacityGameOver+= 10;
    
    text("GAME OVER", width/3+10, height/2+50);
    }
    if (timerEnd >=50){
    fill(255);
    opacityTitleCard+= 3;
    textSize(150);
    tint(255, opacityTitleCard);
    image(titleCard,width / 2, height/4);
    }
    if (timerEnd >=65){
      opacityStarting+= 3;
      tint(255, opacityStarting);
    image(startImg, width / 2, height/ 2 +200, 500,300);
    }
    if (timerEnd >=80){
      opacitycontrols+= 3;
      tint(255, opacitycontrols);
    image(movement, width/4-75, height/2, 500, 500);
    image(shooting, width/4*3+75, height/2, 500, 500);
    }
     tint(255, 255);
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
    timerEnd= 0;
    opacityGameOver=0; 
    opacityTitleCard=0;   
    opacityStarting =0; 
    opacitycontrols=0; 
    for(int i = enemy.size()-1; i >=0; i--){
      enemy.remove(i);
    }
    for (int i = healthDrop.size()-1; i >=0 ; i--) { 
      healthDrop.remove(i);
    }
    
    for(int i = eBullet.size()-1; i >=0; i--){
      eBullet.remove(i);
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
     wobbleX= 0;
     wobbleY= 0;
     wobbleTimer = 0;
    for (int i =0; i < boss.length; i++) {
      boss[i].reset();
    }
    wave.reset();
    
    for(int i = 0; i < star.length; i++){
      star[i].construct();
    }
  }
}
