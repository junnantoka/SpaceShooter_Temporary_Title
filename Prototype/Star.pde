class Star {
  float x, y, size;
  float xMin, xMax, yMin, yMax;
  void construct() {
    xMin = (-world.worldWidth / 2) - width/2;
    xMax = (world.worldWidth / 2) + width/2;
    yMin = (-world.worldHeight / 2) - height;
    yMax = (world.worldHeight / 2) + height/2;
    //chooses a random x, y and size
    x = random(xMin - width/2, xMax + width/2);
    y = random(-height, 2 * height);
    size = random(3, 6);
  }

  void disp() {

    //draws a circle on the random x and y
    fill(255);
    stroke(2);
    if (x > -xRef && x < -xRef + width && y > -yRef && y < -yRef + height) {
      circle(x + xRef+wobbleX+bulletWobbleX, y + yRef+wobbleY+bulletWobbleY, size);
    }
    //text(xRef, width/2, 100);
    //text(yRef, width/2, 300);
  }
}
