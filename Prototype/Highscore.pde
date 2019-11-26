// Jeroen Officier Acda. hier in komt het score systeem en een manier om een Highscore op
//  te slaan tussen sessies in.
class Highscore {
  int score;
  int highscoreTimer = 0;
  int numbers1, numbers2, numbers3;
  int amountofnumbers = 3;
  String[] numbers = new String[amountofnumbers];
  void scoreSetup() {
    String[] numbers = loadStrings("./data/highscore.txt");    
    numbers1 = int(numbers[0]);
    numbers2 = int(numbers[1]);
    numbers3 = int(numbers[2]);
  }
  void scoreDisplay() {
    fill(255);
    textSize(42);
    text(numbers1, width - 300, 50);
    text(numbers2, width - 200, 50);
    text(numbers3, width - 100, 50);
    text(score, width - 400, 50);
  }

  void highscoreSave() {
    if (healthMax <= 0) {
      highscore.  highscoreTimer++;
      //highscore part
      if (highscore.highscoreTimer == 1) {
        if (highscore.score>highscore.numbers1) {
          highscore.numbers3 = highscore.numbers2;
          highscore.numbers2 = highscore.numbers1;
          highscore.numbers1 = highscore.score;
        } else if (highscore.score>highscore.numbers2) {
          highscore.numbers3 = highscore.numbers2;
          highscore.numbers2 = highscore.score;
        } else if (highscore.score>highscore.numbers3) {
          highscore.numbers3 = highscore.score;
        }
        highscore.numbers[0] = str(highscore.numbers1);
        highscore.numbers[1] = str(highscore.numbers2);
        highscore.numbers[2] = str(highscore.numbers3);
        saveStrings("./data/highscore.txt", highscore.numbers);
      }
    }
  }
  void reset(){
    highscoreTimer = 0;
    
  }
}
