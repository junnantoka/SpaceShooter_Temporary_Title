class Particle {
  float x, y, xSpeed, ySpeed, slowdown, size, avgStartSpeed, startSpeedVariation, dissapearSpeed, density, fadeSpeed, sideVariation;
  boolean visible;
  int r, g, b;
  boolean xSpawn, ySpawn;// whether it spawns because the player moves vertically or horizontally

  void construct() {//constructor
    avgStartSpeed = 15;
    startSpeedVariation = 4;
    dissapearSpeed = 4;
    fadeSpeed = 6;
    sideVariation = 10;
    
    size = random(20, 30);
    visible = true;
    slowdown = 0.1;
    x = -xRef + startX;
    y = -yRef + startY;

    r = int(random(200, 255));
    g = int(random(0, 255));    
    b = int(random(0));
    density = 150;


    switch(character.xDir) {//check for player input
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
  }
  void display() {//draw the object(s)
    noStroke();
    fill(r, g, b, density);
    if (visible) {
      circle(x + xRef+wobbleX+bulletWobbleX, y + yRef+wobbleY+bulletWobbleY, size);
    }
  }

  void move() {//actual movement
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
