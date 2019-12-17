class HealthDrop {
  float healthGet = 3;
  float healthX, healthY, healthSize;
  int healthChance;
  boolean spawnHealth;
  int counter;

HealthDrop(float x, float y){
  healthX = x;
  healthY = y;
}
  void healthSetup() {
    healthSize = 100;
    counter =0;
    healthChance = int(random(1,7));
  }

 

  void spawnHealth(int i) {

    //Checks if health can spawn
   

      //if the correct number is selected it spawns health
      if (healthChance == 4) {
        image(healthDropIMG, (healthX + xRef)+wobbleX, (healthY + yRef)+wobbleY, healthSize,healthSize);
        
      } else {
        healthDrop.remove(i);
      }
    }
  

  void updateHealth() {
    //spawns health if the enemy dies
    /*if (i < enemy.size()) {
      if (e.ded) {
        spawnHealth = true;
      }

      if (!spawnHealth) { 
        //sets the health x and y to the killed enemies' x and y
        healthX = e.x;
        healthY = e.y;
      }
    }
    healthCollision();*/
  }

  void healthCollision(int i) {
    //healthX, healthY healthSize
    if (spawnHealth) {
      //if (yRef + healthY + healthSize/2> world.worldHeight/2) {
      //  print("1");
      //  spawnHealth = false;
      //}
      //if (yRef - healthY  - healthSize/2< -world.worldHeight/2 ) {
      //  print("2");
      //  spawnHealth = false;
      //}

      //if (xRef + healthX  + healthSize/2> world.worldWidth/2 ) {
      //  print("3");
      //  spawnHealth = false;
      //}
      //if (xRef - healthX - healthSize/2< -world.worldWidth/2 ) {
      //  print("4");
      //  spawnHealth = false;
      //}
    }
    //checks if the player collides with the healthdrop
    if (dist(healthX + xRef, healthY + yRef, character.xLocation, character.yLocation) <= character.size/2 + healthSize/2 && healthChance == 4) {

      if (healthMax < startingHealth) {
        //gives health when the player collides
        // health += healthGet; 
        healthMax = healthMax + 1;
        healthBarWidth = healthBarWidth + healthLost;
        healthBarXLighting = healthBarXLighting + healthLost;

        //println("darren is de beste");
      }
      healthDrop.remove(i);
      spawnHealth = false;
    }
  }
  void reset() {
  //  for(HealthDrop i : healthDrop){
  //    //i.remove();
  //  }
  //  spawnHealth = false;
  }
}
