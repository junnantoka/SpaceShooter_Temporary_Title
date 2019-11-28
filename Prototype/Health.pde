int startingHealth = 10;

float healthMax;
boolean getsHit = false;
int healthBarX = 50;
int healthBarY = 25;
int healthBarWidth = 500;
int healthLost;
int healthBarHeight = 30;

int healthBarXLighting = 500;
int healthBarYLighting = 27;

final int healthBarGone = 49;

class Health {

  void setup() {
    healthMax = startingHealth;
    healthLost = healthBarWidth/startingHealth;
  }

  void draw() {
    rectMode(0);
    noStroke();
    fill(100);
    rect(healthBarX, healthBarY, 500, healthBarHeight);

    fill(255, 0, 0);
    rect(healthBarX, healthBarY, healthBarWidth, healthBarHeight);

    fill(255, 215, 215);
    rect(healthBarX, healthBarYLighting, healthBarXLighting, 5);

    image(healthBar, 300, 30, 515, 55);
  }

  void collide() {
    for (int i = 0; i<enemy.length; i++) {
      if (dist(enemy[i].x + xRef, enemy[i].y + yRef, character.xLocation, character.yLocation) <= character.size/2 + enemy[i].radius) {
        enemy[i].ded = true;
        healthMax = healthMax - 1;
        healthBarWidth = healthBarWidth-healthLost;
        healthBarXLighting = healthBarXLighting-healthLost;

        if (healthBarWidth <= healthBarGone) {
          healthBarWidth = 0;
          healthBarXLighting = 0;
        }
      }
    }
  }

  void gameOver() {
    if (healthMax <= 0) {
      end.end = true;
      highscore.highscoreSave();
      if (keyPressed) {
        end.button = true;
      }
    }
  }
  void reset() {
    healthMax = startingHealth;

    healthBarXLighting = 500;
    healthBarWidth = 500;
    healthBarHeight = 30;
    healthBarX = 50;
    healthBarY = 25;
  }
}
