class World {

  float worldWidth, worldHeight, widthMult, heightMult, bounceMult;

  void construct() {
    widthMult = 2;
    heightMult = 2;
    worldHeight = height * heightMult;
    worldWidth = width * widthMult;
    bounceMult = 1;
  }

  void update() {
    updateBorder();
  }

  void display() {
    displayBorder();
  }

  void updateBorder() {
    if (yRef + character.size/2 - startY > worldHeight/2 ) {
      character.ySpeed = -character.ySpeed * bounceMult;
    }
    if (yRef - character.size/2 - startY < -worldHeight/2 ) {
      character.ySpeed = -character.ySpeed * bounceMult;
    }
    
    if (xRef + character.size/2 - startX > worldWidth/2 ) {
      character.xSpeed = -character.xSpeed * bounceMult;
    }
    if (xRef - character.size/2 - startX < -worldWidth/2 ) {
      character.xSpeed = -character.xSpeed * bounceMult;
    }
  }

  void displayBorder() {
    rectMode(CENTER);
    stroke(255);
    noFill();
    rect(xRef, yRef, worldWidth, worldHeight);
  }
}
