class Achievement {

  boolean inAchievement = false;

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

  int firstKillTimer;
  int deleteTimer;

  int enemyCounter = 0;
  int healthDropCounter = 0;
  int deathCounter = 0;
  int powerUpCounter = 0;

  void achievementScreen() {
    if (goAchievement) {
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
      for (int i = 0; i < 6; i++) {
        rect(checkBoxX, (i + 1) * achievementDistance, checkBoxSize, checkBoxSize);
      }
      noStroke();

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

      text("Press r to delete data", 1400, 900);
    }
  }

  void enterAchievement() {
    if (keysPressed['v']||keysPressed['V']) {
      timer++;
      if (timer==1) {
        if (!goAchievement) {
          inAchievement = true;
          goAchievement = true;
        } else if (goAchievement) {
          goAchievement =false;
          inAchievement = false;
        }
      }
    } else {
      timer=0;
    }
  }


  void achievementUpdate() {
    achievementCounter();
    sql();

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
    if (keysPressed['u']||keysPressed['U']) {
      if (msql.connect()) {

        //TODO: obtain achievement data



        //TODO: Upload achievement data
        if (firstKill) {
          if (firstKillTimer==0) {
            msql.query("INSERT INTO `zdorpl2`.`User_has_Achievement` (`Chair_nr`, `AchievementID`) VALUES ('" + chairNr + "', '2')");
            firstKillTimer++;
          }
        }
      }
    }
    //deletion off data
    if (keysPressed['r']||keysPressed['R']) {
      if (msql.connect()) {
        if (deleteTimer == 0) {
          reset();
          msql.query("DELETE FROM User_has_Achievement WHERE Chair_nr='" + chairNr + "'");
          deleteTimer++;
        }
      }
    }
  }

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
  }
}
