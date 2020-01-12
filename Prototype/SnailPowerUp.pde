class SnailPowerUp {
  boolean snailVisible = false;
  float snailPowerUpTimer = 0;
  float snailPowerUpXSize = 80; //Powerup sprite size.
  float snailPowerUpYSize = 50;
  float snailPowerUpX;
  float snailPowerUpY;

  float snailTimer = 0; //The value the powerup timer will reset to.
  float snailPowerUpDuration = 300; //The powerup lasts 300 ticks.
  boolean snailActivate = false;

  boolean snailCollision; //If this boolean is true, the player can collide with the snail powerup.

  void SnailPowerUpInfo(float x, float y) { //This function is initiated in the boss class. 
    snailPowerUpX = x + random(-700, 700);
    snailPowerUpY = y + random(-700, 700); //When the boss dies, the snail will spawn with 700 coordinates of the death location.
    snailVisible = true;
  }

  void snailPowerUpDate() {

    if (snailActivate) { //A timer for how long the powerup will last.
      snailTimer = snailTimer + 1;
    }
    if (snailTimer >= snailPowerUpDuration) {
      snailActivate = false;
      snailTimer = 0;
    }    

    if (snailActivate) { //If the snail gets activated it will not be visible anymore.
      snailVisible = false;
    }

    if (!snailActivate) { //If the snail is not activated but visible in the playable area, its sprite will be shown.
      if (snailVisible) {
        image(snailgun, snailPowerUpX + xRef + wobbleX + bulletWobbleX, snailPowerUpY + yRef + wobbleY + bulletWobbleY, snailPowerUpXSize, snailPowerUpYSize);
      }
    }

    if (snailVisible) { //The snail powerup changes size so it's differentiated from an enemy sprite.
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
    if (snailVisible) {
      snailCollision = true;
    }
  }

  void collision() {
    if (snailCollision) { //Collision of the snail powerup and player happens here.
      if (dist(snailPowerUpX + xRef, snailPowerUpY + yRef, character.xLocation, character.yLocation) <= character.size/2 + snailPowerUpXSize/2) {
        snailActivate = true;
      }
    }
  }
}
