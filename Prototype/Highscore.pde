class Highscore {
  int score;
  int yofz = 80;
  int yloc = height/64*22;
  String getHighscores = "SELECT User.Username, Highscore.score, Highscore.DateGot FROM User INNER JOIN Highscore ON User.Chair_nr = Highscore.Chair_nr ORDER  BY score DESC";
  int userCount = 5;
  int highscoreTimer;
  int sqlTimer = 0;
  String[] Username = new  String[userCount];
  int[] Highscore = new int[userCount];
  String[] Date = new String[userCount];
  int amountOfUsersDisplayable;

  boolean canConnect;

  //  Dont worry about this.
  int d = day();
  int m = month();
  int y = year();
  String day = String.valueOf(d);
  String month = String.valueOf(m);
  String year = String.valueOf(y);

  void scoreSetup() {
    sqlSetup();
    //if the game can connect it will proceed to execute msql commands
    if (msql.connect()) {
      canConnect = true;
    } else {
      canConnect = false;
    }
  }
  void displayScore() {
    //"Your Score" in the top right.
    if (!start.start && !pauze.pauze) {
      textFont(numberFont);
      fill(250, 250, 250);
      textSize(36);
      image(yourScore, 1790, 80, 250, 150);
      text(score, 1770, 130);
    }
    //Highscore list in the pauze menu
    if (pauze.pauze && !start.start && !achievement.inAchievement && !goSettings && !goChallenge) {
      fill(250, 250, 250);
      textSize(38);
      text(score, width/2-25, height/16*12);
      if (canConnect == true) {
        for (int i = 0; i<amountOfUsersDisplayable; i++) {
          text(Username[i], width/64*25, yloc);
          text(Highscore[i], width/64*30, yloc);
          text(Date[i], width/64*35, yloc);
          yloc = yloc+yofz;
        }
        yloc = height/64*21;
      }
    }
  }
  // This fetches the Username and Highscore data from the database so it can be used and displayed in the game.
  void sqlSetup() {
    if ( msql.connect() ) {
      msql.query( getHighscores );
      while (msql.next() && amountOfUsersDisplayable<userCount) {
        Username[amountOfUsersDisplayable] = msql.getString("Username");
        Highscore[amountOfUsersDisplayable] = msql.getInt("score");
        Date[amountOfUsersDisplayable] = msql.getString("DateGot");
        amountOfUsersDisplayable++;
      }
    } else {
      println("Cant connect, stop trying");
    }
  }
  // Updates the top 5 Highscores that are currently loaded in the game.
  void sqlUpdate() {
    if ( msql.connect() ) {
      msql.query( getHighscores );
    } else {
      println("Cant connect, stop trying");
    }
  }
  // If chair that the game is currently using does not exist then make it exist.
  void sql() {
      msql.query("INSERT INTO Highscore (Chair_nr, score, DateGot) VALUES ( '" +  chairNr + "', '0' , '2001-11-1')");
  }
  // Saves the Highscores upon end of the game if the highscore is higher than any of the top 5.
  void highscoreSave() {
    if (healthMax <= 0) {
      highscoreTimer++;
      //highscore part
      if (canConnect) {
        if (highscoreTimer == 1) {
          if ( msql.connect() ) {
            for (int i = 0; i<Username.length; i++) {
              if (score>Highscore[i]) {
                msql.query( "UPDATE Highscore SET score = '"+score+"' WHERE Chair_nr = '"+chairNr+"' AND '" + score + "' > score" );
                String date = year + "-" + month + "-" + day;
                msql.query( "UPDATE Highscore SET DateGot = '"+date+"' WHERE Chair_nr = '"+chairNr+"'");
              }
            }
            //This makes sure there is no useless data being stored.
            //msql.query( "DELETE FROM Highscore WHERE score = 0" );
            reset();
            msql.close();
          } else {
            println("Cant connect, stop trying");
          } 
          sqlUpdate();
        }
      }
    }
  }
  //reset... lol.
  void reset() {
    highscoreTimer = 0;
    sqlTimer = 0;
  }
}
