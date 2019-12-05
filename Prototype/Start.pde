class Start {
  boolean start = true;

  void setup() {
  }
  void draw() {
    /*rectMode(0);

     fill(255);
     rect(width / 2 - 100, height/ 2 - 50, 200,100);
     fill(0);
     textSize(20);
     text("press p to start", width / 2 - 80, height/ 2 );*/
    

    /*fill(255);
    rect(width / 2 - 100, height/ 2 - 50, 200,100);
    fill(0);
    textSize(20);
    text("press p to start", width / 2 - 80, height/ 2 );*/
    image(startImg, width / 2, height/ 2, 500,300);
    image(movement, width/4-75, height/2, 500,500);
    image(shooting, width/4*3+75, height/2, 500,500);

  }

  void update() {
    //detect of het spel verder mag van de speler
    if (keysPressed['P']||keysPressed['p']) {
      start = false;
      timer++;
      if (random(0, 1) >=0.5) {
        clickA.play();
      } else {
        clickB.play();
      }
    }
  }
}
