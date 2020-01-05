class Challenge {
  boolean challenged;
  String selectQuery = " SELECT DISTINCT A.Chair_nr, A.Username, B.Chair_nr, B.Username, score " +
                       " FROM User A, User B, Highscore " +
                       " WHERE A.Username != B.Username " +
                       " ORDER BY A.Chair_nr; ";
  
  void challengeScreen() {
    if(goChallenge) {
    
    cursor();
    fill(255);
    textSize(50);
    text("Challenge others to beat your score.", 600, 400);
    text("CHALLENGE!", 650, 500);
    noFill();
    rect(600,400,500,100);
    //rect(width/4, height/4, 950,600);   
    
    if (mouseX > 600 && mouseX < 1100 && mouseY > 400 && mouseY > 500) {
     challenged = true; 
     }else{
      challenged = false; 
     }
    }
  }
  
  void enterChallenge() {
    if (keysPressed['c']||keysPressed['C']) {
      timer++;
      if (timer==1) {
        if (!goChallenge) {
          goChallenge = true;
        } else if (goChallenge) {
          goChallenge = false;
        }
      }
    } else {
      timer=0;
    }
  }
  
  void sql() {
    if (keysPressed['c']||keysPressed['C']) {
      if (msql.connect()) {
        if(challenged){
          
          msql.query(selectQuery);
          println("shit");
          }
      }
    }
  }
  
  void reset() {
  challenged = false; 
    
  }  
}
