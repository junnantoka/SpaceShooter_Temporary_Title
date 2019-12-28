class Boss {
  float x, y, size, radius, xSpd, ySpd, direction, t, speed, xG, yG, time, startTime;
  int type, cMin, cMax;
  boolean ded, down;
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
  boolean fullHealth = true;
  boolean halfHealth = false;
  boolean quarterHealth = false;

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
    xSpd = random(-10, 10);
    ySpd = random(-10, 10);
    direction = random(-2, 2);
    down = false;
    ded = true;
    //type = (int)random(1, 3);
    type = 2;
    speed = random(5000.0f, 1000.0f);
    xG = random(-10, 10);
    yG = random(-10, 10);
    startTime= 60;
    time = startTime;
    speed = 8;
    
    deathParticles = 150;
    hitParticles = 5;
    
    maxHealth = 30;
    currentHealth = maxHealth;
  }

  void draw() {
    if (!ded ) {
      fill(#8F1BF0);
      if (fullHealth) {
        image(bossone, x + xRef+wobbleX+bulletWobbleX, y + yRef+wobbleY+bulletWobbleY, size, size);
      }
    }
  }

  void move() {
    //werkt niet goed hoort de player te volgen
    if (!ded) {
      if (type ==2) {
        /*   ySpd = (character.yLocation-y)/dist(character.xLocation, character.yLocation, x+xRef, y+yRef)*2;
         xSpd = (character.xLocation-x)/dist(character.xLocation, character.yLocation, x+xRef, y+yRef)*2;
         direction =(character.yLocation-y)/dist(character.xLocation, character.yLocation, x+xRef, y+yRef)*2+(character.xLocation-x)/dist(character.xLocation, character.yLocation, x+xRef, y+yRef)*2;
         ySpd= (speed /direction)*((character.yLocation-y+yRef)/dist(character.xLocation, character.yLocation, x+xRef, y+yRef)*2);
         xSpd= (speed /direction)*((character.xLocation-x+xRef)/dist(character.xLocation, character.yLocation, x+xRef, y+yRef)*2);*/
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
        // println(xSpd);
        //println(ySpd);
        x+=xSpd;
        y+=ySpd;
      }

      //detects if boss gets out of the border maybe
      if (type ==1) {
        if (yRef + radius + y >= world.worldHeight/2 ) {
          //xSpd=-30;
          time=0;
        }
        if (yRef - radius + y <= -world.worldHeight/2.5 ) {
          //xSpd=1;
          time=0;
        }

        if (xRef + radius + x >= world.worldWidth/2 ) {
          //xSpd=-1;
          time=0;
        }
        if (xRef - radius + x <= -world.worldWidth/2 ) {
          //xSpd=1;
          time=0;
        }
        //changes direction from time to time
        if (time == 0) {
          if (prvsDirectionX ==2) {
            distXEdge =(x+world.worldWidth/2)*3;
            distXEdgeMin =(x-world.worldWidth/2);
          } else if (prvsDirectionX ==2) {


            distXEdge =(x+world.worldWidth/2);
            distXEdgeMin =(x-world.worldWidth/2)*3;
          } else {

            distXEdge =x+world.worldWidth/2;
            distXEdgeMin =x-world.worldWidth/2;
          }
          oddsX=(distXEdge)-(distXEdgeMin);

          if (prvsDirectionY ==2) {
            distYEdge =(y+world.worldHeight/2)*3;
            distYEdgeMin=(y-world.worldHeight/2.5);
          } else if (prvsDirectionY ==2) {

            distYEdge =(y+world.worldHeight/2);
            distYEdgeMin=(y-world.worldHeight/2.5)*3;
          } else {
            distYEdge =y+world.worldHeight/2;
            distYEdgeMin=y-world.worldHeight/2.5;
          }
          oddsY=(distYEdge)-(distYEdgeMin);

          randomX = random(oddsX);
          randomY = random(oddsY);
          if (randomX>distXEdge) {
            xSpd=1;
            prvsDirectionX = 2;
          } else if (randomX==distXEdge) {
            xSpd =0;
            prvsDirectionX = 0;
          } else {
            xSpd =-1;
            prvsDirectionX = -2;
          }
          if (randomY>y+distYEdge) {
            ySpd = 1;
            prvsDirectionY = 2;
          } else if (randomY==distYEdge) {
            ySpd =0;
            prvsDirectionY = 0;
          } else {
            ySpd =-1;
            prvsDirectionY = -2;
          }
          time = startTime;
        }

        x+=xSpd;
        y+=ySpd;
      }
    }
  }


  void collision() {
    //check if the enemy makes contact with the player bullet
    if (!ded ) {
      for (int i = 0; i < bulletP.length; i++) {
        if ( bulletP[i].shoot) {
          if (sqrt(((x + xRef - bulletP[i].bPLocationXEnd) * (x + xRef - bulletP[i].bPLocationXEnd)) + ((y + yRef - bulletP[i].bPLocationYEnd) * (y + yRef - bulletP[i].bPLocationYEnd))) <= radius + bulletP[i].bPSize/2) {

            currentHealth--;

            for (int hit = 0; hit < hitParticles; hit++) {
              explosion.add(new Explosion(x, y, 30, 5));
            }

            if (currentHealth == 0) {
              boemB.play();
              down = true;

              for (int in = 0; in < deathParticles; in++) {
                explosion.add(new Explosion(x, y, 30, 5));
              }

              powerUp.powerUpInfo(x, y);
              reset();
              //print("Auchiewauchie ");
              highscore.score += bossScore;
            }
            //als de powerup aan staat worden de bullets niet gereset
            //if (!powerUp.laser) {
            bulletP[i].reset();
            //}
          }
        }
      }

      if (dist(x +xRef, y +yRef, character.xLocation, character.yLocation) < size/2-70+ character.size) {
        healthMax = healthMax - 1;
        healthBarWidth = healthBarWidth-healthLost; //Als de player geraakt wordt zal de health omlaag gaan.
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
  }

  void damageWear() {
   if((currentHealth <= ((maxHealth / 100) * 50)) && (currentHealth >= ((maxHealth / 100) * 25))  ){
     //println("iudaghjwk");
     halfHealth = true;
     //fullHealth = false;
   }
   if(currentHealth <= ((maxHealth / 100) * 25)){
     //println("ajhgtf");
     halfHealth = false;
     quarterHealth = true;
   }
  }

  void reset() {
    //reset alle stats die terug gezet moeten worden
    x = random(xMin, xMax) + xRef;
    y = random(yMin, yMax) + yRef;
    currentHealth = bossTotal*30;
    reverse = false;
    ded= true;
    reverseTimer = 0;
  }
}
