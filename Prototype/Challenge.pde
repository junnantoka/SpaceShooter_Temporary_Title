

class Challenge {
  
  
  void challengeScreen() {
    if(goChallenge) {
    fill(255);
    textSize(50);
    text("Challenge others!", 600, 400);
    text("SUBMIT SCORE", 650, 500);
    noStroke();
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
