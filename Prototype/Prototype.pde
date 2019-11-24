//prototype bullethell IDIL
//character movement w a s d
//bullet shooting up down left right
Character c = new Character();
float yRef = height/2;
float xRef = width/2;



Star[] s;
Start start = new Start();
End end= new End();
int stars = 300;

//Healthdrops
HealthDrop[] hD;
int healthBalls = 10;


// jeroens deel
Highscore h = new Highscore();

Pauze pz = new Pauze();

Enemy[] e;
int enemies = 10;
//jeroens deel
EnemyBullet[] eBullet;


Health a = new Health();

// key detection
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];
//stijns deel
int bullets = 1000;
int beweging=0;
PlayerBullet[] b = new PlayerBullet[bullets];
int pBTimer = 0; 
//eind stijns deel


void setup() {
  //size(1920, 1080, P2D);
  fullScreen(P2D);
  
  //Load all assets
  loadAssets();
  imageMode(CENTER);
  
  a.setup();
  pz.setup();

  c.construct();

  //construct  stars
  s = new Star[stars]; 
  for (int i = 0; i<s.length; i++) {
    s[i] = new Star();
    s[i].construct();
  }

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

  hD = new HealthDrop[healthBalls];
  for (int i=0; i<hD.length; i++) {
    hD[i] = new HealthDrop();
    hD[i].healthSetup();
  }
}

void updateGame() {
  background(0);
  a.gameOver();
  
  if (start.Start){
  start.update();
  }
  else if (end.end){
  end.update();
  }
  else if (!end.end && !start.Start){
  pz.pauzeGame();
  }
  //pauze
  
  if (!pz.pauze&& !start.Start && !end.end) {
    a.collide();
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

    for (int i=0; i<hD.length; i++) {
      hD[i].updateHealth(i);
    }
  }
}


void drawGame() {
   for (int i = 0; i<s.length; i++) {
    s[i].disp();
  }
  
  //draws stars


 
  
  for (int i = 0; i <e.length; i++) {
    eBullet[i].draw();
  }
     
if(!start.Start){
  for (int i = 0; i <bullets; i++) {
    b[i].draw();
  }
a.draw();
  c.displayCh();
  for (int i = 0; i<e.length; i++) {
    if (!e[i].ded) {
      e[i].draw();
    } else {
      e[i] = new Enemy();
    }
  }

  for (int i=0; i<hD.length; i++) {
    hD[i].displayHealth();
  }
  pz.draw();
  
}
if(start.Start){
  start.draw();
  }
  if (end.end){
    end.draw();
  }
   h.scoreDisplay();
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
