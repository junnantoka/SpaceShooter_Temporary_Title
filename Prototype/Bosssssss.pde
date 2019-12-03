class Boss {
  float x, y, size, radius, xSpd, ySpd, direction, t, speed, xG, yG, time, startTime;
  int type, health;
  boolean ded, down;
  final float xMin, xMax, yMin, yMax;
  float oddsX, oddsY, randomX, randomY;
  int prvsDirectionX, prvsDirectionY;
  float distXEdge, distXEdgeMin, distYEdge, distYEdgeMin;
  float bossScore = 50;
  boolean reverse = false;
  int reverseTimer = 0;
  Boss() {
    //basic values
    xMin = -width ;
    xMax =  width;
    yMin = -height ;
    yMax =  height;
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
    health = round(random(1, 30));
    speed = 10;
  }

  void draw() {
    if (!ded ) {
      fill(#8F1BF0);
      circle(x + xRef, y + yRef, size);
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
      if (!reverse){
      xSpd = (( character.xLocation - (x + xRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * speed;
      ySpd = (( character.yLocation - (y + yRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * speed;
      }
      if (reverse){
        reverseTimer++;
      }
      if (reverseTimer ==10){
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
          println('k');
        }
        if (yRef - radius + y <= -world.worldHeight/2.5 ) {
          //xSpd=1;
          time=0;
          println('l');
        }

        if (xRef + radius + x >= world.worldWidth/2 ) {
          //xSpd=-1;
          time=0;
          println('m');
        }
        if (xRef - radius + x <= -world.worldWidth/2 ) {
          //xSpd=1;
          time=0;
          println('n');
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
        if ( bulletP[i].ja) {
          if (sqrt(((x + xRef - bulletP[i].bPLocationXEnd) * (x + xRef - bulletP[i].bPLocationXEnd)) + ((y + yRef - bulletP[i].bPLocationYEnd) * (y + yRef - bulletP[i].bPLocationYEnd))) <= radius + bulletP[i].bPSize/2) {
            health--;
            if (health == 0) {
              reset();
              ded = true;
              print("Auchiewauchie ");
              highscore.score += bossScore;
            }
            //als de powerup aan staat worden de bullets niet gereset
            if (!powerUp.laser) {
              bulletP[i].reset();
            }
          }
        }
      }
      
      
      
      
      
      if(dist(x +xRef, y +yRef, character.xLocation, character.yLocation) < size/2+ character.size){
        healthMax = healthMax - 1;
        healthBarWidth = healthBarWidth-healthLost; //Als de player geraakt wordt zal de health omlaag gaan.
        healthBarXLighting = healthBarXLighting-healthLost;
        xSpd = -((( character.xLocation - (x + xRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * speed)*4;
        ySpd = -((( character.yLocation - (y + yRef)) / dist(character.xLocation, character.yLocation, x + xRef, y + yRef)) * speed)*4;
        reverse =true;
      }
    }
  }

  void reset() {
    //reset alle stats die terug gezet moeten worden
    x = random(xMin, xMax) + xRef;
    y = random(yMin, yMax) + yRef;
    health = bossTotal*round(random(1, 30));

    ded= true;
  }
}
