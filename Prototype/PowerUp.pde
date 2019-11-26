//de powerups die de speler kan kopen
class PowerUp {

  float powerUpTimer;

  float healthExtra = 2;
  boolean laser;
  float bulletSizeMod = 1.2;
  float bulletMaxSize = 170;



  void use() {
    //meer max health
    if (keysPressed['h'] ||keysPressed['H'] ) {
      powerUpTimer++;
      if (powerUpTimer == 1) {
        startingHealth+= healthExtra;
        healthLost = healthBarWidth/startingHealth;
        println(startingHealth);
      }
    }
    
    //bullets kunnen door enemy's heen
    if (keysPressed['j'] ||keysPressed['J'] ) {
      laser = true;
    }
    
    //bigger bullet
    if (keysPressed['k'] ||keysPressed['K'] ) {
      powerUpTimer++;
      if (powerUpTimer == 1) {
        for(int i = 0; i < bullets; i++){ 
          bulletP[i].bPSize *= bulletSizeMod;
          if(bulletP[i].bPSize >= bulletMaxSize){
            bulletP[i].bPSize = bulletMaxSize;
          }
          println(bulletP[i].bPSize);
        }
      }
    }

    
    //zorgt ervoor dat powerups niet meer frames "gekocht" kunnen worden
    if (powerUpTimer >= 1) {
      powerUpTimer++;
    }
    if (powerUpTimer == 30) {
      powerUpTimer = 0;
    }

  }
}
