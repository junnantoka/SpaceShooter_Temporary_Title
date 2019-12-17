import processing.sound.*; //importing the Sound library

//prototype bullethell IDIL
//character movement w a s d
//bullet shooting up down left right
Character character = new Character();
int bosses = 20;
Boss[] boss;
float yRef = height/2;
float xRef = width/2;
int kaas= 240;
float  wobbleX, wobbleY= 0;
int wobbleTimer = 0;
Wobble wobble = new Wobble();

ArrayList<Explosion> explosion;

ArrayList<PlayerParticle> playerParticle;

Wave wave = new Wave();

Star[] star;
Start start = new Start();
End end = new End();
int stars = 300;
int timer, enemyCounter = 0;
int timerBullet;
int bossTotal = 1;
int enemiesRequiredStart = 20;
int enemiesRequired = enemiesRequiredStart;
boolean bossSpawn = false;

//WorldBorder
World world = new World();

//Healthdrops
ArrayList<HealthDrop> healthDrop;
int healthBalls = 10;

PowerUp powerUp = new PowerUp();


// jeroens deel
Highscore highscore = new Highscore();
Minimap minimap = new Minimap();


Pauze pauze = new Pauze();

ArrayList<Enemy> enemy;
int enemies = 40;
//jeroens deel
ArrayList<EnemyBullet> eBullet;

Health health = new Health();

// key detection
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];

int bullets = 100000;
int beweging = 0;
PlayerBullet[] bulletP = new PlayerBullet[bullets];
int pBTimer = 0; 

void setup() {
  fullScreen(P2D);
  noCursor();

  world.construct();

  //Load all assets
  loadAssets();
  titlescreen.loop();
  imageMode(CENTER);

  health.setup();
  minimap.setup();
  pauze.setup();
  character.construct();

  //construct  stars
  star = new Star[stars]; 
  for (int i = 0; i < star.length; i++) {
    star[i] = new Star();
    star[i].construct();
  }

  boss= new Boss[bosses];
  for (int i = 0; i < boss.length; i++) {
    boss[i] = new Boss();
  }

  //initializes playerBullets array and sets starting values
  for (int i = 0; i < bullets; i++) {
    bulletP[i] = new PlayerBullet();
    bulletP[i].construct();
  }

  //initializes enemy array
  enemy = new ArrayList<Enemy>();
  enemy.add(new Enemy());

  eBullet =new ArrayList<EnemyBullet>();

  highscore.scoreSetup();

  healthDrop = new ArrayList<HealthDrop>();

  explosion = new ArrayList<Explosion>();
  
  playerParticle = new ArrayList<Particle>();
}

void updateGame() {
  background(0);

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
    for (int i = 0; i < boss.length; i++) {
      boss[i].collision();
      boss[i].move();
    }
    wave.update();
    wobble.wobbleMovement();
    health.collide();


    for (int i = 0; i < bullets; i++) {
      bulletP[i].move();
    }
    bulletP[beweging].detectie();

    powerUp.display(); 

    //runs enemy array
    timerBullet++;
    for (Enemy i : enemy) {
      i.update();
    }
    for (int i = 0; i < enemy.size(); i++) {
      Enemy e = enemy.get(i);
      e.collision(i);
      e.shot();
    }



    for (int i = eBullet.size() -1; i >= 0; i--) {
      EnemyBullet e = eBullet.get(i);
      e.move(i);
    }

    for (int i = healthDrop.size() -1; i >= 0; i--) {
      //i.updateHealth();
      HealthDrop e = healthDrop.get(i);
      e.healthCollision(i);
    }
    spawnBoss();
    character.moveCh();

    //explosion van Lennart wanneer enemies sterven
    for (Explosion ex : explosion) {
      ex.move();
      print(ex);
    }
    for (int i = 0; i < explosion.size(); i++) {
      Explosion ex = explosion.get(i);
      ex.reset(i);
    }
    
    for (PlayerDamageEffect ef : playerParticle) {
      ef.move();
    }
    for (int i = 0; i < playerParticle.size(); i++) {
      PlayerDamageEffect ef = playerParticle.get(i);
      ef.reset(i);
    }
    
  }
}


void drawGame() {

  //draws stars
  for (int i = 0; i < star.length; i++) {
    star[i].disp();
  }

  world.display();

  for (Explosion ex : explosion) {
    ex.display();
  }
  if (eBullet.size() >0) {
    for (EnemyBullet i : eBullet) {
      i.draw();
    }
  }

  for (int i = 0; i < boss.length; i++) {
    boss[i].draw();
  }

  if (!start.start) {
    for (int i = 0; i < bullets; i++) {
      bulletP[i].draw();
    }

    for (Enemy i : enemy) {
      if (!i.ded) {
        i.draw();
      } /*else {
       i = new Enemy();
       }*/
    }
    health.draw();
    for (int i = 0; i< healthDrop.size(); i++) {
      HealthDrop h = healthDrop.get(i);
      h.spawnHealth(i);
    }
    if (!end.end) {
      minimap.draw();
    }
    pauze.draw();
  }

  if (start.start) {
    start.draw();
  }
  if (end.end) {
    end.draw();
  }
  highscore.scoreDisplay();
  if ( !start.start && !end.end) {
    character.displayCh();
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


//Kan dit niet in de boss class??3
void spawnBoss() {
  if (enemyCounter == enemiesRequired) {
    if (bossTotal < bosses-1 && enemiesRequired> enemiesRequiredStart) {
      bossTotal++;
    } 
    enemyCounter = 0;
    bossSpawn = true;
    enemiesRequired *= 2;
  }
  if (bossSpawn == true) {
    for (int i = 0; i<bossTotal; i++) {
      boss[i].ded = false;
    }
    bossSpawn = false;
  }
}
