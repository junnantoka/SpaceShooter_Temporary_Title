//prototype bullethell IDIL
//character movement w a s d
//bullet shooting up down left right
Character character = new Character();
float yRef = height/2;
float xRef = width/2;

Star[] star;
Start start = new Start();
End end= new End();
int stars = 300;

//Healthdrops
HealthDrop[] healthDrop;
int healthBalls = 10;


// jeroens deel
Highscore highscore = new Highscore();

Pauze pauze = new Pauze();

Enemy[] enemy;
int enemies = 10;
//jeroens deel
EnemyBullet[] eBullet;


Health health = new Health();

// key detection
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];
//stijns deel
int bullets = 1000;
int beweging = 0;
PlayerBullet[] bulletP = new PlayerBullet[bullets];
int pBTimer = 0; 
//eind stijns deel


void setup() {
  //size(1920, 1080, P2D);
  fullScreen(P2D);
  
  //Load all assets
  loadAssets();
  imageMode(CENTER);
  
  health.setup();
  pauze.setup();

  character.construct();

  //construct  stars
  star = new Star[stars]; 
  for (int i = 0; i<star.length; i++) {
    star[i] = new Star();
    star[i].construct();
  }

  //stijns deel
  //initializes playerBullets array and sets starting values
  for (int i = 0; i <bullets; i++) {
    bulletP[i] = new PlayerBullet();
    bulletP[i].construct();
  }
  //eind stijns deel

  //initializes enemy array
  enemy = new Enemy[enemies];
  for (int i=0; i<enemy.length; i++) {
    enemy[i] = new Enemy();
  }
  //Jeroens deel
  eBullet = new EnemyBullet[enemies];
  for (int i =0; i<eBullet.length; i++) {
    eBullet[i] = new EnemyBullet();
    eBullet[i].bulletSetup();
  }
  highscore.scoreSetup();

  healthDrop = new HealthDrop[healthBalls];
  for (int i=0; i<healthDrop.length; i++) {
    healthDrop[i] = new HealthDrop();
    healthDrop[i].healthSetup();
  }
}

void updateGame() {
  background(0);
  health.gameOver();
  
  if (start.Start){
  start.update();
  }
  else if (end.end){
  end.update();
  }
  else if (!end.end && !start.Start){
  pauze.pauzeGame();
  }
  //pauze
  
  if (!pauze.pauze&& !start.Start && !end.end) {
    health.collide();
    character.moveCh();
    character.chCollision();
    //stijns deel
    for (int i = 0; i <bullets; i++) {
      bulletP[i].move();
    }
    bulletP[beweging].detectie();
    //eind stijns deel
    //runs enemy array
    for (int i = 0; i<enemy.length; i++) {
      enemy[i].update();
      enemy[i].collision();
      eBullet[i].bulletDespawn();
      eBullet[i].bulletSpawn(i);
    }

    for (int i=0; i<healthDrop.length; i++) {
      healthDrop[i].updateHealth(i);
    }
  }
}


void drawGame() {
   for (int i = 0; i<star.length; i++) {
    star[i].disp();
  }
  
  //draws stars


 
  
  for (int i = 0; i <enemy.length; i++) {
    eBullet[i].draw();
  }
     
if(!start.Start){
  for (int i = 0; i <bullets; i++) {
    bulletP[i].draw();
  }
health.draw();
  character.displayCh();
  for (int i = 0; i<enemy.length; i++) {
    if (!enemy[i].ded) {
      enemy[i].draw();
    } else {
      enemy[i] = new Enemy();
    }
  }

  for (int i=0; i<healthDrop.length; i++) {
    healthDrop[i].displayHealth();
  }
  pauze.draw();
  
}
if(start.Start){
  start.draw();
  }
  if (end.end){
    end.draw();
  }
   highscore.scoreDisplay();
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
