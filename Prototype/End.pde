class End {
  boolean end = false;
  
  void setup(){
    
    
  }
  void draw(){
    fill(255, 0, 0);
    text("GAME OVER", 100, 100);
    fill(255);
    rect(700, 400, 200,100);
    fill(0);
    textSize(20);
    text("click here to play again", 720, 450);
  }
  
  void update(){
    if(mouseX <900 && mouseX > 700 && mouseY < 500 && mouseY> 400 && mousePressed){
      end = false;
    }
    
  }
  
}
