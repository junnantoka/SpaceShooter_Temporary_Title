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

    void updateBorder() {//collision of player with the border
    if (yRef + character.size/2 - startY > worldHeight/2 ) {
      yRef = (worldHeight/2) - (character.size/2) + startY;
      character.ySpeed = 0;
    }
    if (yRef - character.size/2 - startY < -worldHeight/2 ) {
      yRef = -(worldHeight/2) + (character.size/2) + startY;
      character.ySpeed = 0;
    }

    if (xRef + character.size/2 - startX > worldWidth/2 ) {
      xRef = (worldWidth/2) - (character.size/2) + startX;
      character.xSpeed = 0;
    }
    if (xRef - character.size/2 - startX < -worldWidth/2 ) {
      xRef = -(worldWidth/2) + (character.size/2) + startX;
      character.xSpeed = 0;
    }
  }

  void displayBorder() {
    rectMode(CENTER);
    stroke(255);
    noFill();
    rect(xRef+wobbleX+bulletWobbleX, yRef+wobbleY+bulletWobbleY, worldWidth, worldHeight);
  }
}
