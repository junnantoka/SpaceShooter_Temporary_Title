class PowerUp {

  float powerUpTimer;

  float healthExtra = 2;
  boolean laser;


  void use() {
    if (keysPressed['h'] ||keysPressed['H'] ) {
      powerUpTimer++;
      if (powerUpTimer == 1) {
        startingHealth+= healthExtra;
        healthLost = healthBarWidth/startingHealth;
        println(startingHealth);
      }
    }
    if (powerUpTimer> 1) {
      powerUpTimer++;
    }
    if (powerUpTimer == 10) {
      powerUpTimer = 0;
    }
    if (keysPressed['j'] ||keysPressed['J'] ) {
      laser = true;
    } 
  }
}
  
