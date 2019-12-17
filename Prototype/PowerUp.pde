//de powerups die de speler kan kopen
class PowerUp {

  float powerUpTimer;
  int powerUpNumber;
  float powerUpSize = 80;
  float powerUpX;
  float powerUpY;

  float healthExtra = 2;

  boolean laser;
  boolean laserAvailable = true;

  float bulletSizeMod = 1.2;
  float bulletMaxSize = 170;

  void powerUpInfo(float x, float y) {
        powerUpX = x;
        powerUpY = y;
  }

  void display() {
    for (int i = 0; i < boss.length; i++) {
      if (boss[i].down) {
        switch(powerUpNumber) {
        case 0:
          if (laserAvailable) {
            image(laserPowerUp, powerUpX + xRef + wobbleX, powerUpY + yRef + wobbleY, powerUpSize, powerUpSize);
          }
          
          
          
         
         
         
         
     
        }

        ////meer max health
        //if (keysPressed['h'] ||keysPressed['H'] ) {
        //  powerUpTimer++;
        //  if (powerUpTimer == 1) {
        //    startingHealth+= healthExtra;
        //    healthLost = healthBarWidth/startingHealth;
        //    //println(startingHealth);
        //  }
        //}

        ////bullets kunnen door enemy's heen
        //if (keysPressed['j'] ||keysPressed['J'] ) {
        //  laser = true;
        //}

        ////bigger bullet
        //if (keysPressed['k'] ||keysPressed['K'] ) {
        //  powerUpTimer++;
        //  if (powerUpTimer == 1) {
        //    for(int i = 0; i < bullets; i++){ 
        //      bulletP[i].bPSize *= bulletSizeMod;
        //      if(bulletP[i].bPSize >= bulletMaxSize){
        //        bulletP[i].bPSize = bulletMaxSize;
        //      }

        //      //println(bulletP[i].bPSize);
        //    }
        //  }
        //}


        //zorgt ervoor dat powerups niet meer frames "gekocht" kunnen worden
        if (powerUpTimer >= 1) {
          powerUpTimer++;
        }
        if (powerUpTimer == 30) {
          powerUpTimer = 0;
        }
      }
    }
  }
}
