class Achievement {

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
    textSize(28);
    text("peopkaas", 500, 500);
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
