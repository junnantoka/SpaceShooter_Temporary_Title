class World {
  float worldWidth, worldHeight;

  void construct() {
    worldHeight = height * 3;
    worldWidth = width * 5;
  }

  void update() {
    updateBorder();
  }

  void display() {
    displayBorder();
    text(yRef, width/2, 300);
  }

  void updateBorder() {
    if (yRef + character.size/2 > worldHeight * 2/3) {
      character.ySpeed = -character.ySpeed*3;
    }
    if (yRef - character.size/2 < -worldHeight * 1/3) {
      character.ySpeed = -character.ySpeed*3;
    }
  }

  void displayBorder() {
    rectMode(CENTER);
    stroke(255);
    noFill();
    rect(xRef, yRef, worldWidth, worldHeight);
  }
}
