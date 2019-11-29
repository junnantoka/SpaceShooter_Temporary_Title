//©Jun Phung 500829487
public class Enemy {
  //enemy settings
  float x, y, size, radius, xSpd, ySpd, direction, t, speed, circle;
  int type;
  boolean ded, down;
  final float xMin, xMax, yMin, yMax;

  Enemy() {
    //basic values
    xMin = -width * 2;
    xMax = 2 * width;
    yMin = -height;
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
    speed = random(2000.0f, 1500.0f);
    circle = random(-1500, 1500);
  }

  void draw() {
    //draw the actual enemy(ies) and chooses the enemy type
    noStroke();
    if (type == 0) {
      image(snailgun,x+ xRef, y + yRef);
    } else if (type == 1) {
      image(shooter,x + xRef, y + yRef);
    } else if (type == 2) {
      image(crusher,x + xRef, y + yRef);
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
    }else{
      xSpd = -xSpd;
      down = false;
    }
    if (y - radius <= yMin) {
      ded = true;
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
    x = (int)xRef + circle * xSpd * cos(t);
    y = (int)yRef + circle * ySpd * sin(t);
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
          if (sqrt(((x + xRef - bulletP[i].bPLocationXEnd) * (x + xRef - bulletP[i].bPLocationXEnd)) + ((y + yRef - bulletP[i].bPLocationYEnd) * (y + yRef - bulletP[i].bPLocationYEnd))) <= radius + bulletP[i].bPSize/4) {
            ded = true;
            print("Auchiewauchie ");
            highscore.score++;
            enemyCounter++;
            //als de powerup aan staat worden de bullets niet gereset
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
    speed = random(3000.0f, 1500.0f);
  }
}
