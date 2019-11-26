//de powerups die de speler kan kopen
class PowerUp {

  float powerUpTimer;

  float healthExtra = 2;
  boolean laser;


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
    
    //zorgt ervoor dat powerups niet meer frames "gekocht" kunnen worden
    if (powerUpTimer >= 1) {
      powerUpTimer++;
    }
    if (powerUpTimer == 30) {
      powerUpTimer = 0;
    }

    //bullets kunnen door enemy's heen
    if (keysPressed['j'] ||keysPressed['J'] ) {
      laser = true;
    }
    
    
  }
}
