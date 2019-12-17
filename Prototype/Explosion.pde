class Explosion {
  float x, y, xSpeed, ySpeed, slowdown, speedVariation, size;
  float r, g, b, density;
  Explosion(float spawnX, float spawnY) {
    x = spawnX;
    y = spawnY;
    size = 10;
    speedVariation = 10;
    xSpeed = random(-speedVariation, speedVariation);
    ySpeed = random(-speedVariation, speedVariation);
  }

  void reset(int inst) {
  }

  void move() {
    x+=xSpeed;
    y+=ySpeed;
  }

  void display() {
    circle(x + xRef, y + yRef, size);
  }
}
