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
  int d = day();
  int m = month();
  int y = year();

  boolean canConnect;

  String day = String.valueOf(d);
  String month = String.valueOf(m);
  String year = String.valueOf(y);

  String date = year + "-" + month + "-" + day;

  void scoreSetup() {
    sqlSetup();

    if (msql.connect()) {
      canConnect = true;
    } else {
      canConnect = false;
    }
  }
  void displayScore() {

    if (!start.start && !pauze.pauze) {
      textFont(numberFont);
      fill(250, 250, 250);
      textSize(36);
      image(yourScore, 1790, 80, 250, 150);
      text(score, 1770, 130);
    }

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
  void sqlSetup() {
    if ( msql.connect() ) {
      msql.query( getHighscores );
      while (msql.next() && i<userCount) {
        Username[i] = msql.getString("Username");
        Highscore[i] = msql.getInt("score");
        i++;
      }
    } else {
      println("NIET CONNECT BITCH");
    }
  }

  void sqlUpdate() {
    if ( msql.connect() ) {
      msql.query( getHighscores );
    } else {
      println("NIET CONNECT BITCH");
    }
  }

  void sql() {
    if (!chairExists) {
      msql.query("INSERT INTO Highscore (Chair_nr, score) VALUES ( '" +  chairNr + "', 0 )");
    }
  }

  void highscoreSave() {
    //if (healthMax <= 0) {
      highscoreTimer++;
      //highscore part
      if (highscoreTimer == 1) {
        if ( msql.connect() ) {
          for (int i = 0; i<Username.length; i++) {
            if (score>Highscore[i]) {
              msql.query( "UPDATE Highscore SET score = '"+score+"' WHERE Chair_nr = '"+chairNr+"' AND '" + score + "' > score" );
              //msql.query( "UPDATE Highscore SET DateGot = '"+date+"' WHERE Chair_nr = '"+chairNr+"' AND '" + score + "' > score" );
            }
          }
          msql.query( "DELETE FROM Highscore WHERE score = 0" );
          msql.close();
        } else {
          println("NIET CONNECT BITCH");
        } 
        sqlUpdate();
        
     // }
    }
  }
  void reset() {
    highscoreTimer = 0;
    sqlTimer = 0;
  }
}
