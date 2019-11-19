PImage pauzeImg, enemyBullet, healthDrop, playerBullet;

//SoundFile biem;

public void loadAssets(){
  
  //Load assets
  pauzeImg = loadImage("./data/img/pauzescreen.png");
  enemyBullet = loadImage("./data/img/enemybullet.png");
  healthDrop = loadImage("./data/img/healthdrop.png");
  playerBullet = loadImage("./data/img/playerbullet.png");
  
  //Load sounds
  //biem = new SoundFile(this, "./data/sounds/biem.wav");
}
