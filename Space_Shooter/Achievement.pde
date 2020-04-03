class Achievement {
  int achievementTimer = 0;
  boolean inAchievement = false;
  
  //Text and visual variables
  int textX = 300;
  int descriptionAdd = 35;
  int checkBoxSize = 40;
  int checkBoxX = 1000;
  int achievementDistance = 150;

  //All achievement booleans
  boolean dominator;
  boolean firstKill;
  boolean getHealth;
  boolean firstDeath;
  boolean powerUpObtained;
  boolean graveyard;

  //Timers so achievement queries cannot be run more then nessecary, saving resources and thus prefenting lag
  int firstKillTimer = 0;
  int dominatorTimer = 0;
  int getHealthTimer = 0;
  int firstDeathTimer = 0;
  int powerUpObtainedTimer = 0;
  int graveyardTimer = 0;

  int deleteTimer;
  int updateTimer;
  
  //Counters for achievements
  int enemyCounter = 0;
  int healthDropCounter = 0;
  int deathCounter = 0;
  int powerUpCounter = 0;
  
  //Achievement SELECT query variables
  int achievementNumber;
  String selectQuery = "SELECT u.Chair_nr, a.AchievementID FROM User u " +
    "INNER JOIN User_has_Achievement a ON u.Chair_nr = a.Chair_nr " +
    "WHERE a.Chair_nr = '"+chairNr+"' AND a.Obtained = 'Yes' " +
    "ORDER BY a.AchievementID ASC";


  void achievementScreen() {
    //displays general text and if the user has an achievement a checkmark to indicate
    if (goAchievement) {
      noFill();
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
      for (int i = 0; i < 6; i++) {
        rect(checkBoxX, (i + 1) * achievementDistance, checkBoxSize, checkBoxSize);
      }
      
      if (firstKill) {
        image(checkmark, checkBoxX, 150);
      }
      if (dominator) {
        image(checkmark, checkBoxX, 300);
      }
      if (firstDeath) {
        image(checkmark, checkBoxX, 450);
      }
      if (graveyard) {
        image(checkmark, checkBoxX, 600);
      }
      if (getHealth) {
        image(checkmark, checkBoxX, 750);
      }
      if (powerUpObtained) {
        image(checkmark, checkBoxX, 900);
      }
      text("Press u to update data", 1400, 800);
      text("Press r to delete data", 1400, 900);
    }
  }

  //Used for entering the achievement screen
  void enterAchievement() {
    if (keysPressed['v']||keysPressed['V']) {     
      achievementTimer++;
      if (achievementTimer==1 && !goAchievement && !inAchievement) {
        inAchievement = true;
        goAchievement = true;
      } else if (achievementTimer==1 && goAchievement && inAchievement) {
        goAchievement =false;
        inAchievement = false;
        
      }
    } else {
      achievementTimer=0;
    }
  }


  void achievementUpdate() {
    achievementCounter();
    sql();
    resetAchievements();
    
    //"Obtains" achievements if the gets them whilst playing
    if (enemyCounter >= 1) {
      firstKill = true;
      deleteTimer = 0;
    }

    if (enemyCounter >= 50) {
      dominator = true;
      deleteTimer = 0;
    }

    if (healthDropCounter >= 1) {
      getHealth = true;
      deleteTimer = 0;
    }

    if (deathCounter >= 1) {
      firstDeath = true;
      deleteTimer = 0;
    }

    if (deathCounter >= 15) {
      graveyard = true;
      deleteTimer = 0;
    }

    if (powerUpCounter >= 1) {
      powerUpObtained = true;
      deleteTimer = 0;
    }
  }

  void achievementCounter() {
    for (HealthDrop i : healthDrop) {
      if (i.healthPickedUp) {
        healthDropCounter++;
      }
    }
  }

  void sql() {
    if (goAchievement) {
      if (keysPressed['u']||keysPressed['U']) {
        if (msql.connect()) {
          
          //Checks the database for if the user already has an achievement
          if (updateTimer == 0) {                    
            achievementNumber = 1;
            msql.query(selectQuery);
            
            
            while (msql.next()) {

              int achievementGot = msql.getInt("AchievementID");
              
              
              //If the achievement data obtained from the database matches an achievement locally it updated the achievement to be true
              if (achievementGot == 1) {
                enemyCounter = 1;
              }
              if (achievementGot == 2) {
                enemyCounter = 50;
              }
              if (achievementGot == 3) {
                deathCounter = 1;
              }
              if (achievementGot == 4) {
                deathCounter = 15;
              }
              if (achievementGot == 5) {
                healthDropCounter = 1;
              }
              if (achievementGot == 6) {
                powerUpCounter = 1;
              }
            }
            
            updateTimer++;
          }


          //Upload achievement data upon updating the database if the user has said achievement
          if (firstKill) {
            if (firstKillTimer == 0) {
              msql.query("UPDATE User_has_Achievement SET Obtained = 'Yes' WHERE Chair_nr = '"+chairNr+"' AND AchievementID = '1'");
              firstKillTimer++;
            }
          }
          if (dominator) {
            if (dominatorTimer == 0) {
              msql.query("UPDATE User_has_Achievement SET Obtained = 'Yes' WHERE Chair_nr = '"+chairNr+"' AND AchievementID = '2'");
              dominatorTimer++;
            }
          }
          if (firstDeath) {
            if (firstDeathTimer == 0) {
              msql.query("UPDATE User_has_Achievement SET Obtained = 'Yes' WHERE Chair_nr = '"+chairNr+"' AND AchievementID = '3'");
              firstDeathTimer++;
            }
          }
          if (graveyard) {
            if (graveyardTimer == 0) {
              msql.query("UPDATE User_has_Achievement SET Obtained = 'Yes' WHERE Chair_nr = '"+chairNr+"' AND AchievementID = '4'");
              graveyardTimer++;
            }
          }
          if (getHealth) {
            if (getHealthTimer == 0) {
              msql.query("UPDATE User_has_Achievement SET Obtained = 'Yes' WHERE Chair_nr = '"+chairNr+"' AND AchievementID = '5'");
              getHealthTimer++;
            }
          }
          if (powerUpObtained) {
            if (powerUpObtainedTimer == 0) {
              msql.query("UPDATE User_has_Achievement SET Obtained = 'Yes' WHERE Chair_nr = '"+chairNr+"' AND AchievementID = '6'");
              powerUpObtainedTimer++;
            }
          }
        } else print("COULD NOT CONNECT TO DATABASE");
          msql.close();
      }
    }
  }
  
  //If the user wants they have the option to delete all achievement data to start over
  void resetAchievements() {
    if (goAchievement) {
      if (keysPressed['r']||keysPressed['R']) {
        if (msql.connect()) {
          reset();
          for (int i = 1; i < 7; i++) {
            msql.query("UPDATE User_has_Achievement SET Obtained = 'No' WHERE Chair_nr = '"+chairNr+"' AND AchievementID = '"+i+"'");
          }
        }
        msql.close();
      }
    }
  }

  //If the user doesn't exist adds achievement data with value No
  void insertData() {
      for (int i = 1; i < 7; i++) {
        msql.query("INSERT INTO `zdorpl2`.`User_has_Achievement` (`Chair_nr`, `AchievementID`, `Obtained`) VALUES ('" + chairNr + "', '"+i+"', 'No')");
    }
  }

  //Deletes the userdata when all userdata gets deleted
  void deleteUserAchiements() {
    if (msql.connect()) {
      if (deleteTimer == 0) {
        reset();
        msql.query("DELETE FROM User_has_Achievement WHERE Chair_nr='" + chairNr + "'");
        deleteTimer++;
      }
    }
    msql.close();
  }

  //Resets all data
  void reset() {
    dominator = false;
    firstKill = false;
    getHealth = false;
    firstDeath = false;
    powerUpObtained = false;
    graveyard = false;

    enemyCounter = 0;
    healthDropCounter = 0;
    deathCounter = 0;
    powerUpCounter = 0;

    firstKillTimer = 0;
    dominatorTimer = 0;
    getHealthTimer = 0;
    firstDeathTimer = 0;
    powerUpObtainedTimer = 0;
    graveyardTimer = 0;

    updateTimer = 0;
  }
}
