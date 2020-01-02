class Achievement {

  int textX = 300;
  int descriptionAdd = 35;
  int checkBoxSize = 40;
  
  //All achievement booleans
  boolean dominator;
  boolean firstKill;
  boolean getHealth;
  boolean firstDeath;
  boolean powerUpObtained;
  boolean graveyard;

  int enemyCounter = 0;
  int healthDropCounter = 0;
  int deathCounter = 0;
  int powerUpCounter = 0;

  void achievementScreen(){
   if(goAchievement){
    textSize(42);
    text("Learning the Basics", textX, 150);
    text("Dominator", textX, 300);
    text("It's all downhill from here", textX, 450);
    text("Graveyard", textX, 600);
    text("Slice of Life", textX, 750);
    text("POWAAHHHH", textX, 900);
    
    textSize(32);
    fill(206);
    text("Your first enemy kill", textX, 150 + descriptionAdd);
    text("Kill 50 enemies", textX, 300 + descriptionAdd);
    text("Oops, you died", textX, 450 + descriptionAdd);
    text("Die 15 times", textX, 600 + descriptionAdd);
    text("Pick up a healthdrop", textX, 750 + descriptionAdd);
    text("Pick up a powerup", textX, 900 + descriptionAdd);
    
    noFill();
    stroke(255);
    strokeWeight(5);
    for(int i = 0; i < 6; i++){
      rect(1200, (i + 1) * 150, checkBoxSize, checkBoxSize);
    }
    noStroke();
    
    
    
   }
  }

  void enterAchievement(){
    if (keysPressed['v']||keysPressed['V']) {
      timer++;
      if (timer==1) {
        if (!goAchievement) {
          goAchievement = true;
        } else if (goAchievement) {
          goAchievement =false;
        }
      }
    } else {
      timer=0;
    }
  }

  void achievementUpdate() {
    achievementCounter();
    
    if(enemyCounter >= 1){
     firstKill = true; 
     println("lamo");
    }
    
    if(enemyCounter >= 50){
      dominator = true;
    }
    
    if(healthDropCounter >= 1){
      getHealth = true;
    }
    
    if(deathCounter >= 1){
      firstDeath = true;
    }
    
    if(deathCounter >= 15){
      graveyard = true;
    }
    
    if(powerUpCounter >= 1){
      powerUpObtained = true;
    }
    
    
  }
  
  void achievementCounter(){
    for (HealthDrop i : healthDrop) {
      if(i.healthPickedUp){
        healthDropCounter++;
      }
    }  
  }
  
}
