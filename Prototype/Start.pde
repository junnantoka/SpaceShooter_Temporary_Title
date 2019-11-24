class Start {
  boolean Start = true;
  
  void setup(){
    
    
  }
  void draw(){
    fill(255);
    rect(width / 2 - 100, height/ 2 - 50, 200,100);
    fill(0);
    textSize(20);
    text("press p to start", width / 2 - 80, height/ 2 );
  }
  
  void update(){
    if(keysPressed['P']||keysPressed['p']){
      Start = false;
    }
  }
}
