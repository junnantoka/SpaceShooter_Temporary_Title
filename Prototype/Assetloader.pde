PImage pauzeImg, enemyBullet, healthDrop, playerBullet, playerShip, healthBar;

//SoundFile biem;

public void loadAssets(){
  
  //Load assets
  pauzeImg = loadImage("./data/img/pauzescreen.png");
  enemyBullet = loadImage("./data/img/enemybullet.png");
  healthDrop = loadImage("./data/img/healthdrop.png");
  playerBullet = loadImage("./data/img/playerbullet.png");
  playerShip = loadImage("./data/img/playership.png");
  healthBar = loadImage("./data/img/Healthbar.png");
  
  //Load sounds
  //biem = new SoundFile(this, "./data/sounds/biem.wav");
}
