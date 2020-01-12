class Explosion {
  //Variables
  float x, y, xSpeed, ySpeed, slowdown, speedVariation, size, speedLimit;
  float r, g, b, density, fadeSpeed;

  Explosion(float spawnX, float spawnY, float speed, float diss) {//constructor
    x = spawnX;
    y = spawnY;
    size = random(10, 20);
    speedVariation = speed;
    xSpeed = random(-speedVariation, speedVariation);
    ySpeed = random(-speedVariation, speedVariation);
    r = random(255);
    g = random(255);
    b = random(255);
    fadeSpeed = random(diss-3, diss+3);
    density = 255;
    slowdown = 0.1;
    speedLimit = 1;
  }

  void reset(int inst) {
    if (density < 1 || ((xSpeed < speedLimit && xSpeed >-speedLimit) && (ySpeed < speedLimit && ySpeed >-speedLimit) )) {
      explosion.remove(inst);
    }
  }

  void move() {
    x+=xSpeed;
    y+=ySpeed;
    if (ySpeed > 0) {
      ySpeed-=slowdown;
    }
    if (ySpeed < 0) {
      ySpeed += slowdown;
    }
    if (xSpeed > 0) {
      xSpeed -= slowdown;
    }
    if (xSpeed < 0) {
      xSpeed += slowdown;
    }
  }

  void display() {
    fill(r, g, b, density);
    noStroke();
    density -= fadeSpeed;
    circle(x + xRef + wobbleX+bulletWobbleX, y + yRef + wobbleY+bulletWobbleY, size);
  }
}
