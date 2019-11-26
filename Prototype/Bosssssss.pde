class Boss{
  float x, y, size, radius, xSpd, ySpd, direction, t, speed, xG, yG, time;
  int type, health;
  boolean ded, down;
  final float xMin, xMax, yMin, yMax;
  
   Boss() {
    //basic values
    xMin = -width * 2;
    xMax = 2 * width;
    yMin = -height * 2;
    yMax = 2 * height;
    size = 300;
    radius = size/2;
    x = random(xMin, xMax) + xRef;
    y = random(yMin, yMax) + yRef;
    xSpd = random(-10, 10);
    ySpd = random(-10, 10);
    direction = random(-2, 2);
    down = false;
    ded = true;
    type = (int)random(0, 3);
    speed = random(5000.0f, 1000.0f);
    xG = random(-10, 10);
    yG = random(-10, 10);
    time = 0;
    health = round(random(1,30));
  }
  
  void draw(){
     if (!ded ) {
    fill(#8F1BF0);
    circle(x + xRef,y + yRef,size);
     }
    
    
    
  }
  
  
  
  
  void collision() {
    //check if the enemy makes contact with the player
    if (!ded ) {
      for (int i = 0; i < bulletP.length; i++) {
        if ( bulletP[i].ja) {
          if (sqrt(((x + xRef - bulletP[i].bPLocationXEnd) * (x + xRef - bulletP[i].bPLocationXEnd)) + ((y + yRef - bulletP[i].bPLocationYEnd) * (y + yRef - bulletP[i].bPLocationYEnd))) <= radius + bulletP[i].bPSize/2) {
            health--;
            if(health == 0){
              reset();
            ded = true;
            print("Auchiewauchie ");
            highscore.score++;
            }
            //als de powerup aan staat worden de bullets niet gereset
            if (!powerUp.laser) {
              bulletP[i].reset();
              
            }
          }
        }
      }
    }
  }
  
  void reset(){
    x = random(xMin, xMax) + xRef;
    y = random(yMin, yMax) + yRef;
    health = round(random(1,30));
    
    
  }
  
  
  
  
}
