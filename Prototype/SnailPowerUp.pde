
class SnailPowerUp {

  float snailPowerUpTimer = 0;
  int snailPowerUpNumber;
  float snailPowerUpXSize = 80;
  float snailPowerUpYSize = 50;
  float snailPowerUpX;
  float snailPowerUpY;
  
  float snailPowerUpDuration = 750;
  float snailTimer = 0;
  boolean snailActivate = false;

  boolean laser;
  boolean laserAvailable = true;
  boolean lasercollision;

  float bulletSizeMod = 1.2;
  float bulletMaxSize = 170;

  void SnailPowerUpInfo(float x, float y) {
    snailPowerUpX = x;
    snailPowerUpY = y;
  }

  void snailPowerUpDate() {
    if(snailActivate) {
      snailTimer = snailTimer + 1;
    }
    if(snailTimer >= snailPowerUpDuration) {
     snailActivate = false; 
    }
      
    
    for (int i = 0; i < boss.length; i++) {
      if (boss[i].down) {
        if (snailPowerUpTimer < 60) {
          snailPowerUpTimer++;
          snailPowerUpXSize += 0.5;
          snailPowerUpYSize += 0.3;
        }
        if (snailPowerUpTimer >= 60) {
          snailPowerUpTimer ++;
          snailPowerUpXSize -= 0.5;
          snailPowerUpYSize -= 0.3;
        }
        if (snailPowerUpTimer == 120) {
          snailPowerUpTimer = 0;
        }
      }
    }
  }

  void display() {
    collision();
    for (int i = 0; i < boss.length; i++) {
      if (boss[i].down) {
        switch(snailPowerUpNumber) {
        case 0:
          if (laserAvailable) {
            lasercollision = true;
            image(snailgun, snailPowerUpX + xRef + wobbleX, snailPowerUpY + yRef + wobbleY, snailPowerUpXSize, snailPowerUpYSize);
          }
        }
      }
    }
  }

  void collision() {
    if (lasercollision) {
      if (dist(snailPowerUpX + xRef, snailPowerUpY + yRef, character.xLocation, character.yLocation) <= character.size/2 + snailPowerUpXSize/2) {
        snailActivate = true;
        laser = true;
        laserAvailable = false;
        snailPowerUpNumber++;          
        
      }
    }
  }

  void effect() {
  }
}
