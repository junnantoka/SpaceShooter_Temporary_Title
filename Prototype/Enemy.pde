public class Enemy {
  //enemy settings
  float x, y, radius, xSpd, ySpd, direction, t, speed, circle;
  int type, amount;
  boolean dead, down;
  public final float xMin, xMax, yMin, yMax, cMin, cMax, size;
  float xSpeed, ySpeed, chargeDist;
  int spawnLocation, frame, roamTime, chargeWait, chargeFrame, chargeTime, chargeSpeed;
  boolean aggro = false;
  int shootTimer;
  int particles;

  Enemy() {
    //basic values
    xMin = (-world.worldWidth / 2) + radius;
    xMax = (world.worldWidth / 2) - radius;
    yMin = (-world.worldHeight / 2) + radius;
    yMax = (world.worldHeight / 2) - radius;
    cMin = -200;
    cMax = 200;
    size = 50;
    radius = size/2;
    invisibleSpawn();
    xSpd = random(-15, 15);
    ySpd = random(-15, 15);
    direction = random(-2, 2);
    down = false;
    dead = false;
    type = (int)random(0, 4);
    speed = random(500.0f, 100.0f);
    circle = random(cMin, cMax);
    roamTime = 100;//throwaway roamTime value
    chargeDist = 400;//aggro distance
    chargeWait = 30;//amount of time the enemy waits before charging
    chargeTime = 60;//duration of the charge
    chargeSpeed = 20;//velocity of the charge

    shootTimer = int(random(60, 200));
    particles = 50;
  }

  void draw() {
    //draw the actual enemy(ies) and chooses the enemy type
    noStroke();
    if (type == 0) {
      fill(0, 255, 0);
      if (x > -xRef - size && x < -xRef + width + size && y > -yRef - size && y < -yRef + height + size) {
        image(rainbow, x + xRef + wobbleX+bulletWobbleX, y + yRef + wobbleY+bulletWobbleY);
      }
    }
    if (type == 1) {
      if (x > -xRef && x < -xRef + width && y > -yRef && y < -yRef + height) {
        image(shooter, x + xRef + wobbleX+bulletWobbleX, y + yRef + wobbleY+bulletWobbleY);
      }
    }
    if (type == 2) {
      if (x > -xRef && x < -xRef + width && y > -yRef && y < -yRef + height) {
        image(shooter, x + xRef + wobbleX+bulletWobbleX, y + yRef + wobbleY+bulletWobbleY);
      }
    }
    if (type == 3) {
      if (x > -xRef && x < -xRef + width && y > -yRef && y < -yRef + height) {
        image(crusher, x + xRef + wobbleX+bulletWobbleX, y + yRef + wobbleY+bulletWobbleY);
      }
    }
  }

  void update() {
    if (snailPowerUp.snailActivate) {
      xSpd = 1;
      ySpd = 1;
      chargeSpeed = 3;
    }

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
    if (type == 2) {
      check2();
    }
    if (type == 3) {
      check3();
    }
  }

  void check0() {//enemy type 1 (suicide bomber)
    if (!down) {
      ySpd = -ySpd;
      x += direction * xSpd;
      if (xSpd > 0) {//goes right
        xSpd -= 0.05;
      }
      if (xSpd < 0) {//goes left
        xSpd += 0.05;
      }
      if ((x + radius >= xMax || x - radius <= xMin) || (xSpd <= 0.05 && xSpd >= -0.05)) {//if movement stops or hits the wall(s), go down
        xSpd = random(-15, 15);
        down = true;
      }
    }
    if (down) {
      xSpd = -xSpd;
      y += direction * ySpd;
      if (ySpd > 0) {//goes down
        ySpd -= 0.05;
      }
      if (ySpd < 0) {//goes up
        ySpd += 0.05;
      }
      if ((y + radius >= yMax || y - radius <= xMin) || (ySpd <= 0.05 && ySpd >= -0.05)) {//if it hits the top or bottom border(s)
        ySpd = random(-15, 15);
        down = false;
      }
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
    t = (millis()-(pauze.pauzedTime/60))/speed;
    if (circle < cMin / 2 || circle > cMax / 2) {
      circle = random(cMin, cMax);
    }

    //movement
    x = (int) circle * xSpd * cos(t);
    y = (int) circle * ySpd * sin(t);
  }

  void check3() {
    roam();
    charge();
    x += xSpeed;
    y += ySpeed;
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
    }
    if (chargeFrame == 1) {//preparing the charge
      xSpeed = 0;
      ySpeed = 0;
    }
    if (chargeFrame == chargeWait + 1) { //start of the charge
      xSpeed = (( character.xLocation - (x + xRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * chargeSpeed;
      ySpeed = (( character.yLocation - (y + yRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * chargeSpeed;
    }
    if (chargeFrame > chargeWait+chargeTime) {
      aggro = false;
      chargeFrame = 0;
    }

    if (y + radius > world.worldHeight/2 || y - radius< -world.worldHeight/2) {
      ySpeed = -ySpeed;
    }

    if (x + radius > world.worldWidth/2 || x - radius < -world.worldWidth/2) {
      xSpeed = -xSpeed;
    }
  }

  void collision(int e) {
    //check if the enemy makes contact with the player
    if (!dead) {
      for (int i = 0; i < bulletP.length; i++) {
        if ( bulletP[i].shoot && bulletP[i].visibilityTimer ==visibilitybullet) {
          if (sqrt(((x + xRef - bulletP[i].bPLocationXEnd) * (x + xRef - bulletP[i].bPLocationXEnd)) + ((y + yRef - bulletP[i].bPLocationYEnd) * (y + yRef - bulletP[i].bPLocationYEnd))) <= radius + bulletP[i].bPSize/4) {
            achievement.enemyCounter++;
            highscore.score++;
            if (boss.size()==0) {
              enemyCounter++;
            }
            healthDrop.add(new HealthDrop(x, y));
            for (int in = 0; in < particles; in++) {
              explosion.add(new Explosion(x, y, 10, 7));
            }

            HealthDrop h = healthDrop.get(healthDrop.size()-1);
            h.healthSetup();
            //als de powerup aan staat worden de bullets niet gereset
            if (!powerUp.laser) {
              bulletP[i].reset();
            }
            boemA.play();
            if (!dead) {
              enemy.remove(e);
            }
            dead = true;
          }
        }
      }
    }
  }

  void reset() {
    x = random(xMin, xMax) + xRef;
    y = random(yMin, yMax) + yRef;
    xSpd = random(-25, 25);
    ySpd = random(-25, 25);
    direction = random(-2, 2);
    down = false;
    dead = false;
    speed = random(500.0f, 100.0f);
  }

  void invisibleSpawn() {
    //x = random(xMin, xMax);
    //y = random(yMin, yMax);
    //while (x > -xRef && x < -xRef + width && y > -yRef && y < -yRef + height || x > xMax || x < xMin || y > yMax || y < yMin) {
      x = random(xMin, xMax);
      y = random(yMin, yMax);
    //}
  }

  void shot() {
    shootTimer--;
    if (shootTimer ==0) {
      eBullet.add(new EnemyBullet(x, y));
      shootTimer = 200;
    }
  }
}
