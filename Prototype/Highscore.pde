// Jeroen Officier Acda. hier in komt het score systeem en een manier om een Highscore op
//  te slaan tussen sessies in.
class Highscore {
  int score;
  int highscoreTimer = 0;
  int numbers1, numbers2, numbers3, numbers4, numbers5;
  int amountOfNumbers = 5;
  String[] numbers = new String[amountOfNumbers];
  void scoreSetup() {
    String[] numbers = loadStrings("./data/highscore.txt");    
    numbers1 = int(numbers[0]);
    numbers2 = int(numbers[1]);
    numbers3 = int(numbers[2]);
    numbers4 = int(numbers[3]);
    numbers5 = int(numbers[4]);
  }
  void drawScore() {
    if (!pauze.pauze && !start.start) {
      image(yourScore, 1790, 80, 250, 150);
    }
    textFont(numberFont);
  }
  void updateScore() {
    if (pauze.pauze == true) {
    fill(250, 250, 250);
    textSize(36);
    text(numbers1, 1520, 370);
    text(numbers2, 1520, 440);
    text(numbers3, 1520, 510);
    text(numbers4, 1520, 580);
    text(numbers5, 1520, 650);
    text(score, 1520, 800);
    }
    text(score, 1520, 800);
  }


  void highscoreSave() {
    if (healthMax <= 0) {
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
    }
  }
  void reset() {
    highscoreTimer = 0;
  }
}
