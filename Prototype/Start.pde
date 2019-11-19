class Start {
  boolean Start = true;
  
  void setup(){
    
    
  }
  void draw(){
    fill(255);
    rect(700, 400, 200,100);
    fill(0);
    textSize(20);
    text("click here to start", 720, 450);
  }
  
  void update(){
    if(mouseX <900 && mouseX > 700 && mouseY < 500 && mouseY> 400 && mousePressed){
      Start = false;
    }
    
  }
  
}
