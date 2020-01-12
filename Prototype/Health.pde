
float startingHealth = 10000; //Deze integer geeft aan hoeveel health je aan het begin hebt.


float healthMax; 
boolean getsHit = false; //Deze boolean is false, omdat je niet geraakt wordt door een enemy.
int healthBarX = 50; //coordination of healthbar
int healthBarY = 25;
float healthBarWidth = 500;
float healthLost;
int healthBarHeight = 30;

float healthBarXLighting = 500; //Lighting.
float healthBarYLighting = 27;
final int healthBarGone = 49; //Dit voorkomt dat de healthbar een - getal wordt.
class Health {
  int enemyWobbleDuration = 10;
  int enemyIntensity = 15;

  float healthWarningStart = (startingHealth / 100) * 30;
  int healthWarningTimer;

  void setup() {
    healthMax = startingHealth; //Starting health can't be higher than the maximum.
    healthLost = healthBarWidth / startingHealth;
  }

  void draw() {
    rectMode(0);
    noStroke();
    fill(100);
    rect(healthBarX + wobbleX + bulletWobbleX, healthBarY + wobbleY + bulletWobbleY, 500, healthBarHeight);

    fill(255, 0, 0);
    rect(healthBarX + wobbleX + bulletWobbleX, healthBarY + wobbleY + bulletWobbleY, healthBarWidth, healthBarHeight);

    fill(255, 215, 215);
    rect(healthBarX + wobbleX + bulletWobbleX, healthBarYLighting + wobbleY + bulletWobbleY, healthBarXLighting, 5);

    image(healthBar, 300 + wobbleX + bulletWobbleX, 30 + wobbleY + bulletWobbleY, 515, 55);
  }

  void collide() { //Hier wordt de collision van de player met de enemy getest. 
    for (int i = 0; i< enemy.size(); i++) {
      Enemy e = enemy.get(i);
      if (dist(e.x + xRef, e.y + yRef, character.xLocation, character.yLocation) <= character.size/2 + e.radius) {
        e.ded = true;
        enemy.remove(e);
        healthMax = healthMax - 1;
        healthBarWidth = healthBarWidth-healthLost; //Als de player geraakt wordt zal de health omlaag gaan.
        healthBarXLighting = healthBarXLighting-healthLost;
        wobble.wobble(enemyWobbleDuration, enemyIntensity);
        if (healthBarWidth <= healthBarGone) {
          healthBarWidth = 0;
          healthBarXLighting = 0;
        }
      }
    }
  }

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
  void reset() {
    healthMax = startingHealth; //De health wordt hier gereset als de "play again" knop wordt ingedrukt.

    healthBarXLighting = 500;
    healthBarWidth = 500;
    healthBarHeight = 30;
    healthBarX = 50;
    healthBarY = 25;
  }

  void healthWarning() {
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
