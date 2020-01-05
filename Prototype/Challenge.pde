class Challenge {
  boolean challengeOther;
  boolean youChallenged;
  String insertQuery = 
    " INSERT INTO User_issues_Challenge (User_Chair_nr, Challenge_userChallenging, Challenge_userChallenged) " +
    " VALUES ('"+ chairNr +"', 1, 0) ";

  String updateQuery = 
    " UPDATE User_issues_Challenge" +
    " SET Challenge_userChallenged = 1 " +
    " WHERE User_Chair_nr = '"+ chairNr +"' AND Challenge_userChallenged = 0; ";

  String selectQuery = 
    " SELECT User.Username, Highscore.score FROM User " +
    " INNER JOIN Challenge ON User.Chair_nr = Challenge.userChallenging " +
    " INNER JOIN Highscore ON User.Chair_nr = Highscore.Chair_nr " +
    " WHERE Challenge.userChallenged = '"+ chairNr +"'; ";

  void playerChallenged() {
    if (keysPressed['n']||keysPressed['N']) { 
      youChallenged = true;
    }
  }

  void challengeScreen() {
    if (goChallenge) {
      cursor();
      fill(255);
      textSize(50);
      text("Challenge others to beat your score.", 600, 400);
      text("CHALLENGE!", 650, 500);
      noFill();
      rect(600, 400, 500, 100);  

      text("Press N to refresh challenges.", 600, 600);

      if (youChallenged) {
        if (msql.connect()) {
          msql.query(selectQuery);
          int otherScore = msql.getInt("score");
          String otherUser = msql.getString("Username");
          text(otherUser + " challenges you! His score is: " + otherScore, 600, 700);

          text("Do you accept?", 600, 800);
            
          text("Yes", 600, 950);
          rect(575, 850, 150, 100);  
          text("No", 800, 950);
          rect(775, 850, 150, 100);
        } else {
          println("Connection failed");
        }
      }

      if (mouseX > 600 && mouseX < 1100 && mouseY > 400 && mouseY > 500 && mousePressed) {
        challengeOther = true;
      } else {
        challengeOther = false;
      }
    }
  }

  void enterChallengeScreen() {
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
        if (challengeOther) {

          msql.query(selectQuery);
          println("shit");
        }
      }
    }
  }
  void reset() {
    challengeOther = false;
  }
}
