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

  float bulletSizeMod = 1.2;
  float bulletMaxSize = 170;
  
  //variables for laserbeam
  float x, y, size, radius;
  int red, green, blue, colorTimer, frames, seconds;
  boolean laserPickUp;
  int chance = 1;
  final int LASERSIZE = 50;
  final int SEC = 60;
  
  PowerUp(){
    size = random(25, 100);
    radius = size / 2;
    laserPickUp = false;
  }

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
        image(healthup, powerUpX + xRef + wobbleX, powerUpY + yRef + wobbleY, powerUpSize, powerUpSize);
      }
    }
  }

  void collision() {
    if (lasercollision) {
      if (dist(powerUpX + xRef, powerUpY + yRef, character.xLocation, character.yLocation) <= character.size/2 + powerUpSize/2) {
        laser = true;
        laserAvailable = false;
        active= false;
        achievement.powerUpCounter++;
        powerUpNumber++;   
      }
    }
  }
}
