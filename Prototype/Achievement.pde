class Achievement {

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
        deleteTimer = 0;
      }
      if (dominator) {
        image(checkmark, checkBoxX, 300);
        deleteTimer = 0;
      }
      if (firstDeath) {
        image(checkmark, checkBoxX, 450);
        deleteTimer = 0;
      }
      if (graveyard) {
        image(checkmark, checkBoxX, 600);
        deleteTimer = 0;
      }
      if (getHealth) {
        image(checkmark, checkBoxX, 750);
        deleteTimer = 0;
      }
      if (powerUpObtained) {
        image(checkmark, checkBoxX, 900);
        deleteTimer = 0;
      }

      text("Press r to delete data", 1400, 900);
    }
  }

  void enterAchievement() {
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
    sql();

    if (enemyCounter >= 1) {
      firstKill = true;
    }

    if (enemyCounter >= 50) {
      dominator = true;
    }

    if (healthDropCounter >= 1) {
      getHealth = true;
    }

    if (deathCounter >= 1) {
      firstDeath = true;
    }

    if (deathCounter >= 15) {
      graveyard = true;
    }

    if (powerUpCounter >= 1) {
      powerUpObtained = true;
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
            msql.query("INSERT INTO `zdorpl2`.`User_has_Achievement` (`Chair_nr`, `AchievementID`) VALUES ('1b', '6')");
            firstKillTimer++;
          }
        }
      }
    }
    if (keysPressed['r']||keysPressed['R']) {
      if (deleteTimer == 0) {
        reset();
        msql.query("DELETE FROM User_Has_Achievement WHERE Chair_nr='" + chairNr + "'");
        deleteTimer++;
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
