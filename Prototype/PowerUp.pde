//de powerups die de speler kan kopen
class PowerUp {
  boolean active = false;
  float powerUpTimer = 0;
  int powerUpNumber;
  float powerUpSize = 80;
  float powerUpX;
  float powerUpY;

  float healthExtra = 2;

  boolean laser;
  boolean laserAvailable = true;
  boolean lasercollision;

  boolean healthAvailable;
  boolean healthCollision;

  boolean bulletUpAvailable;
  boolean bulletUpCollision;
  float bulletSizeMod = 1.2;
  float bulletMaxSize = 170;


  void powerUpInfo(float x, float y) {
    powerUpX = x;
    powerUpY = y;
    active = true;
  }

  void powerUpDate() {
    if (active) {
      if (powerUpTimer < 60) {
        powerUpTimer++;
        powerUpSize += 0.5;
      }
      if (powerUpTimer >= 60) {
        powerUpTimer ++;
        powerUpSize -= 0.5;
      }
      if (powerUpTimer == 120) {
        powerUpTimer = 0;
      }
      collision();
    }
  }


  void display() {
    if (active) {
      switch(powerUpNumber) {

      case 0:
        if (laserAvailable) {
          lasercollision = true;
          image(laserPowerUp, powerUpX + xRef + wobbleX+bulletWobbleX, powerUpY + yRef + wobbleY+bulletWobbleY, powerUpSize, powerUpSize);
        }
        break;

      case 1:
        if (healthAvailable) {
          image(healthup, powerUpX + xRef + wobbleX, powerUpY + yRef + wobbleY, powerUpSize, powerUpSize);

          healthCollision = true;
        }
        break;

      case 2:
        if (bulletUpAvailable) {
          image(bulletSizeUp, powerUpX + xRef + wobbleX, powerUpY + yRef + wobbleY, powerUpSize, powerUpSize);
          bulletUpCollision = true;
        }
      }


      ////bigger bullet   
      //    for(int i = 0; i < bullets; i++){ 
      //      bulletP[i].bPSize *= bulletSizeMod;
      //      if(bulletP[i].bPSize >= bulletMaxSize){
      //        bulletP[i].bPSize = bulletMaxSize;
    }
  }

  void collision() {

    if (dist(powerUpX + xRef, powerUpY + yRef, character.xLocation, character.yLocation) <= character.size/2 + powerUpSize/2) {
      if (lasercollision) {
        laser = true;
        laserAvailable = false;
        lasercollision = false;

        healthAvailable = true;
      }
      if (healthCollision) {
        healthMax++;
        startingHealth++;
        healthAvailable = false;
        healthCollision = false;

        bulletUpAvailable = true;
      }
      if (bulletUpCollision) {
        for (int i = 0; i < bullets; i++) { 
          bulletP[i].bPSize *= bulletSizeMod;

          if (bulletP[i].bPSize >= bulletMaxSize) {
            bulletP[i].bPSize = bulletMaxSize;
          }

          bulletUpAvailable = false;
          bulletUpCollision = false;
        }

        active= false;
        achievement.powerUpCounter++;
        powerUpNumber++;
      }
    }
  }
}
