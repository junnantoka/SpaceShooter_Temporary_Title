class HealthDrop {
  //general variables
  float healthGet = 3;
  float healthX, healthY, healthSize;
  int healthChance;
  boolean spawnHealth;
  boolean healthPickedUp = false;
  int Hparticles = 9;
   
   //sets the x and y to the dead enemy's x and y
   HealthDrop(float x, float y) {
    healthX = x;
    healthY = y;
  }
  
  void healthSetup() {
    //sets the size and the spawnchance
    healthSize = 100;
    healthChance = int(random(1, 10));
  }

  void spawnHealth(int i) {

    //if the correct number is selected it spawns health
    if (healthChance == 4) {
      image(healthDropIMG, (healthX + xRef)+wobbleX+bulletWobbleX, (healthY + yRef)+wobbleY+bulletWobbleY, healthSize, healthSize);
    } else {
      healthDrop.remove(i);
    }
  }


  void healthCollision(int i) {
    //checks if the player collides with the healthdrop
    if (dist(healthX + xRef, healthY + yRef, character.xLocation, character.yLocation) <= character.size/2 + healthSize/2 && healthChance == 4) {
      //Spawns a healthdrop particles when healthdrop is picked up.
      for (int in = 0; in < Hparticles; in++) {
        healthDropParticles.add(new HealthDropParticle(healthX+random(-character.size/2,character.size/2), healthY+random(-character.size/2,character.size/2), 10, 7));
      }

      if (healthMax < startingHealth) {
        //gives health when the player collides
      
        healthMax++;
        healthBarWidth = healthBarWidth + healthLost;
        healthBarXLighting = healthBarXLighting + healthLost;

      }
      //removes healthdrop when picked up
      healthPickedUp = true;
      healthDrop.remove(i);
      spawnHealth = false;
    }
  }
}
