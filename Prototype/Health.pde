int startingHealth = 3;

float health;
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
    health = startingHealth;
    healthLost = healthBarWidth/startingHealth;

  }

  void draw() {
    fill(100);
    rect(healthBarX, healthBarY, 500, healthBarHeight);

    fill(255, 0, 0);
    rect(healthBarX, healthBarY, healthBarWidth, healthBarHeight);
    
    fill(255,215,215);
    rect(healthBarX,healthBarYLighting,healthBarXLighting,5);
    
    image(healthBar, 300, 30, 515, 55);
    
  }

  void collide() {
    for (int i = 0; i<e.length; i++) {
      if (dist(e[i].x + xRef, e[i].y + yRef, c.xLocation, c.yLocation) <= c.size/2 + e[i].radius) {
        e[i].ded = true;
        health = health - 1;
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
    if (health <= 0) {
     end.end = true;
     h.highscoreSave();
    }
  }
  void reset(){
    health = startingHealth;
    
    healthBarXLighting = 500;
    healthBarWidth = 500;
    healthBarHeight = 30;
    healthBarX = 50;
    healthBarY = 25;
  }
}
