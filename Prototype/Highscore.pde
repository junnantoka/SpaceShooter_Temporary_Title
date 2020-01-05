// Jeroen Officier Acda. hier in komt het score systeem en een manier om een Highscore op
//  te slaan tussen sessies in.
class Highscore {
  int score;
  int yofz = 80;
  int y = height/64*22;
  String getHighscores = "SELECT User.Username, Highscore.score FROM User INNER JOIN Highscore ON User.Chair_nr = Highscore.Chair_nr ORDER  BY score DESC";
  int userCount = 5;
  int highscoreTimer;
  int sqlTimer = 0;
  String[] Username = new  String[userCount];
  int[] Highscore = new int[userCount];
  int i;
  void scoreSetup() {
    sqlSetup();
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

      sql();
      for (int i = 0; i<Username.length; i++) {
        text(Username[i], width/64*26, y);
        text(Highscore[i], width/64*33, y);
        y = y+yofz;
      }
    }
  }

  void sqlSetup() {
    if (!chairExists) {
      if (msql.connect()) {
        msql.query("INSERT INTO Highscore (`Chair_nr`, `score`) VALUES ( '" +  chairNr + "',  0 )");
      }
    }
  }


  void sql() {

    if ( msql.connect() ) {
      msql.query( getHighscores );
      while (msql.next() && i<userCount) {
        Username[i] = msql.getString("Username");
        Highscore[i] = msql.getInt("score");
        i++;
      }
      msql.close();
      y = height/64*21;
    }
  }
  void highscoreSave() {
    if (healthMax <= 0) {
      highscoreTimer++;
      //highscore part
      if (highscoreTimer == 1) {
        if (score>Highscore[0]) {
          Highscore[5] = Highscore[4];
          Highscore[4] = Highscore[3];
          Highscore[3] = Highscore[2];
          Highscore[2] = Highscore[1];
          Highscore[1] = score;
        } else if (score>Highscore[2]) {
          Highscore[5] = Highscore[4];
          Highscore[4] = Highscore[3];
          Highscore[3] = Highscore[2];
          Highscore[2] = score;
        } else if (score>Highscore[3]) {
          Highscore[5] = Highscore[4];
          Highscore[4] = Highscore[3];
          Highscore[3] = score;
        } else if (score>Highscore[4]) {
          Highscore[5] = Highscore[4];
          Highscore[4] = score;
        } else if (score>Highscore[5]) {
          Highscore[5] = score;
        }
      }
      //saveStrings("./data/highscore.txt", numbers);
    }
  }
  void reset() {
    highscoreTimer = 0;
    sqlTimer = 0;
  }
}
