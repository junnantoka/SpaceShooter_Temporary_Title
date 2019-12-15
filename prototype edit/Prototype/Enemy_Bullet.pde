//Make bullets that target the player when it is spawned and then keeps the same speed

class EnemyBullet {
  float bulletX, bulletY, bulletXSpeed, bulletYSpeed, bulletSize;
  int shotIn = 0;
  int distance = 100;
  int timer;
  boolean shot = true;
  boolean timerActive = true;
  int bulletWobbleDuration= 19;
  int bulletIntensity = 14;
  EnemyBullet(float x, float y) {
    bulletX = x;
    bulletY = y;
    bulletYSpeed = (character.yLocation-(bulletY+ yRef))/dist(character.xLocation, character.yLocation, x+ xRef, y+ yRef)*6;
    bulletXSpeed = (character.xLocation-(bulletX+ xRef))/dist(character.xLocation, character.yLocation, x+ xRef, y+ yRef)*6;
    bulletSize = 65;
  }
  

  void draw() {
    image(enemyBullet, (xRef + bulletX+wobbleX), (yRef+ bulletY+wobbleY), bulletSize, bulletSize);
    
  }
  void move(int i) {

    // println(bulletYSpeed);
    bulletX+= bulletXSpeed;
    bulletY+= bulletYSpeed;
    collision(i);
    if (timerActive) {
      timer++;
    }
    if (timer == 500) {

      eBullet.remove(i);
    }
  }

  
  
  void collision(int i) {
    

      if (dist(bulletX + xRef, bulletY + yRef, character.xLocation, character.yLocation)< bulletSize/2+character.size/2) {
        healthMax = healthMax - 1;
        healthBarWidth = healthBarWidth-healthLost;
        healthBarXLighting = healthBarXLighting-healthLost;
        wobble.wobble(bulletWobbleDuration, bulletIntensity);
        if (healthBarWidth <= healthBarGone) {
          healthBarWidth = 0;
        }
        eBullet.remove(i);
      }
    }
  
  
}
