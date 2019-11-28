class Star {
  float x, y, size;

  void construct() {
    x = random(-width, 2*width);
    y = random(-height, 2 * height);
    size = random(3, 6);
  }
  void disp() {
    fill(255);
    circle(x + xRef, y + yRef, size);
    //text(xRef, width/2, 100);
    //text(yRef, width/2, 300);
    respawn();
  }
  void respawn() {
    if (x + xRef < -width) {
      x = random(-xRef + width, -xRef + 2 * width);
    }

    if (x + xRef > 2*width) {
      x = random(-xRef - width, -xRef);
    }

    if (y + yRef < -height) {
      y = random(-yRef + height, -yRef + 2 * height);
    }

    if (y + yRef > 2*height) {
      y = random(-yRef - height, -yRef);
    }
  }
}
