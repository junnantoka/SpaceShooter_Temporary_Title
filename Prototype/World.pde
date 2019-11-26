class World {
  float worldWidth = width * 5;
  float worldHeight = height * 6;
  
  void construct(){
  
  }
  void update() {
  }

  void display() {
    displayBorder();
  }

  void updateBorder() {
  }

  void displayBorder() {
    stroke(255);
    noFill();
    rect(xRef, yRef, worldWidth, worldHeight);
  }
}
