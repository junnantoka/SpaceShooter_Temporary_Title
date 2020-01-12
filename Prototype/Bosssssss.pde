class Boss {
  //Boss variables
  float x, y, size, radius, xSpd, ySpd, direction, t, speed, xG, yG, time, startTime;
  int type, cMin, cMax;
  boolean dead, down;
  final float xMin, xMax, yMin, yMax;
  float oddsX, oddsY, randomX, randomY;
  int prvsDirectionX, prvsDirectionY;
  float distXEdge, distXEdgeMin, distYEdge, distYEdgeMin;
  float bossScore = 50;
  boolean reverse = false;
  int reverseTimer = 0;
  int bossWobbleDuration = 19;
  int bossIntensity = 20;
  int deathParticles;
  int hitParticles;

  float currentHealth;
  float maxHealth;

  Boss() {   
    //basic values
    xMin = (-world.worldWidth / 2) + radius;
    xMax = (world.worldWidth / 2) - radius;
    yMin = (-world.worldHeight / 2) + radius;
    yMax = (world.worldHeight / 2) - radius;
    cMin = -200;
    cMax = 200;
    size = 300;
    radius = size/2;
    x = random(xMin, xMax) + xRef;
    y = random(yMin, yMax) + yRef;
    direction = random(-2, 2);
    down = false;
    dead = true;
    //type = (int)random(1, 3);
    type = 2;
    //speed = random(5000.0f, 1000.0f);
    xG = random(-10, 10);
    yG = random(-10, 10);
    startTime= 60;
    time = startTime;
    deathParticles = 150;
    hitParticles = 5;
    maxHealth = 30;
    currentHealth = maxHealth;
    speed = 8;
  }

  void draw() {

    fill(#8F1BF0);
    if (x > -xRef - size && x < -xRef + width + size && y > -yRef - size && y < -yRef + height + size) {

        image(donker, x + xRef+wobbleX+bulletWobbleX, y + yRef+wobbleY+bulletWobbleY);

    }
  }

  void move() {
    if (snailPowerUp.snailActivate) {
      speed = 1;
    }
    if (!snailPowerUp.snailActivate) {
      speed = 8;
    } 

    //boss follows the player

    if (!reverse) {
      xSpd = (( character.xLocation - (x + xRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * speed;
      ySpd = (( character.yLocation - (y + yRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * speed;
    }

    if (reverse) {
      reverseTimer++;
    }
    if (reverseTimer ==20) {
      reverse=false;
      reverseTimer = 0;
    }


    x+=xSpd;
    y+=ySpd;
  }


  void collision(int e) {
    //check if the boss makes contact with a player bullet
    for (int i = 0; i < bulletP.length; i++) {
      if ( bulletP[i].shoot && bulletP[i].visibilityTimer ==visibilitybullet) {
        if (sqrt(((x + xRef - bulletP[i].bPLocationXEnd) * (x + xRef - bulletP[i].bPLocationXEnd)) + ((y + yRef - bulletP[i].bPLocationYEnd) * (y + yRef - bulletP[i].bPLocationYEnd))) <= radius + bulletP[i].bPSize/2) {

          currentHealth--;
          bulletP[i].reset();
          for (int hit = 0; hit < hitParticles; hit++) {
            explosion.add(new Explosion(x, y, 30, 5));
          }

          if (currentHealth == 0) {
            boemB.play();


            for (int in = 0; in < deathParticles; in++) {
              explosion.add(new Explosion(x, y, 30, 5));
            }

            powerUp.powerUpInfo(x, y);
            snailPowerUp.SnailPowerUpInfo(x, y);
            reset();

            highscore.score += bossScore;
            if (!down) {
              boss.remove(e);
            }
            down = true;
          }
        }
      }
    }

    if (dist(x +xRef, y +yRef, character.xLocation, character.yLocation) < size/2-70+ character.size) {//collision
      healthMax = healthMax - 1;
      healthBarWidth = healthBarWidth-healthLost; //health loss if collision is true
      healthBarXLighting = healthBarXLighting-healthLost;
      xSpd = -((( character.xLocation - (x + xRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * speed)*2;
      ySpd = -((( character.yLocation - (y + yRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * speed)*2;
      character.xSpeed = ((( character.xLocation - (x + xRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * speed)*2;
      character.ySpeed = ((( character.yLocation - (y + yRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * speed)*2;
      reverse =true;
      wobble.wobble(bossWobbleDuration, bossIntensity);
    }
    if (y + radius >= yMax || y - radius <= yMin) {
      ySpd = 0;
    }
    if (x + radius >= xMax || x - radius <= xMin) {
      xSpd = 0;
    }
  }


  void reset() {
    //reset stats where needed
    x = random(xMin, xMax) + xRef;
    y = random(yMin, yMax) + yRef;
    currentHealth = bossTotal*30;
    reverse = false;
    dead = true;
    reverseTimer = 0;
  }
}
