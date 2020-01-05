// Jeroen Officier Acda. hier in komt het score systeem en een manier om een Highscore op
//  te slaan tussen sessies in.
class Highscore {
  int score;
  int yofz = 80;
  int yloc = height/64*22;
  String getHighscores = "SELECT User.Username, Highscore.score FROM User INNER JOIN Highscore ON User.Chair_nr = Highscore.Chair_nr ORDER  BY score DESC";
  int userCount = 5;
  int highscoreTimer;
  int sqlTimer = 0;
  String[] Username = new  String[userCount];
  int[] Highscore = new int[userCount];
  int i;

  boolean canConnect;
 
  // Dont worry about this.
  //String day = String.valueOf(d);
  //String month = String.valueOf(m);
  //String year = String.valueOf(y);
  //String date = year + "-" + month + "-" + day;
  //int d = day();
  //int m = month();
  //int y = year();

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
    if (pauze.pauze && !start.start) {
      fill(250, 250, 250);
      textSize(48);
      text(score, width/2-25, height/16*12);
      if (canConnect == true) {
        for (int i = 0; i<Username.length; i++) {
          text(Username[i], width/64*26, yloc);
          text(Highscore[i], width/64*33, yloc);
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
      while (msql.next() && i<userCount) {
        Username[i] = msql.getString("Username");
        Highscore[i] = msql.getInt("score");
        i++;
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
    if (!scoreExists) {
      msql.query("INSERT INTO Highscore (Chair_nr, score) VALUES ( '" +  chairNr + "', 0 )");
      scoreExists = true;
    }
  }
  // Saves the Highscores upon end of the game if the highscore is higher than any of the top 5.
  void highscoreSave() {
    //if (healthMax <= 0) {
      highscoreTimer++;
      //highscore part
      if (highscoreTimer == 1) {
        if ( msql.connect() ) {
          for (int i = 0; i<Username.length; i++) {
            if (score>Highscore[i]) {
              msql.query( "UPDATE Highscore SET score = '"+score+"' WHERE Chair_nr = '"+chairNr+"' AND '" + score + "' > score" );
            }
          }
          //This makes sure there is no useless data being stored.
          msql.query( "DELETE FROM Highscore WHERE score = 0" );
          reset();
          msql.close();
        } else {
          println("Cant connect, stop trying");
        } 
        sqlUpdate();
        
     // }
    }
  }
  //reset... lol.
  void reset() {
    highscoreTimer = 0;
    sqlTimer = 0;
  }
}
