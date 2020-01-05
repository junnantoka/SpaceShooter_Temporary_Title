class Challenge {
  boolean challengeOther;
  boolean youChallenged;
  boolean screenVisible;
  int otherScore;
  String otherUser;
  int refreshTimer;

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

  String deleteQuery = 
    " DELETE FROM userChallenged WHERE userChallenged = Chair_nr; ";


  void playerChallenged() {
    if (keysPressed['n']||keysPressed['N']) { 
      youChallenged = true;
      refreshTimer = 0;
      screenVisible = true;
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
        if (refreshTimer == 0) {
          if (msql.connect()) {
            msql.query(selectQuery);
            msql.next();
            otherScore = msql.getInt("score");
            otherUser = msql.getString("Username");
          } else {
            println("Connection failed");
          }
          refreshTimer++;
        }
      }

      if (keysPressed['w']||keysPressed['W']) {
        challengeOther = true;
        println("hey");
      } else {
        challengeOther = false;
      }
    }
  }

  void whenChallenged() {
    if (screenVisible) {
      text(otherUser + " challenges you! His score is: " + otherScore, 600, 700);

      text("Do you accept?", 700, 800);
      noFill();
      text("Yes 'A'", 700, 950);
      rect(675, 850, 200, 100);  
      text("No 'D'", 950, 950);
      rect(925, 850, 200, 100);
    }
  }

  void enterChallengeScreen() {
    if ((keysPressed['c'] || keysPressed['C']) && (pauze.pauze && !start.start)) {
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

          msql.query(insertQuery);
          msql.query(updateQuery);
          println("shit");
        }
      }
    }
  }
  void reset() {
    challengeOther = false;
  }
}
