//©Jun Phung 500829487
public class Enemy {
  //enemy settings
  float x, y, radius, xSpd, ySpd, direction, t, speed, circle;
  int type, amount, cMin, cMax, behaviour;
  boolean ded;
  final float xMin, xMax, yMin, yMax, size;
  float xSpeed, ySpeed, chargeDist;
  int spawnLocation, frame, roamTime, chargeWait, chargeFrame, chargeTime, chargeSpeed;
  boolean aggro = false;

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
    x = random(xMin, xMax);
    y = random(yMin, yMax);
    xSpd = random(5, 25);
    ySpd = random(5, 25);
    direction = random(-2, 2);
    behaviour = (int)random(0, 3);
    ded = false;
    type = (int)random(0, 4);
    speed = random(500.0f, 100.0f);
    circle = random(cMin, cMax);
    roamTime = 100;//throwaway roamTime value
    chargeDist = 400;//aggro distance
    chargeWait = 30;//amount of time the enemy waits before charging
    chargeTime = 60;//duration of the charge
    chargeSpeed = 20;//velocity of the charge
  }

  void draw() {
    //draw the actual enemy(ies) and chooses the enemy type
    noStroke();
    if (type == 0) {
      image(snailgun, x + xRef, y + yRef);
    }if (type == 1) {
      image(shooter, x + xRef, y + yRef);
    }if (type == 2){
      image(shooter, x + xRef, y + yRef);
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
    if (type == 2) {
      check2();
    }
    if (type == 3) {
      check3();
    }
  }

  void check0() {//enemy type 1 (suicide bomber)
    if (xSpd > 0) {//goes right
      xSpd -= 0.05;
    }
    if (xSpd < 0) {//goes left
      xSpd += 0.05;
    }
    if (ySpd > 0) {//goes down
      ySpd -= 0.05;
    }
    if (ySpd < 0) {//goes up
      ySpd += 0.05;
    }
    if ((x + radius >= xMax || x - radius <= xMin) || (xSpd <= 0.05 && xSpd >= -0.05)) {//if movement stops or hits the wall(s), go down
      xSpd = -xSpd;
      behaviour = (int)random(0, 3);
    }
    if ((y - radius <= yMax || y + radius >= yMin) || (ySpd <= 0.05 && ySpd >= -0.05)) {//if movement stops or hits the wall(s), go down
      ySpd = -ySpd;
      behaviour = (int)random(0, 3);
    }
    if(behaviour == 0){
      x += direction * xSpd;
    }
    if (behaviour == 1) {
      direction = random(direction);
      y += direction * ySpd;
    }if(behaviour == 2){
      direction = random(direction);
      x += direction * xSpd;
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
    if(circle < cMin / 2 || circle > cMax / 2){
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
    if(chargeFrame > chargeWait+chargeTime){
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
  
  void respawn() {
    //checks if the stars spawn outside the playarea and if they do ranspawn them back in
    if (x + xRef < -xMin) {
      x = random(-xRef + width, -xRef + 2 * width);
    }

    if (x + xRef > xMax) {
      x = random(-xRef - width, -xRef);
    }

    if (y + yRef < -height) {
      y = random(-yRef + height, -yRef + 2 * height);
    }

    if (y + yRef > xMax) {
      y = random(-yRef - height, -yRef);
    }
  }

  void reset() {
    x = random(xMin, xMax) + xRef;
    y = random(yMin, yMax) + yRef;
    xSpd = random(-25, 25);
    ySpd = random(-25, 25);
    direction = random(-2, 2);
    behaviour = (int)random(0, 3);
    ded = false;
    speed = random(500.0f, 100.0f);
  }
}
