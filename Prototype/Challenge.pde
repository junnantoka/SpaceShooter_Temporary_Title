class Challenge {
  boolean challengeOther; //Jij nodigt iemand anders uit.
  boolean youChallenged; //Jij bent uitgenodigd.
  boolean screenVisible; //Het challenge scherm is zichtbaar.
  int otherScore;
  String otherUser;
  int refreshTimer; //De timer zorgt ervoor dat alles niet altijd opnieuw wordt uitgevoerd.

  String insertQuery = //Voegt een record toe met stoelnummer. Degene die jou uitdaagt is in dit geval stoelnummer 1a. 
    " INSERT INTO Challenge (userChallenging, userChallenged) " +
    " VALUES ('"+chairNr+"', '1a') ";

  String updateQuery =  //Degene die jou uitdaagt is 2b en wordt naar 1a gezet.
    " UPDATE Challenge " +
    " SET userChallenged = '1a' " + //Dit is gehardcode om het simpel te houden maar in een echte situatie zou dit niet werken. Het zou de hele tijd naar dezelfde waarde worden veranderd.
    " WHERE userChallenging = '"+ chairNr +"' AND userChallenged = '2b' "; 

  String selectQuery = //Je krijgt een score en naam te zien van degene die jou uitdaagt.
    " SELECT User.Username, Highscore.score FROM User " +
    " INNER JOIN Challenge ON User.Chair_nr = Challenge.userChallenging " +
    " INNER JOIN Highscore ON User.Chair_nr = Highscore.Chair_nr " +
    " WHERE Challenge.userChallenged = '"+ chairNr +"'; ";

  String deleteQuery = //De uitnodiging wordt gereset. Je kan weer opnieuw uitgedaagd worden.
    " DELETE FROM Challenge WHERE userChallenged  = '"+chairNr+"'; ";


  void playerChallenged() {
    if (keysPressed['n']||keysPressed['N']) { 
      youChallenged = true;
      refreshTimer = 0;
      screenVisible = true;
    }
  }

  void challengeScreen() {
    if (goChallenge) { //Hier wordt het challenge scherm getekend.
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

      if (keysPressed['w']||keysPressed['W']) { //W nodigt anderen uit.
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
      
      if (keysPressed['k']||keysPressed['K']) {
        if(msql.connect()){
          msql.query(deleteQuery); //De uitnodiging wordt verwijderd.
        }
      }
    }
  }

  void enterChallengeScreen() {
    if ((keysPressed['c'] || keysPressed['C']) && (pauze.pauze && !start.start)) { //Het challenge scherm werkt alleen op het pauze scherm.
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
          msql.query(updateQuery); //Hier worden de queries uitgevoerd.
        }
      }
    }
  }
  void reset() {
    challengeOther = false;
  }
}
