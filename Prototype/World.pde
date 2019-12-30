class World {
  //class variables
  float worldWidth, worldHeight, widthMult, heightMult, bounceMult;

  //constructor
  void construct() {
    widthMult = 2;
    heightMult = 2;
    worldHeight = height * heightMult;
    worldWidth = width * widthMult;
    bounceMult = 1;
  }

  void update() {//update
    updateBorder();//call to method
  }

  void display() {
    displayBorder();//call to method
  }

  void updateBorder() {
    if (yRef - character.radius - startY > worldHeight/heightMult) {//top border
      yRef = -worldHeight + yRef - character.size;
    }
    if (yRef + character.radius - startY < -worldHeight/heightMult ) {//bottom border
      yRef = worldHeight + yRef + character.size;
    }
    
    if (xRef - character.radius - startX > worldWidth/widthMult ) {//right border
      xRef = -worldWidth + xRef - character.size;
    }
    if (xRef + character.radius - startX < -worldWidth/widthMult ) {//left border
      xRef = worldWidth + xRef + character.size;
    }
  }

  void displayBorder() {
    rectMode(CENTER);
    stroke(255);
    noFill();
    rect(xRef+wobbleX+bulletWobbleX, yRef+wobbleY+bulletWobbleY, worldWidth, worldHeight);
  }
}
