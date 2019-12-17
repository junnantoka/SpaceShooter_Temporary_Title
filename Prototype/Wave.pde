int currentEnemyAmount = 3;
int newEnemyTimer = 250;
class Wave {
  int waveNR, waveFrame, waveAmount;


  void construct() {
    waveNR = 0;
    waveFrame = 0;
    waveAmount = 1;
    currentEnemyAmount = 3;
  }
  void update() {
    if (!start.start && !pauze.pauze) {
      if (waveFrame == newEnemyTimer) {
        switch(waveNR) {
        case 0:
          waveAmount = 0;
          waveNR++;
          break;
        case 1:
          waveAmount = 5;
          waveNR++;
          break;
        case 2:
          waveAmount = 6;
          newEnemyTimer = 500;
          break;
        }
        newWave(waveAmount);
        waveFrame = 0;
      }
    }
    waveFrame++;
  }

  void newWave(int waveAmount) {
    for (int i = 0; i < waveAmount; i++) {
      enemy.add(new Enemy());
    }
  }
  void reset() {
    waveNR = 0;
  }
}
