final int startingHealth = 5;

float health;
boolean getsHit = false;
int healthBarX = 50;
int healthBarY = 25;
int healthBarWidth = 500;
int healthLost;
int healthBarHeight = 30;

final int healthBarGone = 49;

class Health {

  void setup() {
    health = startingHealth;
    healthLost = healthBarWidth/startingHealth;
  }

  void draw() {
    fill(100);
    rect(healthBarX, healthBarY, 500, healthBarHeight);

    fill(255, 0, 0);
    rect(healthBarX, healthBarY, healthBarWidth, healthBarHeight);
  }

  void collide() {
    for (int i = 0; i<e.length; i++) {
      if (dist(e[i].x + xRef, e[i].y + yRef, c.xLocation, c.yLocation) <= c.size/2 + e[i].radius) {
        e[i].ded = true;
        health = health - 1;
        healthBarWidth = healthBarWidth-healthLost;
        if (healthBarWidth <= healthBarGone) {
          healthBarWidth = 0;
        }
      }
    }
  }

  void gameOver() {
    if (health <= 0) {
      fill(255, 0, 0);
      text("GAME OVER", 100, 100);
      h.  highscoreTimer++;
      //highscore part
      if (h.highscoreTimer == 1) {
        if (h.score>h.numbers1) {
          h.numbers3 = h.numbers2;
          h.numbers2 = h.numbers1;
          h.numbers1 = h.score;
        } else if (h.score>h.numbers2) {
          h.numbers3 = h.numbers2;
          h.numbers2 = h.score;
        } else if (h.score>h.numbers3) {
          h.numbers3 = h.score;
        }
        h.numbers[0] = str(h.numbers1);
        h.numbers[1] = str(h.numbers2);
        h.numbers[2] = str(h.numbers3);
        saveStrings("Highscore.txt", h.numbers);
      }
    }
  }
}
