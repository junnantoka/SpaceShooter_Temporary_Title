int startingHealth = 999999999; //Deze integer geeft aan hoeveel health je aan het begin hebt.

float healthMax; 
boolean getsHit = false; //Deze boolean is false, omdat je niet geraakt wordt door een enemy.
int healthBarX = 50; //Coordinaten van de healthbar.
int healthBarY = 25;
int healthBarWidth = 500;
int healthLost;
int healthBarHeight = 30;

int healthBarXLighting = 500; //Een extra lichtje zodat het er mooi uitziet.
int healthBarYLighting = 27;

final int healthBarGone = 49; //Dit voorkomt dat de healthbar een - getal wordt.

class Health {

  void setup() {
    healthMax = startingHealth; //De health kan niet hoger dan de starting health die is ingesteld.
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

  void collide() { //Hier wordt de collision van de player met de enemy getest. 
    for (int i = 0; i<enemy.length; i++) {
      if (dist(enemy[i].x + xRef, enemy[i].y + yRef, character.xLocation, character.yLocation) <= character.size/2 + enemy[i].radius) {
        enemy[i].ded = true;
        healthMax = healthMax - 1;
        healthBarWidth = healthBarWidth-healthLost; //Als de player geraakt wordt zal de health omlaag gaan.
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
    healthMax = startingHealth; //De health wordt hier gereset als de "play again" knop wordt ingedrukt.

    healthBarXLighting = 500;
    healthBarWidth = 500;
    healthBarHeight = 30;
    healthBarX = 50;
    healthBarY = 25;
  }
}
