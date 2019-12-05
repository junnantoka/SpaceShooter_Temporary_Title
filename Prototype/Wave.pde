int currentEnemyAmount;
class Wave {
  int waveNR, waveFrame, waveAmount;


  void construct() {
    waveNR = 0;
    waveFrame = 0;
    waveAmount = 1;
  }
  void update() {
    if (start.start && !pauze.pauze && !end.end) {
      if (waveFrame == 0) {
        switch(waveNR) {
        case 0:
          waveAmount = 1;
          break;
        case 1:
          waveAmount = 10;
          break;
        }
        newWave(waveAmount);
      }

      waveFrame++;
    }
  }

  void newWave(int waveAmount) {
    
  }
}
