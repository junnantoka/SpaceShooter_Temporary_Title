/*
SpaceShooter Temporary Title - HBO-ICT IG102-1 - ©IDIL
 Lennart van Dorp, 500797956
 Nordin El Hadaoui, 500833417
 Stijn Houdijk, 500825907
 Jeroen Officier, 500822999
 Darren de Vré, 500831291
 Jun Phung, 500829487
 */
import processing.sound.*; //importing the Sound library

NameScreen nameScreen = new NameScreen(); //New instance of nameScreen

import de.bezier.data.sql.*;//importing the Sql library
String dbHostID = "oege.ie.hva.nl";    // ip address, domain or hostname such as localhost
String dbUsername = "dorpl2";  //username
String dbUserPass = "kjWD660lD6ZRA0+7";  //password
String dbSchema = "zdorpl2";  //default database schema
String chairNr = "4e"; //hardcoded chairnr
MySQL msql = new MySQL( this, dbHostID, dbSchema, dbUsername, dbUserPass );//Create new mysql instance
Sql sql = new Sql();

int input_per_frame; // Keeps track of player input(s) per frame

Settings setting = new Settings(); //New instance of "Settings"

//Booleans
boolean goSettings = false;
boolean goAchievement = false;
boolean goChallenge = false;

Character character = new Character(); //New instance of "Character" 
int bosses = 20; 
ArrayList<Boss> boss; 
float yRef = height/2; //y reference point
float xRef = width/2; //x reference point

float wobbleX, wobbleY = 0;
int wobbleTimer = 0; 
Wobble wobble = new Wobble(); //New instance of "Wobble"

ArrayList<Explosion> explosion; //ArrayList explosion


Wave wave = new Wave(); //New instance of "Wave"

Star[] star; //Array of stars
Start start = new Start(); //New instance of "Start"
End end = new End();  //New instance of "End"
int stars = 500; 
int timer, enemyCounter = 0;
int timerBullet; 
int bossTotal = 1; //hardcoded bossTotal
int enemiesRequiredStart = 10;  //enemies required for a boss to spawn
int enemiesRequired = enemiesRequiredStart; 
boolean bossSpawn = false; //boolean for boss spawn

//Healthdrops
ArrayList<HealthDrop> healthDrop;

ArrayList<HealthDropParticle> healthDropParticles;

int healthBalls = 10;

//New instances
PowerUp powerUp = new PowerUp();
SnailPowerUp snailPowerUp = new SnailPowerUp();
Highscore highscore = new Highscore();
Minimap minimap = new Minimap();
Achievement achievement = new Achievement();
Challenge challenge = new Challenge();
Pauze pauze = new Pauze();
World world = new World();
Health health = new Health();

ArrayList<Enemy> enemy;
int enemies = 40;
ArrayList<EnemyBullet> eBullet;

// key detection
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];

int bullets = 10000;
int beweging = 0;
PlayerBullet[] bulletP = new PlayerBullet[bullets];
int pBTimer = 0; 

void setup() {
  fullScreen(P2D);
  noCursor();

  //checks if the chair exists in the database
  nameScreen.doesChairExist();

  //sql.construct();
  world.construct();

  //Load all assets
  loadAssets();

  imageMode(CENTER);

  health.setup();
  character.construct();
  wave.construct();

  //construct  stars
  star = new Star[stars]; 
  for (int i = 0; i < star.length; i++) {
    star[i] = new Star();
    star[i].construct();
  }

  boss = new ArrayList<Boss>();

  //initializes playerBullets array and sets starting values
  for (int i = 0; i < bullets; i++) {
    bulletP[i] = new PlayerBullet();
    bulletP[i].construct();
  }

  //initializes enemy array
  enemy = new ArrayList<Enemy>();
  enemy.add(new Enemy());

  eBullet = new ArrayList<EnemyBullet>();

  healthDrop = new ArrayList<HealthDrop>();

  explosion = new ArrayList<Explosion>();

  healthDropParticles = new ArrayList<HealthDropParticle>();


  highscore.scoreSetup();

  sql.SettingGet();
  if (soundSetting== 1) {
    firstScreen.loop();
  }
  if (soundSetting == 2) {
    badsong.loop();
  }
}

void updateGame() {
  background(0);
  challenge.playerChallenged();
  challenge.sql();
  challenge.whenChallenged();

  if (!nameEntered) nameScreen.update();
  if (nameEntered)  nameScreen.check();

  if (nameEntered) {//Only plays everything after the name is entered. 
    for (int i = 0; i < star.length; i++) {
      star[i].disp();
    }
    health.healthWarning();
    health.gameOver();
    world.update();

    if (start.start && timer == 0) {
      start.update();
    } else if (end.end && timer == 0) {
      end.update();
    } else if (!end.end && !start.start && timer == 0) {
      pauze.pauzeGame();
    } else if (timer == 20) {
      timer= 0;
    } else if (timer > 0) {
      timer++;
    }
    //pauze

    if (!pauze.pauze&& !start.start && !end.end) {
      for (int i = boss.size()-1; i >=0; i--) {
        Boss a = boss.get(i);
        a.move();
        a.collision(i);
      }
      wave.update();
      wobble.wobbleMovement();
      health.collide();

      for (int i = 0; i < bullets; i++) {
        bulletP[i].move();
      }
      bulletP[beweging].detectie();

      //runs enemy array
      timerBullet++;
      for (Enemy i : enemy) {
        i.update();
        i.shot();
      }
      for (int i = enemy.size()-1; i >= 0; i--) {
        Enemy e = enemy.get(i);
        e.collision(i);
      }

      for (int i = eBullet.size() -1; i >= 0; i--) {
        EnemyBullet e = eBullet.get(i);
        e.move(i);
      }

      for (int i = healthDrop.size() -1; i >= 0; i--) {
        HealthDrop e = healthDrop.get(i);
        e.healthCollision(i);
      }
      //call to method(s)
      spawnBoss();
      character.moveCh();
      powerUp.powerUpDate();
      snailPowerUp.snailPowerUpDate();

      for (HealthDropParticle hdp : healthDropParticles) {
        hdp.move();
      }
      for (int i = 0; i < healthDropParticles.size(); i++) {
        HealthDropParticle hdp = healthDropParticles.get(i);
        hdp.reset(i);
      }

      //Explosion when enemies die
      for (Explosion ex : explosion) {
        ex.move();
      }
      for (int i = 0; i < explosion.size(); i++) {
        Explosion ex = explosion.get(i);
        ex.reset(i);
      }
    }
    if (end.end ||start.start||pauze.pauze) {
      if (!achievement.inAchievement && !goChallenge) {
        setting.enterSettings();
        setting.settingUpdate();
      }
      if (!goSettings && !goChallenge) {
        achievement.enterAchievement();
        achievement.achievementUpdate();
      }
      if (!achievement.inAchievement && !goSettings) {
        challenge.enterChallengeScreen();
      }
    }
  }
}


void drawGame() {
  if (!nameEntered) {
    nameScreen.display();
  }
  if (nameEntered) {
    //draws stars
    world.display();

    for (HealthDropParticle hdp : healthDropParticles) {
      hdp.display();
    }

    for (Explosion ex : explosion) {
      ex.display();
    }
    if (eBullet.size() >0) {
      for (EnemyBullet i : eBullet) {
        i.draw();
      }
    }
    powerUp.display(); 
    snailPowerUp.display(); 

    for (int i = boss.size()-1; i >=0; i--) {
      Boss a = boss.get(i);
      a.draw();
    }

    if (!start.start) {
      for (int i = 0; i < bullets; i++) {
        bulletP[i].draw();
      }

      for (Enemy i : enemy) {
        if (!i.dead) {
          i.draw();
        }
      }
      health.draw();
      for (int i = 0; i< healthDrop.size(); i++) {
        HealthDrop h = healthDrop.get(i);
        h.spawnHealth(i);
      }
      if (!end.end) {
        minimap.miniMap();
      }
    }

    if (!goSettings && !goAchievement && !goChallenge) {
      highscore.displayScore();
      pauze.draw();
      if (start.start) {
        start.draw();
      }
      if (end.end) {
        end.draw();
      }
    }

    if (end.end ||start.start||pauze.pauze) {
      setting.settingScreen();
      achievement.achievementScreen();
      challenge.challengeScreen();
    }
    if ( !start.start && !end.end && !pauze.pauze) {
      character.displayCh();
    }
    if (!goSettings ) {
      highscore.displayScore();
    }
  }
}

void draw() {
  updateGame();
  drawGame();
}

// Keyboard handling...
void keyPressed() {  
  if (keyCode >= KEY_LIMIT) return; //safety: if keycode exceeds limit, exit methhod ('return').
  keysPressed[keyCode] = true; // set its boolean to true
}

//..and with each key Released vice versa
void keyReleased() {
  if (keyCode >= KEY_LIMIT) return;
  keysPressed[keyCode] = false;
}


void spawnBoss() {
  if (enemyCounter == enemiesRequired) {
    if ( enemiesRequired> enemiesRequiredStart) {
      bossTotal++;
    } 
    enemyCounter = 0;
    bossSpawn = true;
    enemiesRequired *= 2;
  }
  if (bossSpawn == true) {
    for (int i = 0; i<=bossTotal; i++) {
      boss.add(new Boss());
    }
    bossSpawn = false;
  }
}
