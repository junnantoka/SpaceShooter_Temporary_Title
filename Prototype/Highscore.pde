// Jeroen Officier Acda. hier in komt het score systeem en een manier om een Highscore op
//  te slaan tussen sessies in.
class Highscore {
  int score;
  int yofz = 80;
  int y = height/64*22;
  int scoreTimer;
  String getHighscores = "SELECT * FROM Highscore";
  int userCount = 5;
  int highscoreTimer;
  String[] Names;
  String[] Dates;
  int[] Scores;
  void scoreSetup() {
    sql();
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
      for (HighscoreDataArraylist record : data) {
        text(record.name, width/64*26, y);
        text(record.Highscore, width/64*33, y);
        y = y+yofz;
      }
      y = height/64*21;
    }
  }
  void sql() {
    if ( msql.connect() ) {
      msql.query( getHighscores );
      while (msql.next()) {
        data.add(new HighscoreDataArraylist(msql.getString("name"), msql.getInt("score")));
        //String name = msql.getString("name");
        //int Highscore = msql.getInt("score");
        //text(name, width/8*3, height/2+yofz);
        //text(Highscore, width/8*4, height/2+yofz);
      }
      msql.close();
    }
  }

  void highscoreSave() {
    /*if (healthMax <= 0) {
     highscoreTimer++;
     //highscore part
     if (highscoreTimer == 1) {
     if (score>numbers1) {
     numbers5 = numbers4;
     numbers4 = numbers3;
     numbers3 = numbers2;
     numbers2 = numbers1;
     numbers1 = score;
     } else if (score>numbers2) {
     numbers5 = numbers4;
     numbers4 = numbers3;
     numbers3 = numbers2;
     numbers2 = score;
     } else if (score>numbers3) {
     numbers5 = numbers4;
     numbers4 = numbers3;
     numbers3 = score;
     } else if (score>numbers4) {
     numbers5 = numbers4;
     numbers4 = score;
     } else if (score>numbers5) {
     numbers5 = score;
     }
     numbers[0] = str(numbers1);
     numbers[1] = str(numbers2);
     numbers[2] = str(numbers3);
     numbers[3] = str(numbers4);
     numbers[4] = str(numbers5);
     saveStrings("./data/highscore.txt", numbers);
     }
     }*/
  }
  void reset() {
    highscoreTimer = 0;
  }
}
