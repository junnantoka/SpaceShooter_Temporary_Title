//Prototype bullethell IDIL
//Character movement w a s d
//Bullet shooting ^ v < >
Character c = new Character();
float yRef, xRef = 0;

Star[] s;
int stars = 300;

// jeroens deel
Highscore h = new Highscore();
//

Enemy[] e;
int enemies = 10;
//jeroens deel
EnemyBullet[] eBullet;
//

float health = 3;
int gameOver = 3;

// key detection
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];
//stijns deel
int bullets = 1000;
int beweging = 0;
PlayerBullet[] b = new PlayerBullet[bullets];
int pBTimer = 0; 
//eind stijns deel


void setup() {
  size(1600, 900, P2D);
  
  c.construct();
  
  //Lennarts deel construct stars
  s = new Star[stars]; 
  for(int i = 0; i < s.length; i++){
    s[i] = new Star();
    s[i].construct();
  }
  //eind Lennarts deel
  
  //stijns deel
  //initializes playerBullets array and sets starting values
  for (int i = 0; i <bullets; i++) {
    b[i] = new PlayerBullet();
    b[i].construct();
  }
  //eind stijns deel

  //initializes enemy array
  e = new Enemy[enemies];
  for (int i=0; i<e.length; i++) {
    e[i] = new Enemy();
  }
  //Jeroens deel
  eBullet = new EnemyBullet[enemies];
  for (int i =0; i<eBullet.length; i++) {
    eBullet[i] = new EnemyBullet();
    eBullet[i].bulletSetup();
  }
  h.scoreSetup();
}

void updateGame() {
  background(0);
  c.moveCh();
  c.chCollision();
  //stijns deel
  for (int i = 0; i <bullets; i++) {
    b[i].move();
  }
  b[beweging].detectie();
  //eind stijns deel
  //runs enemy array
  for (int i = 0; i<e.length; i++) {
    e[i].update();
    e[i].collision();
    eBullet[i].bulletDespawn();
    eBullet[i].bulletSpawn(i);
  }
  h.scoreDisplay();
}

void drawGame() {
  //draws stars
  for(int i = 0; i<s.length; i++){
    s[i].disp();
  }
  for(int i = 0; i <e.length; i++){
    eBullet[i].draw();
  }
  
  for (int i = 0; i <bullets; i++) {
    b[i].draw();
  }
  
  c.displayCh();
  for (int i = 0; i<e.length; i++) {
    if (!e[i].ded) {
      e[i].draw();
    } else {
      e[i] = new Enemy();
      e[i].time = 0;
      e[i].time++;
    }
  }
  c.playerHealth();
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
