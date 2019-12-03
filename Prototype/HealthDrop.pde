class HealthDrop {
  float healthGet = 3;
  float healthX, healthY, healthSize;
  int healthChance;
  boolean spawnHealth;
  int counter;

  void healthSetup() {
    healthSize = 20;
    counter =0;
  }

  void displayHealth() {
    spawnHealth();
  }

  void spawnHealth() {
    if (spawnHealth) {
      counter++;
      if (counter ==1) {
        healthChance = int(random(1, 5));
      }
      if (healthChance == 4) {
        image(healthDropIMG, (healthX + xRef), (healthY + yRef));
      } else {
        spawnHealth = false;
      }
    }
  }

  void updateHealth(int i) {
    if (i< enemy.length) {
      if (enemy[i].ded) {
        spawnHealth = true;
      }
      if (!spawnHealth) {
        healthX = enemy[i].x;
        healthY = enemy[i].y;
      }
    }
    healthCollision();
  }

  void healthCollision() {
    if (dist(healthX + xRef, healthY + yRef, character.xLocation, character.yLocation) <= character.size/2 + healthSize && healthChance == 4) {

      if (healthMax < startingHealth) {
        // health += healthGet; 
        healthMax = healthMax + 1;
        healthBarWidth = healthBarWidth + healthLost;
        healthBarXLighting = healthBarXLighting + healthLost;

       //println("darren is de beste");
      }

      spawnHealth = false;
    }
  }
  void reset(){
    
    spawnHealth = false;
    
  }
}
