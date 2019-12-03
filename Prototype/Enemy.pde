//©Jun Phung 500829487
public class Enemy {
  //enemy settings
  float x, y, radius, xSpd, ySpd, direction, t, speed, circle, chance;
  int type;
  boolean ded, down;
  final float xMin, xMax, yMin, yMax, size;
  float xSpeed, ySpeed, chargeDist;
  int spawnLocation, frame, roamTime, chargeWait, chargeFrame, chargeTime, chargeSpeed;
  boolean aggro = false;

  Enemy() {
    //basic values
    xMin = -world.worldWidth / 2 + radius;
    xMax = world.worldWidth / 2 - radius;
    yMin = -world.worldHeight / 2 + radius;
    yMax = world.worldHeight / 2 - radius;
    size = 50;
    radius = size/2;
    x = random(xMin, xMax);
    y = random(yMin, yMax);
    xSpd = random(-25, 25);
    ySpd = random(-25, 25);
    direction = random(-2, 2);
    down = false;
    ded = false;
    type = (int)random(0, 4);
    speed = random(500.0f, 100.0f);
    circle = random(-200, 200);
    roamTime = 100;//throwaway roamTime value
    chargeDist = 400;//aggro distance
    chargeWait = 30;//amount of time the enemy waits before charging
    chargeTime = 120;//duration of the charge
    chargeSpeed = 20;//velocity of the charge
    chance = random(0, 1);
  }

  void draw() {
    //draw the actual enemy(ies) and chooses the enemy type
    noStroke();
    if (type == 0) {
      image(snailgun, x + xRef, y + yRef);
    }if (type == 1) {
      image(shooter, x + xRef, y + yRef);
    }if (type == 2 && chance == 1/100) {
      fill(255);
      noStroke();
      circle(x + xRef, y + yRef, size);
    }if (type == 3) {
      image(crusher, x + xRef, y + yRef);
    }
  }

  void update() {
    //cal to method(s)
    types();
  }

  void types() {
    //different enemy types
    if (type == 0) {
      check0();
    }
    if (type == 1) {
      check1();
    }
    if (type == 2 && chance == 1/100) {
      check2();
    }
    if (type == 3) {
      check3();
    }
  }

  void check3() {
    roam();
    charge();
  }
  
  void roam() {

    if (frame == 1) {
      roamTime = int(random(20, 200));
      xSpeed = random(-5, 5);
      ySpeed = random(-5, 5);
    }

    if (!aggro) {
      frame++;
      if (frame>roamTime) {
        frame = 0;
      }
    }
  }
  void charge() {

    if (dist(x + xRef, y + yRef, character.xLocation, character.yLocation) < chargeDist) {
      aggro = true;
    }
    if (aggro) {
      chargeFrame++;
      //if(){}
      //text(chargeFrame, width/2, 200);
    }
    if (chargeFrame == 1) {//preparing the charge
      xSpeed = 0;
      ySpeed = 0;
    }
    if (chargeFrame == chargeWait + 1) { //start of the charge
      xSpeed = (( character.xLocation - (x + xRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * chargeSpeed;
      ySpeed = (( character.yLocation - (y + yRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * chargeSpeed;
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
    } else {
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
    x = (int) circle * xSpd * cos(t);
    y = (int) circle * ySpd * sin(t);
  }

  void collision() {
    //check if the enemy makes contact with the player
    if (!ded) {
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
    x = random(0, xMax) + xRef;
    y = random(0, yMax) + yRef;
    xSpd = random(-25, 25);
    ySpd = random(-25, 25);
    direction = random(-2, 2);
    down = false;
    ded = false;
    speed = random(500.0f, 100.0f);
  }
}
