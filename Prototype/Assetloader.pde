
PImage pauzeImg, enemyBullet, healthDropIMG, playerBullet, playerShip, healthBar, movement, shooting, crusher, shooter, snailgun, startImg, bossone, titleCard, healthIcon, highscoreTab, laserPowerUp, yourScore, healthup;

SoundFile engineA, engineB, clickA, clickB, boemA, boemB, titlescreen, pew;
PFont numberFont;
//SoundFile biem;

public void loadAssets() {

  //Load assets
  pauzeImg = loadImage("./data/img/pauzescreen.png");
  enemyBullet = loadImage("./data/img/enemybullet.png");
  healthDropIMG = loadImage("./data/img/healthdrop.png");
  playerBullet = loadImage("./data/img/playerbullet.png");
  playerShip = loadImage("./data/img/playership.png");
  healthBar = loadImage("./data/img/healthbar.png");
  movement = loadImage("./data/img/movement.png");
  shooting = loadImage("./data/img/shooting.png");
  crusher = loadImage("./data/img/crusher.png");
  shooter = loadImage("./data/img/shooter.png");
  snailgun = loadImage("./data/img/snailgun.png");
  startImg = loadImage("./data/img/startImg.png");
  bossone = loadImage("./data/img/boss.png");
  titleCard =loadImage("./data/img/titlecard.png");
  healthIcon = loadImage("./data/img/healthIcon.png");
  highscoreTab = loadImage("./data/img/highscoreTab.png"); 
  numberFont = createFont("./data/font/Minecraftia-Regular.ttf", 32);
  laserPowerUp = loadImage("./data/img/laser_powerup.png");
  yourScore = loadImage("./data/img/yourScore.png");
  healthup = loadImage("./data/img/healthup.png");
  
  //Load sounds
  engineA = new SoundFile(this, "./data/audio/engine_acceleration.wav");
  engineB = new SoundFile(this, "./data/audio/engine_idle.wav");
  clickA = new SoundFile(this, "./data/audio/ClickA.mp3");
  clickB = new SoundFile(this, "./data/audio/ClickB.mp3");
  boemA = new SoundFile(this, "./data/audio/boemA.mp3");
  boemB = new SoundFile(this, "./data/audio/boemB.mp3");
  titlescreen = new SoundFile(this, "./data/audio/soundtrack.wav");
  pew = new SoundFile(this, "./data/audio/pewA.mp3");
}
