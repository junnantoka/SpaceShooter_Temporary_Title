int currentEnemyAmount = 3;
int newEnemyTimer = 250;
class Wave {
  int waveNR, waveFrame, waveAmount;


  void construct() {
    waveNR = 0;
    waveFrame = 0;
    waveAmount = 1;
  }
  void update() {
    if (!start.start && !pauze.pauze) {
      
      if (waveFrame >= newEnemyTimer || enemy.size()<1) {
        switch(waveNR) {
        case 0:
          waveAmount = 1;
          waveNR++;
          newEnemyTimer = 250;
          break;
        case 1:
          waveAmount = 5;
          waveNR++;
          newEnemyTimer = 300;
          break;
        case 2:
          waveAmount = 6;
          newEnemyTimer = 500;
          waveNR++;
          break;
        case 3:
          waveAmount = 8;
          newEnemyTimer = enemy.size() * 40;
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
    construct();
  }
}
