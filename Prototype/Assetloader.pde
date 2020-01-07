//Player related images
PImage playerBullet, playerShip;
//Powerup related images
PImage laserPowerUp, snailgun;
//health related images
PImage healthup, healthParticle, healthWarning, healthBar, healthIcon, healthDropIMG;
//enemy related images
PImage crusher, shooter, enemyBullet, donker, rainbow;
//menu related images
PImage pauzeImg, shooting, movement, startImg, yourScore, highscoreTab, titleCard, checkmark;


//Soundfile(s)
SoundFile engineA, engineB, clickA, clickB, boemA, boemB, titlescreen, pew, altSong;

//Font(s)
PFont numberFont;


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
  rainbow = loadImage("./data/img/boss.png");
  titleCard =loadImage("./data/img/titlecard.png");
  healthIcon = loadImage("./data/img/healthIcon.png");
  highscoreTab = loadImage("./data/img/highscoreTab.png"); 
  laserPowerUp = loadImage("./data/img/laser_powerup.png");
  yourScore = loadImage("./data/img/yourScore.png");
  healthup = loadImage("./data/img/healthup.png");
  healthParticle = loadImage("./data/img/healthdropParticle.png");
  healthWarning = loadImage("./data/img/healthwarning.png");
  checkmark = loadImage("./data/img/checkmark.png");
  donker = loadImage("./data/img/donker.png");

  //Load fonts
  numberFont = createFont("./data/font/Minecraftia-Regular.ttf", 32);

  //Load sounds
  engineA = new SoundFile(this, "./data/audio/engine_acceleration.wav");
  engineB = new SoundFile(this, "./data/audio/engine_idle.wav");
  clickA = new SoundFile(this, "./data/audio/ClickA.mp3");
  clickB = new SoundFile(this, "./data/audio/ClickB.mp3");
  boemA = new SoundFile(this, "./data/audio/boemA.mp3");
  boemB = new SoundFile(this, "./data/audio/boemB.mp3");
  titlescreen = new SoundFile(this, "./data/audio/soundtrack.wav");
  pew = new SoundFile(this, "./data/audio/pewA.mp3");
  altSong = new SoundFile(this, "./data/audio/altSong.wav");
}
