class Explosion {
  float x, y, xSpeed, ySpeed, slowdown, speedVariation, size, speedLimit;
  float r, g, b, density, fadeSpeed;
  
  Explosion(float spawnX, float spawnY) {
    x = spawnX;
    y = spawnY;
    size = 10;
    speedVariation = 10;
    xSpeed = random(-speedVariation, speedVariation);
    ySpeed = random(-speedVariation, speedVariation);
    r = random(230,255);
    g = random(200,255);
    b = 50;
    fadeSpeed = 5;
    density = 255;
    slowdown = 0.2;
    speedLimit = 1;
  }

  void reset(int inst) {
    if(density<1 || ((xSpeed < speedLimit && xSpeed >-speedLimit) && (ySpeed < speedLimit && ySpeed >-speedLimit) )){
      explosion.remove(inst);
    }
  }

  void move() {
    x+=xSpeed;
    y+=ySpeed;
    
    if(ySpeed > 0){
      ySpeed-=slowdown;
    }
    if(ySpeed < 0){
      ySpeed += slowdown;
    }
    if(xSpeed > 0){
      xSpeed -= slowdown;
    }
    if(xSpeed < 0){
      xSpeed += slowdown;
    }
    
  }

  void display() {
    fill(r,g,b,density);
    noStroke();
    density -= fadeSpeed;
    circle(x + xRef, y + yRef, size);
  }
}
