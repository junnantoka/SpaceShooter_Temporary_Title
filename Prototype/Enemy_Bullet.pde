//Make bullets that target the player when it is spawned and then keeps the same speed

class EnemyBullet {
  float bulletX, bulletY, bulletXSpeed, bulletYSpeed, bulletSize;
  int shotIn = 0;
  int distance = 100;
  boolean shot = false;
  
  void bulletSetup() {
    for (int i = 0; i<enemy.length; i++) {
      bulletX = enemy[i].x;
      bulletY = enemy[i].x;
    }
  }

  void draw() {
    if (shot) {
      image(enemyBullet, (xRef + bulletX), (yRef+ bulletY), bulletSize, bulletSize);
    }
  }


  void bulletSpawn(int i) {
    collision();

    if (dist(character.xLocation, character.yLocation, enemy[i].x + xRef, enemy[i].y + yRef) > distance) {
      shot = true;
      shotIn++;
    }
    if (shotIn == 1) {
      bulletX = enemy[i].x;
      bulletY = enemy[i].y;
      bulletSize = 100;
      bulletYSpeed = (character.yLocation-bulletY)/dist(character.xLocation, character.yLocation, enemy[i].x, enemy[i].y)*6;
      bulletXSpeed = (character.xLocation-bulletX)/dist(character.xLocation, character.yLocation, enemy[i].x, enemy[i].y)*6;
    }
    if (shot) {
      //bullet movement here!
      bulletX=bulletX + bulletXSpeed;
      bulletY=bulletY + bulletYSpeed;
    }
  }
  void bulletDespawn() {
    if ((bulletX < -world.worldWidth/2 || bulletX > world.worldWidth) || (bulletY < -world.worldHeight/2 || bulletY > world.worldHeight)) {
      shot = false;
      shotIn = 0;
    }
  }
  void collision() {
    if (dist(bulletX + xRef, bulletY + yRef, character.xLocation, character.yLocation)< bulletSize/2+character.size/2) {
      healthMax = healthMax - 1;
      healthBarWidth = healthBarWidth-healthLost;
              healthBarXLighting = healthBarXLighting-healthLost;

      if (healthBarWidth <= healthBarGone) {
        healthBarWidth = 0;
      }
      shot = false;
      shotIn = 0;
    }
  }
  void reset(){
    for (int i = 0; i<enemy.length; i++) {
      bulletX = enemy[i].x;
      bulletY = enemy[i].x;
    }
  }
}
