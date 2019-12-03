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
    
    //Checks if health can spawn
    if (spawnHealth) {
      counter++;
      if (counter ==1) {
        
        //A random function to make a 1/4 chance of health to spawn
        healthChance = int(random(1, 5));
      }
      
      //if the correct number is selected it spawns health
      if (healthChance == 4) {
        image(healthDropIMG, (healthX + xRef), (healthY + yRef));
      } else {
        spawnHealth = false;
      }
    }
  }

  void updateHealth(int i) {
    
    //spawns health if the enemy dies
    if (i< enemy.length) {
      if (enemy[i].ded) {
        spawnHealth = true;
      }
      
      if (!spawnHealth) { 
        //sets the health x and y to the killed enemies' x and y
        healthX = enemy[i].x;
        healthY = enemy[i].y;
      }
    }
    healthCollision();
  }

  void healthCollision() {
    
    //checks if the player collides with the healthdrop
    if (dist(healthX + xRef, healthY + yRef, character.xLocation, character.yLocation) <= character.size/2 + healthSize && healthChance == 4) {

      if (healthMax < startingHealth) {
        //gives health when the player collides
        // health += healthGet; 
        healthMax = healthMax + 1;
        healthBarWidth = healthBarWidth + healthLost;
        healthBarXLighting = healthBarXLighting + healthLost;

       println("darren is de beste");
      }

      spawnHealth = false;
    }
  }
  void reset(){
    
    spawnHealth = false;
    
  }
}
