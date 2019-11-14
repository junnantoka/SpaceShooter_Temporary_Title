//©Jun Phung 500829487
public class Enemy {
  //enemy settings
  float x, y, size, radius, xSpd, ySpd, direction;
  int type;
  boolean ded, down;
  
  Enemy() {
    //basic values
    size = 50;
    radius = size/2;
    x = random(radius, width-radius);
    y = random(radius, height/7);
    xSpd = random(-10, 10);
    ySpd = random(0, 10);
    direction = random(-2, 2);
    down = false;
    ded = false;
    type = (int) random(0, 2);
  }

  void draw() {
    //draw the actual enemy
    switch(type){
    case 0:
      fill(#7D45E5);
      break;
    case 1:
      fill(#B2882F);
      break;
    case 2:
      break;
    }
    circle(x + xRef, y + yRef, size);
  }

  void update() {
    //cal to method(s)
    movement();
  }

  void movement() {
    //actual movement
    switch(type){
    case 0:
      check0();
      fill(#7D45E5);
      break;
    case 1:
      check1();
      fill(#B2882F);
      break;
    case 2:
      break;
    }
  }

  void check0() {//enemy type 1 (suicide bomber)
    x += direction * xSpd;
    if (down) {
      direction = 1;
      y += direction * ySpd;
    }
    if (xSpd > 0) {//goes right
      xSpd -= 0.05;
    }
    if (xSpd < 0) {//goes left
      xSpd += 0.05;
    }
    if ((x + radius > width || x - radius < 0) || (xSpd <= 0.05 && xSpd >= -0.05)) {//if movement stops or hits the wall(s), go down
      xSpd = -xSpd;
      down = true;
    }
    if (y + radius >= height || y - radius <= 0) {//if enemy goes out the bottom side
      ded = true; //die
    }
    }
  
  
  void check1(){//enemy type 2 (Darude - Sandstorm)
    x += direction * xSpd;
    y += direction * ySpd;
    if(y + radius >= height || y - radius <= 0){
      ySpd = -ySpd;
    }
    if(x + radius >= width || x - radius <= 0){
      xSpd = -xSpd;
    }
  }

  //©Nordin El Hadaoui
  void collision() {
    //check if the enemy makes contact with the player
    
  
    for(int i = 0; i < b.length; i++){
      
      if (sqrt(((x + xRef - b[i].bPLocationXEnd) * (x + xRef - b[i].bPLocationXEnd)) + ((y + yRef - b[i].bPLocationYEnd) * (y + yRef - b[i].bPLocationYEnd))) <= radius + b[i].bPSize/2) {
        ded = true;
        print("Auchiewauchie ");
        h.score++;
      }
      }
    }

}
