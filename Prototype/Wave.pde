class Wave {
  int waveNR, waveFrame, waveAmount, toReset, startResetting;


  void construct() {
    waveNR = 0;
    waveFrame = 0;
    waveAmount = 1;
  }

  void update() {
    if (!start.start && !pauze.pauze) {
      if (keysPressed['v']||keysPressed['V']) {
        //println(waveFrame);
        waveFrame = 0;
        waveNR = 3;
      }
      if (waveFrame == 1) {
        switch(waveNR) {
        case 0:
          waveAmount = 1;
          break;
        case 1:
          waveAmount = 10;
          print(waveAmount);
          break;
        }
        newWave(waveAmount);
      }
      waveFrame++;
      text(waveFrame, 200, 200);
    }
  }

  void newWave(int waveAmount) {
    if (startResetting >= enemies) {
      startResetting = 0;
    }
    for (toReset = startResetting; toReset > startResetting + waveAmount; toReset++) {
      enemy[toReset].reset();
    }
    print("start " + startResetting + " ");
    print("to " + toReset + " ");

    startResetting += waveAmount;
    currentEnemyAmount+= waveAmount;
  }
}
