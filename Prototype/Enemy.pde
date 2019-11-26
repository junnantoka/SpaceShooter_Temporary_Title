//©Jun Phung 500829487
public class Enemy {
  //enemy settings
  float x, y, size, radius, xSpd, ySpd, direction, t, speed, xG, yG, time;
  int type;
  boolean ded, down;
  final float xMin, xMax, yMin, yMax;

  Enemy() {
    //basic values
    xMin = -width * 2;
    xMax = 2 * width;
    yMin = -height * 2;
    yMax = 2 * height;
    size = 50;
    radius = size/2;
    x = random(xMin, xMax) + xRef;
    y = random(yMin, yMax) + yRef;
    xSpd = random(-10, 10);
    ySpd = random(-10, 10);
    direction = random(-2, 2);
    down = false;
    ded = false;
    type = (int)random(0, 3);
    speed = random(5000.0f, 1000.0f);
    xG = random(-10, 10);
    yG = random(-10, 10);
    time = 0;
  }

  void draw() {
    //draw the actual enemy(ies) and chooses the enemy type
    noStroke();
    if (type == 0) {
      fill(#7D45E5);
      circle(x + xRef, y + yRef, size);
    } else if (type == 1) {
      fill(#B2882F);
      circle(x + xRef, y + yRef, size);
    } else if (type == 2) {
      fill(#838282);
      circle(x + xRef, y + yRef, size);
    }
  }

  void update() {
    //cal to method(s)
    types();
    respawn();
  }

  void types() {
    //different enemy types
    if (type == 0) {
      check0();
    }
    if (type == 1) {
      check1();
    }
    if (type == 2) {
      check2();
    }
  }

  void check0() {//enemy type 1 (suicide bomber)
    x += direction * xSpd;
    if (down) {
      direction = 1;
      y += direction * ySpd;
    }
    if (xSpd > 0) {//goes right
      xSpd -= 0.05;
    }
    if (xSpd < 0) {//goes left
      xSpd += 0.05;
    }
    if ((x - radius > xMax || x + radius < xMin) || (xSpd <= 0.05 && xSpd >= -0.05)) {//if movement stops or hits the wall(s), go down
      xSpd = -xSpd;
      down = true;
    }
    if (y - radius <= yMin) {
      ySpd = -ySpd;
    }
    if (y - radius >= yMax) {//if enemy goes out the bottom side
      ded = true; //die
    }
  }

  void check1() {//enemy type 2 (bouncing ball)
    //movement
    x += direction * xSpd;
    y += direction * ySpd;

    //collision with boundary
    if (y + radius >= yMax || y - radius <= yMin) {
      ySpd = -ySpd;
    }
    if (x + radius >= xMax || x - radius <= xMin) {
      xSpd = -xSpd;
    }
  }

  void check2() {//enemy type 3 (Darude - Sandstorm)
    t = millis()/speed;
    x = (int)(xRef + (radius * xG) * cos(t));
    y = (int)(yRef + (radius * yG) * sin(t));
    if (time <= 60) {
      xG += 0.5;
      yG += 0.5;
    }
    if (time >= 60) {
      xG -= 0.5;
      yG -= 0.5;
    }
  }

  void respawn() {
    if (x + xRef < -width) {
      ded = true;
    }

    if (x + xRef > 2 * width) {
      ded = true;
    }

    if (y + yRef < -height) {
      ded = true;
    }

    if (y + yRef > 2 * height) {
      ded = true;
    }
  }

  //©Nordin El Hadaoui
  void collision() {
    //check if the enemy makes contact with the player
    if (!ded ) {
      for (int i = 0; i < bulletP.length; i++) {
        if ( bulletP[i].ja) {
          if (sqrt(((x + xRef - bulletP[i].bPLocationXEnd) * (x + xRef - bulletP[i].bPLocationXEnd)) + ((y + yRef - bulletP[i].bPLocationYEnd) * (y + yRef - bulletP[i].bPLocationYEnd))) <= radius + bulletP[i].bPSize/2) {
            ded = true;
            print("Auchiewauchie ");
            highscore.score++;
            if (!powerUp.laser) {
              bulletP[i].reset();
            }
          }
        }
      }
    }
  }
  void reset() {
    size = 50;
    radius = size/2;
    x = random(xMin, xMax) * xRef;
    y = random(yMin, yMax) * yRef;
    xSpd = random(-10, 10);
    ySpd = random(-10, 10);
    direction = random(-2, 2);
    down = false;
    ded = false;
    type = (int) random(0, 3);
    speed = random(5000.0f, 3000.0f);
    xG = random(-10, 10);
    yG = random(-10, 10);
    time = 0;
  }
}
