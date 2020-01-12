class SnailPowerUp {
  boolean active = false;
  float snailPowerUpTimer = 0;
  float snailPowerUpXSize = 80;
  float snailPowerUpYSize = 50;
  float snailPowerUpX;
  float snailPowerUpY;

  float snailTimer = 0;
  float snailPowerUpDuration = 300;
  boolean snailActivate = false;

  boolean snailCollision;

  void SnailPowerUpInfo(float x, float y) {
    snailPowerUpX = x + random(-700, 700);
    snailPowerUpY = y + random(-700, 700);
    active = true;
  }

  void snailPowerUpDate() {

    if (snailActivate) {
      snailTimer = snailTimer + 1;
    }
    if (snailTimer >= snailPowerUpDuration) {
      snailActivate = false;
      snailTimer = 0;
    }    

    if (snailActivate) {
      active = false;
    }

    if (!snailActivate) {
      if (active) {
        image(snailgun, snailPowerUpX + xRef + wobbleX + bulletWobbleX, snailPowerUpY + yRef + wobbleY + bulletWobbleY, snailPowerUpXSize, snailPowerUpYSize);
      }
    }

    if (active) {
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

  void display() {
    collision();
    if (active) {
      snailCollision = true;
    }
  }

  void collision() {
    if (snailCollision) {
      if (dist(snailPowerUpX + xRef, snailPowerUpY + yRef, character.xLocation, character.yLocation) <= character.size/2 + snailPowerUpXSize/2) {
        snailActivate = true;
        //snailAvailable = false;
      }
    }
  }
}
