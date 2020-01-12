float startingHealth = 10; //This is your health in total.

float healthMax; 
boolean getsHit = false; //This boolean turns true if you get hit by an enemy.
int healthBarX = 50; //The X and Y locations of the healthbar.
int healthBarY = 25;
float healthBarWidth = 500; //The width and hight of the healthbar.
int healthBarHeight = 30;
float healthLost;

float healthBarXLighting = 500; //White edge around the healthbar for better visuals.
float healthBarYLighting = 27;
final int healthBarGone = 49; //The healthbar will get deleted if it reaches this point.

class Health {
  int enemyWobbleDuration = 10;
  int enemyIntensity = 15;

  float healthWarningStart = (startingHealth / 100) * 30;
  int healthWarningTimer;

  void setup() {
    healthMax = startingHealth; //Starting health can't be higher than the maximum.
    healthLost = healthBarWidth / startingHealth; 
    //This is a flexible way of losing health. The healthbar width is 500. The starting health can be set to any value. 
    //For example, if the starting health is set to 30, the health lost will be 1/30 of the health bar width.
  }

  void draw() {
    rectMode(0);
    noStroke();
    fill(100); //The healthbar gets drawn.
    rect(healthBarX + wobbleX + bulletWobbleX, healthBarY + wobbleY + bulletWobbleY, 500, healthBarHeight);

    fill(255, 0, 0);
    rect(healthBarX + wobbleX + bulletWobbleX, healthBarY + wobbleY + bulletWobbleY, healthBarWidth, healthBarHeight);

    fill(255, 215, 215);
    rect(healthBarX + wobbleX + bulletWobbleX, healthBarYLighting + wobbleY + bulletWobbleY, healthBarXLighting, 5);

    image(healthBar, 300 + wobbleX + bulletWobbleX, 30 + wobbleY + bulletWobbleY, 515, 55);
  }

  //Player - enemy collision is done in the health class for convenience.
  void collide() {
    for (int i = 0; i< enemy.size(); i++) {
      Enemy e = enemy.get(i);
      if (dist(e.x + xRef, e.y + yRef, character.xLocation, character.yLocation) <= character.size/2 + e.radius) {
        e.dead = true;
        enemy.remove(e);
        healthMax = healthMax - 1;
        healthBarWidth = healthBarWidth-healthLost; //If the player gets hit, health will be lost.
        healthBarXLighting = healthBarXLighting-healthLost;
        wobble.wobble(enemyWobbleDuration, enemyIntensity);
        if (healthBarWidth <= healthBarGone) {
          healthBarWidth = 0;
          healthBarXLighting = 0;
        }
      }
    }
  }

  //A health achievement
  int deathCounterTimer = 0;
  void gameOver() {
    if (healthMax <= 0) {
      end.end = true;
      deathCounterTimer++;
      if (deathCounterTimer == 1) {
        achievement.deathCounter++;
      }
      //highscore.highscoreSave();
      if (keyPressed) {
        end.button = true;
      }
    } else {
      deathCounterTimer = 0;
    }
  }
  //If the game resets, so does the healthbar
  void reset() {
    healthMax = startingHealth; //De health wordt hier gereset als de "play again" knop wordt ingedrukt.

    healthBarXLighting = 500;
    healthBarWidth = 500;
    healthBarHeight = 30;
    healthBarX = 50;
    healthBarY = 25;
  }

  void healthWarning() {
    //Warns the player when health is too low
    if ((healthMax <= healthWarningStart) && !end.end) {

      if (healthWarningTimer < 80) {
        image(enemyBullet, 75 + wobbleX + bulletWobbleX, 120 + wobbleY + bulletWobbleY, 120, 120);
        image(healthWarning, 75 + wobbleX + bulletWobbleX, 120 + wobbleY + bulletWobbleY, 70, 70);
        healthWarningTimer++;
      }

      if (healthWarningTimer < 120) {
        healthWarningTimer++;
      }

      if (healthWarningTimer == 120) {
        healthWarningTimer = 0;
      }
    }
  }
}
