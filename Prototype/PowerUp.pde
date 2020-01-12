//de powerups die de speler kan kopen
class PowerUp {

  //overall powerup variables
  boolean active = false;
  float powerUpTimer = 0;
  int powerUpNumber;
  float powerUpSize = 80;
  float powerUpX;
  float powerUpY;

  //laser variables
  boolean laser;
  boolean laserAvailable = true;
  boolean lasercollision;
  
  //health variables
  float healthExtra = 2;
  boolean healthAvailable;
  boolean healthCollision;
  
  //bulletsize variables
  boolean bulletUpAvailable;
  boolean bulletUpCollision;
  float bulletSizeMod = 1.3;
  float bulletMaxSize = 170;

  //activates the powerup class and sets the x and y to the boss' x and y
  void powerUpInfo(float x, float y) {
    powerUpX = x;
    powerUpY = y;
    active = true;
  }

  void powerUpDate() {
    //hover effect for the powerups
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
      //switch for powerups to show
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
          image(bulletSizeUp, powerUpX + xRef + wobbleX, powerUpY + yRef + wobbleY);
          bulletUpCollision = true;
        }
      }
    }
  }

  void collision() {
    //collision detection for powerups and runs the appropriate code
    if (dist(powerUpX + xRef, powerUpY + yRef, character.xLocation, character.yLocation) <= character.size/2 + powerUpSize/2) {
      if (lasercollision) {
        laser = true;
        laserAvailable = false;
        lasercollision = false;

        healthAvailable = true;
      }
      if (healthCollision) {
        healthMax++;
        startingHealth += healthExtra;
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
      }
      
      //resets powerup so it'll be activated again when the next boss dies
      active = false;
      achievement.powerUpCounter++;
      powerUpNumber++;
    }
  }
}
