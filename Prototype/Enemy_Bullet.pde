//Make bullets that target the player when it is spawned and then keeps the same speed


class EnemyBullet {
  float bulletX, bulletY, bulletXSpeed, bulletYSpeed, bulletSize;
  int shotIn = 0;
  int distance = 100;
  boolean shot = false;
  void bulletSetup() {
    for (int i = 0; i<e.length; i++) {
      bulletX = e[i].x;
      bulletY = e[i].x;
    }
  }

void draw(){
  if (shot) {
      fill(255, 0, 0);
      circle(xRef + bulletX, yRef+ bulletY, bulletSize);
  }
}


  void bulletSpawn(int i) {
    collision();

    if (dist(c.xLocation, c.yLocation, e[i].x + xRef, e[i].y + yRef)>distance) {
      shot = true;
      shotIn++;
    }
    if (shotIn == 1) {
      bulletX = e[i].x;
      bulletY = e[i].y;
      bulletSize = 10;
      bulletYSpeed = (c.yLocation-bulletY)/dist(c.xLocation, c.yLocation, e[i].x, e[i].y)*2;
      bulletXSpeed = (c.xLocation-bulletX)/dist(c.xLocation, c.yLocation, e[i].x, e[i].y)*2;
    }
     if (shot) {
      //bullet movement here!
      bulletX=bulletX + bulletXSpeed;
      bulletY=bulletY + bulletYSpeed;
    }
  }
  void bulletDespawn() {
    if ((bulletX<0||bulletX>width)||(bulletY<0||bulletY>height)) {
      shot = false;
      shotIn = 0;
    }
  }
  void collision() {
    if (dist(bulletX + xRef, bulletY + yRef, c.xLocation, c.yLocation)< bulletSize/2+c.size/2) {
      health = health - 1;
      healthBarWidth = healthBarWidth-healthLost;
      if(healthBarWidth <= healthBarGone) {
        healthBarWidth = 0;
      }
      shot = false;
      shotIn = 0;
    }
  }
}
