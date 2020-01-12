int newEnemyTimer = 250;
class Wave {
  int waveNR, waveFrame, waveAmount, timerMult, minTimerMult, maxEnemiesSpawned;
  float maxEnemiesSpawnedFloat, moreEnemiesSpeed;

  void construct() {
    waveNR = 0;
    waveFrame = 0;
    waveAmount = 1;
    timerMult = 50;
    minTimerMult = 30;
    maxEnemiesSpawnedFloat = 8;
    moreEnemiesSpeed = 0.1;
  }
  void update() {
    if (!start.start && !pauze.pauze) {
      maxEnemiesSpawned = int(maxEnemiesSpawnedFloat);
      if (waveFrame >= newEnemyTimer || (enemy.size()<1)) {
        switch(waveNR) {//
        case 0:
          waveAmount = 1;
          waveNR++;
          newEnemyTimer = 500;
          break;
        case 1:
          waveAmount = 5;
          waveNR++;
          newEnemyTimer = 400;
          break;
        case 2:
          waveAmount = 6;
          newEnemyTimer = 500;
          waveNR++;
          break;
        case 3:
          waveAmount = maxEnemiesSpawned - enemy.size()/2;
          newEnemyTimer = enemy.size() * timerMult;
          if (timerMult > minTimerMult) {
            timerMult--;
          }
          break;
        }
        maxEnemiesSpawnedFloat += moreEnemiesSpeed;
        newWave(waveAmount);
        waveFrame = 0;
      }
    }
    if (waveNR > 0) {
      waveFrame++;
      text(waveNR, width/2, 100);
    }
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
