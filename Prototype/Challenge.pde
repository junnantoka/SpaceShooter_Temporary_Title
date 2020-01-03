

class Challenge {
  
  
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
    
    
    }
  }
  
  void enterChallenge() {
    if (keysPressed['c']||keysPressed['C']) {
      timer++;
      if (timer==1) {
        if (!goChallenge) {
          goChallenge = true;
        } else if (goChallenge) {
          goChallenge =false;
        }
      }
    } else {
      timer=0;
    }
  }
  
}
