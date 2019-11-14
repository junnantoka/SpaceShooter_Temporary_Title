// Jeroen. hier in komt het score systeem en een manier om een Highscore op
//  te slaan tussen sessies in.
int switchNum = 0;
class Highscore {
  int score = 0;
  int highscoreOnStartup;
  int savedHighscore = 1;
  int[] highscore = new int[savedHighscore];
  String[] strings;
  void scoreSetup() {
    strings = loadStrings("Highscore.txt");
    highscoreOnStartup = int(strings[0]);
  }
  void scoreDisplay() {
    fill(255);
    textSize(42);
    text("Score:", 1400, 40);
    text(score, 1550, 41);
    text("Highscore:", 1300, 90);
    text(strings[0], 1550, 91);
  }
}
