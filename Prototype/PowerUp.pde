//de powerups die de speler kan kopen
class PowerUp {

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

  void powerUpInfo(float x, float y) {
    powerUpX = x;
    powerUpY = y;
  }

  void powerUpDate() {
    for (int i = 0; i < boss.length; i++) {
      if (boss[i].down) {
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
      }
    }
  }

  void display() {
    collision();
    for (int i = 0; i < boss.length; i++) {
      if (boss[i].down) {
        switch(powerUpNumber) {
        case 0:
          if (laserAvailable) {
            lasercollision = true;
            image(laserPowerUp, powerUpX + xRef + wobbleX, powerUpY + yRef + wobbleY, powerUpSize, powerUpSize);
          }
          break;
        case 1:
          image(healthup, powerUpX + xRef + wobbleX, powerUpY + yRef + wobbleY, powerUpSize, powerUpSize);
        }



        ////meer max health
        //    startingHealth+= healthExtra;
        //    healthLost = healthBarWidth/startingHealth;


        ////bigger bullet   
        //    for(int i = 0; i < bullets; i++){ 
        //      bulletP[i].bPSize *= bulletSizeMod;
        //      if(bulletP[i].bPSize >= bulletMaxSize){
        //        bulletP[i].bPSize = bulletMaxSize;
      }
    }
  }

  void collision() {
    if (lasercollision) {
      if (dist(powerUpX + xRef, powerUpY + yRef, character.xLocation, character.yLocation) <= character.size/2 + powerUpSize/2) {
        laser = true;
        laserAvailable = false;
        powerUpNumber++;
       
      }
    }
  }

  void effect() {
  }
}
