

class Settings {
  float artX = 800;
  float artY = 250;
  float soundX = 650;
  float soundY =650;
  float rectselectSoundGoodX= artX-80;
  float rectselectArtGoodY=artY+75;
  float rectselectSoundBadX= artX+300;
  float rectselectArtBadY=artY+75;
  float rectselectArtGoodX= artX-80;
  float rectselectSoundGoodY=soundY+75;
  float rectselectArtBadX= artX+300;
  float rectselectSoundBadY=soundY+75;
  float textBadX =artX+200;
  float textGoodX =artX-200;
  float underSoundY =soundY+150;
  float underArtY =artY+150;
  float selectX = rectselectSoundGoodX;
  float selectY= rectselectArtGoodY;
  int timer =0;

  void settingScreen() {
    if (goSettings) {
      rectMode(CENTER);
      textFont(numberFont);
      textSize(150);
      noFill();
      text("art", artX, artY);
      text("Sound", soundX, soundY);
      textSize(75);
      text("'good'", textGoodX, underArtY);
      text("bad", textBadX, underArtY);
      text("'good'", textGoodX, underSoundY);
      text("bad", textBadX, underSoundY);

      if (soundSetting == 1) {
        rect(rectselectSoundGoodX, rectselectSoundGoodY, 300, 150);
      }
      if (soundSetting == 2) {
        rect(rectselectSoundBadX, rectselectSoundBadY, 300, 150);
      }
      if (artSetting == 1) {
        rect(rectselectArtGoodX, rectselectArtGoodY, 300, 150);
      }
      if (artSetting == 2) {
        rect(rectselectArtBadX, rectselectArtBadY, 300, 150);
      }
      stroke(#B200A0);
      rect(selectX, selectY, 300, 150);
    }
  }
  void settingUpdate() {
    if (goSettings ) {
      if (keysPressed['a']||keysPressed['A']) {
        selectX=rectselectSoundGoodX;
      }
      if (keysPressed['d']||keysPressed['D']) {
        selectX=rectselectSoundBadX;
      }
      if (keysPressed['w']||keysPressed['W']) {

        selectY=rectselectArtGoodY;
      }
      if (keysPressed['s']||keysPressed['S']) {
        selectY=rectselectSoundGoodY;
      }
      if (keysPressed[DOWN]) {
        if (selectY ==rectselectSoundGoodY) {
          if (selectX==rectselectSoundGoodX) {
            soundSetting = 1;
            sql.updateData();
          }
          if (selectX==rectselectSoundBadX) {
            soundSetting = 2;
            sql.updateData();
          }
        } else if (selectY ==rectselectArtGoodY) {
          if (selectX==rectselectSoundGoodX) {
            artSetting = 1;
            sql.updateData();
          }
          if (selectX==rectselectSoundBadX) {
            artSetting = 2;
           sql.updateData();
          }
        }
      }
    }
  }

  void enterSettings() {

    if (keysPressed[UP]) {
      timer++;

      if (timer==1) {

        if (!goSettings) {
          goSettings = true;
        } else if (goSettings) {
          goSettings =false;
        }
      }
    } else {
      timer=0;
    }
  }
}
