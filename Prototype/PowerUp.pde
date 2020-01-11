//de powerups die de speler kan kopen
class PowerUp {
boolean active = false;
  float powerUpTimer = 0;
  int powerUpNumber;
  float powerUpSize = 80;
  float powerUpX;
  float powerUpY;

  float healthExtra = 2;

  boolean laser;
  boolean laserAvailable = true;
  boolean lasercollision;

  float bulletSizeMod = 1.2;
  float bulletMaxSize = 170;
  
  //variables for laserbeam
  float x, y, size, radius;
  int red, green, blue, colorTimer, frames, seconds;
  boolean laserPickUp;
  int chance = (int) random(0, 999);
  final int LASERSIZE = 50;
  final int SEC = 60;
  
  PowerUp(){
    x = xRef;
    y = yRef;
    size = random(25, 100);
    radius = size / 2;
    laserPickUp = false;
  }

  void powerUpInfo(float x, float y) {
    powerUpX = x;
    powerUpY = y;
    active = true;
  }

  void powerUpDate() {
    for (int i = 0; i < boss.size(); i++) {
      Boss a = boss.get(i);
      if (active) {
        if (powerUpTimer < 60) {
          powerUpTimer++;
          powerUpSize += 0.5;
        }
        if (powerUpTimer >= 60) {
          powerUpTimer ++;
          powerUpSize -= 0.5;
        }
        if (powerUpTimer == 120) {
          powerUpTimer = 0;
        }
      }
    }
  }

  void display() {
    collision();
    for (int i = 0; i < boss.size(); i++) {
      Boss a = boss.get(i);
      if (active) {
        switch(powerUpNumber) {
        case 0:
          if (laserAvailable) {
            lasercollision = true;
            image(laserPowerUp, powerUpX + xRef + wobbleX+bulletWobbleX, powerUpY + yRef + wobbleY+bulletWobbleY, powerUpSize, powerUpSize);
          }
          break;
        case 1:
          image(healthup, powerUpX + xRef + wobbleX, powerUpY + yRef + wobbleY, powerUpSize, powerUpSize);
        }



        ////meer max health
        //    startingHealth+= healthExtra;
        //    healthLost = healthBarWidth/startingHealth;


        ////bigger bullet   
        //    for(int i = 0; i < bullets; i++){ 
        //      bulletP[i].bPSize *= bulletSizeMod;
        //      if(bulletP[i].bPSize >= bulletMaxSize){
        //        bulletP[i].bPSize = bulletMaxSize;
      }
    }
  }

  void collision() {
    if (lasercollision) {
      if (dist(powerUpX + xRef, powerUpY + yRef, character.xLocation, character.yLocation) <= character.size/2 + powerUpSize/2) {
        laser = true;
        laserAvailable = false;
        achievement.powerUpCounter++;
        powerUpNumber++;   
      }
    }
  }

  void effect() {
  }
  
  void drawPickUp(){
    fill(255, 0, 0, 150);//fill for the pick up
    circle(x, y, size);//draw the actual pick up
  }
  
  void beamUpdate(){
    colorTimer++; //timer for the color
    frames++;//keep track of the frames
    seconds = frames / SEC; //convert frames to seconds
    beamCollision();
    if(laserPickUp && seconds < 5){//only draw the beam if the player picked it up and seconds < 5
      drawBeam();
    }else{
      laserPickUp = false;//reset laserPickUp
      drawPickUp();//redraw the pickup
      reset();//reset method
    }
  }
  
  void rngColor(){
    //generate random color(s) every 2 frames
    if(colorTimer < 2){
      red = (int)random(1, 256);
      green = (int)random(1, 256);
      blue = (int)random(1, 256);
    }if(colorTimer > 5){
      colorTimer = 0;
    }
  }
  
  void beamCollision(){//checks if the player picks up the beam
    float distance = dist(character.xLocation, character.yLocation, x, y);
    
    if(distance <= character.size/2 + radius){
      laserPickUp = true;
    }
  }
  
  void drawBeam(){//draw the actual laser
    rngColor();//call to method(s)
    fill(color(red, green, blue));
    if(keysPressed[RIGHT]){
      triangle(character.xLocation + character.size/2, character.yLocation, character.xLocation + 40, character.yLocation - 25, character.xLocation + 40, character.yLocation + 25);
      rect(character.xLocation + character.size, character.yLocation - character.size/2 - 5, width, LASERSIZE);
    }else if(keysPressed[LEFT]){
      triangle(character.xLocation - character.size/2, character.yLocation, character.xLocation - 40, character.yLocation - 25, character.xLocation - 40, character.yLocation + 25);
      rect(character.xLocation - character.size, character.yLocation - character.size/2 - 5, -width, LASERSIZE);
    }else if(keysPressed[UP]){
      triangle(character.xLocation, character.yLocation - character.size/2, character.xLocation - 25, character.yLocation - 40, character.xLocation + 25, character.yLocation - 40);
      rect(character.xLocation - character.size/2 - 5, character.yLocation - character.size, LASERSIZE, -height);
    }else if(keysPressed[DOWN]){
      triangle(character.xLocation, character.yLocation + character.size/2, character.xLocation - 25, character.yLocation + 40, character.xLocation + 25, character.yLocation + 40);
      rect(character.xLocation - character.size/2 - 5, character.yLocation + character.size, LASERSIZE, height);
    }
  }
  
  void reset(){
    frames = 0;
    seconds = 0;
  }
}
