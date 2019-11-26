// Jeroen Officier Acda. hier in komt het score systeem en een manier om een Highscore op
//  te slaan tussen sessies in.
class Highscore {
  int score;
  int highscoreTimer = 0;
  int numbers1, numbers2, numbers3;
  int amountOfNumbers = 3;
  String[] numbers = new String[amountOfNumbers];
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
      highscoreTimer++;
      //highscore part
      if (highscoreTimer == 1) {
        if (score>numbers1) {
          numbers3 = numbers2;
          numbers2 = numbers1;
          numbers1 = score;
        } else if (score>numbers2) {
          numbers3 = numbers2;
          numbers2 = score;
        } else if (score>numbers3) {
          numbers3 = score;
        }
        numbers[0] = str(numbers1);
        numbers[1] = str(numbers2);
        numbers[2] = str(numbers3);
        saveStrings("./data/highscore.txt", numbers);
      }
    }
  }
  void reset(){
    highscoreTimer = 0;
    
  }
}
