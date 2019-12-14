//Make bullets that target the player when it is spawned and then keeps the same speed

class EnemyBullet {
  float bulletX, bulletY, bulletXSpeed, bulletYSpeed, bulletSize;
  int shotIn = 0;
  int distance = 100;
  int timer;
  boolean shot = false;
  boolean timerActive = false;
  int bulletWobbleDuration= 19;
  int bulletIntensity = 14;

  void bulletSetup(int i) {
    Enemy e = enemy.get(i);
    bulletX = e.x;
    bulletY = e.y;
  }

  void draw() {
    if (shot) {
      image(enemyBullet, (xRef + bulletX+wobbleX), (yRef+ bulletY+wobbleY), bulletSize, bulletSize);
    }
  }
  void move(int i) {
    if (shot) {
      // println(bulletYSpeed);
      bulletX+= bulletXSpeed;
      bulletY+= bulletYSpeed;
      collision(i);
      if (timerActive) {
        timer++;
      }
      if (timer == 500) {

        reset(i);
      }
    }
  }

  void bulletSpawn(int i) {
    Enemy e = enemy.get(i);


    if (dist(character.xLocation, character.yLocation, e.x + xRef, e.y + yRef) > distance) {
      shot = true;
      shotIn++;
    }


    if (shotIn == 1) {
      bulletX = e.x;
      bulletY = e.y;

      bulletSize = 65  ;
      bulletYSpeed = (character.yLocation-(bulletY+ yRef))/dist(character.xLocation, character.yLocation, e.x+ xRef, e.y+ yRef)*6;
      bulletXSpeed = (character.xLocation-(bulletX+ xRef))/dist(character.xLocation, character.yLocation, e.x+ xRef, e.y+ yRef)*6;
      //xSpd = (( character.xLocation - (x + xRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * speed;
      //ySpd = (( character.yLocation - (y + yRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * speed;
      timerActive =true;
    }
  }
  void bulletDespawn(int i) {
    //if ((bulletX < -world.worldWidth/2 || bulletX > world.worldWidth) || (bulletY < -world.worldHeight/2 || bulletY > world.worldHeight)) {

    //  reset(i);
    //}
  }
  void collision(int i) {
    if (shot) {

      if (dist(bulletX + xRef, bulletY + yRef, character.xLocation, character.yLocation)< bulletSize/2+character.size/2) {
        healthMax = healthMax - 1;
        healthBarWidth = healthBarWidth-healthLost;
        healthBarXLighting = healthBarXLighting-healthLost;
        wobble.wobble(bulletWobbleDuration, bulletIntensity);
        if (healthBarWidth <= healthBarGone) {
          healthBarWidth = 0;
        }
        reset(i);
      }
    }
  }
  void reset(int i) {
    Enemy e = enemy.get(i);
    bulletX = e.x;
    bulletY = e.y;

    timerActive= false;
    timer =0;
    shot = false;
    shotIn=0;
    bulletYSpeed = 0;
    bulletXSpeed = 0;
  }
}
