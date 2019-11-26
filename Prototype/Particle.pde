class Particle {
  float x, y, xSpeed, ySpeed, slowdown, size, avgStartSpeed, startSpeedVariation, dissapearSpeed, density, fadeSpeed, sideVariation;
  boolean visible;
  int r, g, b;
  boolean xSpawn, ySpawn;// wether it spawns because the player moves vertically or horizontally

  void construct() {
    avgStartSpeed = 15;
    startSpeedVariation = 4;
    dissapearSpeed = 2;
    fadeSpeed = 6;
    sideVariation = 3;
    switch(character.xDir) {
    case 1:
      if (keysPressed['a'] || keysPressed['A']) {
        xSpeed = random(avgStartSpeed - startSpeedVariation, avgStartSpeed + startSpeedVariation);
        ySpeed = random(-sideVariation, sideVariation);
        xSpawn = true;
        ySpawn = false;
      }    
      break;
    case 2:
      if (keysPressed['d'] || keysPressed['D']) {
        xSpeed = random(-avgStartSpeed + startSpeedVariation, -avgStartSpeed - startSpeedVariation);
        ySpeed = random(-sideVariation, sideVariation);
        xSpawn = true;
        ySpawn = false;
      }      
      break;
    }
    switch(character.yDir) {
    case 1:
      if (keysPressed['w'] || keysPressed['W']) {
        ySpeed = random(avgStartSpeed - startSpeedVariation, avgStartSpeed + startSpeedVariation);
        xSpeed = random(-sideVariation, sideVariation);
        ySpawn = true;
        xSpawn = false;
      }    
      break;
    case 2:
      if (keysPressed['s'] || keysPressed['S']) {
        ySpeed = random(-avgStartSpeed + startSpeedVariation, -avgStartSpeed - startSpeedVariation);
        xSpeed = random(-sideVariation, sideVariation);
        ySpawn = true;
        xSpawn = false;
      }      
      break;
    }
    
    size = random(20, 30);
    visible = true;
    slowdown = 0.1;
    x = -xRef + startX;
    y = -yRef + startY;

    r = int(random(200,255));
    g = int(random(200,220));    
    b = int(random(0));
    density = 255;
  }
  void display() {
    noStroke();
    fill(r, g, b, density);
    if (visible) {
      circle(x + xRef, y + yRef, size);
    }
  }

  void move() {
    if (visible) {
      x += xSpeed;
      y += ySpeed;

      if (xSpeed > 0) {
        xSpeed -= slowdown;
      }
      if (xSpeed < 0) {
        xSpeed += slowdown;
      }
      if (ySpeed > 0) {
        ySpeed -= slowdown;
      }
      if (ySpeed < 0) {
        ySpeed += slowdown;
      }
      density -= fadeSpeed;

      if (density < 1) {
        visible = false;
      }
    }
  }
}
