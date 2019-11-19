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
    text(numbers1, 1300, 100);
    text(numbers2, 1400, 100);
    text(numbers3, 1500, 100);
    text(score, 1200, 100);
  }
}
