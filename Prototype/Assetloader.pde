PImage pauzeImg, enemyBullet, healthDropIMG, playerBullet, playerShip, healthBar, movement, shooting;

//SoundFile biem;

public void loadAssets(){
  
  //Load assets
  pauzeImg = loadImage("./data/img/pauzescreen.png");
  enemyBullet = loadImage("./data/img/enemybullet.png");
  healthDropIMG = loadImage("./data/img/healthdrop.png");
  playerBullet = loadImage("./data/img/playerbullet.png");
  playerShip = loadImage("./data/img/playership.png");
  healthBar = loadImage("./data/img/healthbar.png");
  movement = loadImage("./data/img/movement.png");
  shooting = loadImage("./data/img/shooting.png");
  
  //Load sounds
  //biem = new SoundFile(this, "./data/sounds/biem.wav");
}
