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
    if (health <= 0) {
      h.  highscoreTimer++;
      //highscore part
      if (h.highscoreTimer == 1) {
        if (h.score>h.numbers1) {
          h.numbers3 = h.numbers2;
          h.numbers2 = h.numbers1;
          h.numbers1 = h.score;
        } else if (h.score>h.numbers2) {
          h.numbers3 = h.numbers2;
          h.numbers2 = h.score;
        } else if (h.score>h.numbers3) {
          h.numbers3 = h.score;
        }
        h.numbers[0] = str(h.numbers1);
        h.numbers[1] = str(h.numbers2);
        h.numbers[2] = str(h.numbers3);
        saveStrings("./data/highscore.txt", h.numbers);
      }
    }
  }
  void reset(){
    highscoreTimer = 0;
    
  }
}
