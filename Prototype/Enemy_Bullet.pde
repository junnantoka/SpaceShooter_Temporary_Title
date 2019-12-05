//Make bullets that target the player when it is spawned and then keeps the same speed

class EnemyBullet {
  float bulletX, bulletY, bulletXSpeed, bulletYSpeed, bulletSize;
  int shotIn = 0;
  int distance = 100;
  int timer;
  boolean shot = false;
  boolean timerActive = false;

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
void move() {
   // println(bulletYSpeed);
    bulletX+= bulletXSpeed;
    bulletY+= bulletYSpeed;
    collision();
    if (timerActive) {
      timer++;
    }
    if (timer == 360) {

      reset();
    }
  }

  void bulletSpawn(int i) {
    
    
    if (dist(character.xLocation, character.yLocation, enemy[i].x + xRef, enemy[i].y + yRef) > distance) {
        shot = true;
        shotIn++;
        }
      
    
    if (shotIn == 1) {
      bulletX = enemy[i].x;
      bulletY = enemy[i].y;
      bulletSize = 100;
      bulletYSpeed = (character.yLocation-(bulletY+ yRef))/dist(character.xLocation, character.yLocation, enemy[i].x+ xRef, enemy[i].y+ yRef)*6;
      bulletXSpeed = (character.xLocation-(bulletX+ xRef))/dist(character.xLocation, character.yLocation, enemy[i].x+ xRef, enemy[i].y+ yRef)*6;
      //xSpd = (( character.xLocation - (x + xRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * speed;
      //ySpd = (( character.yLocation - (y + yRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * speed;
      timerActive =true;
    }
  }
  void bulletDespawn() {
    if ((bulletX < -world.worldWidth/2 || bulletX > world.worldWidth) || (bulletY < -world.worldHeight/2 || bulletY > world.worldHeight)) {
      
      reset();
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
  void reset() {
    for (int i = 0; i<enemy.length; i++) {
      bulletX = enemy[i].x;
      bulletY = enemy[i].y;
    }
    timerActive= false;
    timer =0;
    shot = false;
    shotIn=0;
    bulletYSpeed = 0;
    bulletXSpeed = 0;
  }
}
