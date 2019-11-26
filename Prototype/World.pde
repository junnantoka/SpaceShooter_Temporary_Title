class World {
  float worldWidth, worldHeight;

  void construct() {
    worldHeight = height * 6;
    worldWidth = width * 5;
  }

  void update() {
  }

  void display() {
    displayBorder();
  }

  void updateBorder() {
    
  }

  void displayBorder() {
    rectMode(CENTER);
    stroke(255);
    noFill();
    rect(xRef, yRef, worldWidth, worldHeight);
    print(xRef + " ");
  }
}
