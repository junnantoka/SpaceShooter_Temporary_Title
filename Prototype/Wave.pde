int currentEnemyAmount = 3;
int newEnemyTimer = 250;
class Wave {
  int waveNR, waveFrame, waveAmount;


  void construct() {
    waveNR = 0;
    waveFrame = 0;
    waveAmount = 1;
    currentEnemyAmount = 30;
  }
  void update() {
    if (!start.start && !pauze.pauze) {
      if (waveFrame == newEnemyTimer) {
        switch(waveNR) {
        case 0:
          waveAmount = 1;
          break;
        case 1:
          waveAmount = 10;
          break;
        }
        newWave(waveAmount);
        waveFrame = 0;
      }
    }
    waveFrame++;
  }

  void newWave(int waveAmount) {
    if (!(currentEnemyAmount == enemies)) {
      enemy[currentEnemyAmount].reset();
      currentEnemyAmount++;
    }
  }
}
