class Particle {
  float x, y, xSpeed, ySpeed, slowdown, size;
  boolean visible;
  void construct() {
    switch(character.xDir) {
    case 1:
      xSpeed = random(3, 5);
      break;
    case 2:
      xSpeed = random(-3, -5);
      break;
    }
    switch(character.yDir) {
    case 1:
      ySpeed = random(3, 5);
      break;
    case 2:
      ySpeed = random(-3, -5);
      break;
    }
    size = random(5, 10);
    visible = true;
    slowdown = 0.1;
    print("A");
  }
  void display() {
    if (visible) {
      circle(x, y, size);
    }
  }

  void move() {
    if (visible) {
      x += xSpeed;
      y += ySpeed;
      
      if(xSpeed > 0){
        xSpeed -= slowdown;
      }
      if(xSpeed < 0){
        xSpeed += slowdown;
      }
      if(ySpeed > 0){
        ySpeed -= slowdown;
      }
      if(ySpeed < 0){
        ySpeed += slowdown;
      }
    }
  }
}
