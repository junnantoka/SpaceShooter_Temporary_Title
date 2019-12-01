int minimapXLoc = 75;
int minimapYLoc = 720;
int minimapSize = 7; //Standard is 7
int minimapXLocMax = 623;
int minimapYLocMax = 1028;

int minimapX = 350;
int minimapY = 875;
int minimapPlayerSize = 20;
int minimapBulletSize = 10;
int minimapEnemySize = 15;
int minimapHealthdropSize = 10;

final int minimapBackgroundColor = color(50);
final int minimapStrokeColor = color(255);
final int minimapPlayerColor = color(255, 200, 30);
final int minimapPlayerBulletColor = color(0, 0, 200);
final int minimapEnemyBulletColor = color(200, 0, 0);
final int minimapEnemyColor = color(160,10,230);
final int minimapHealthdropColor = color(255);


class Minimap {

  void setup() {
  }

  void draw() {
    //The minimap outline
    fill(minimapBackgroundColor);
    stroke(minimapStrokeColor);
    rect(minimapXLoc, minimapYLoc, world.worldWidth/minimapSize, world.worldHeight/minimapSize);

    //The player on the minimap
    fill(minimapPlayerColor);
    circle((character.xLocation - xRef)/minimapSize + minimapX, (character.yLocation - yRef)/minimapSize + minimapY, minimapPlayerSize);

    //Player bullet on the minimap
    fill(minimapPlayerBulletColor);
    for (int i = 0; i <bullets; i++) {
      if (bulletP[i].ja) {
        circle((bulletP[i].bPLocationXEnd - xRef)/minimapSize + minimapX, (bulletP[i].bPLocationYEnd - yRef)/minimapSize + minimapY, minimapBulletSize);
      }
      if ((bulletP[i].bPLocationXEnd - xRef)/minimapSize + minimapX <= minimapXLoc || (bulletP[i].bPLocationYEnd - yRef)/minimapSize + minimapY <= minimapYLoc) {
        bulletP[i].ja = false;
      }
      if ((bulletP[i].bPLocationXEnd - xRef)/minimapSize + minimapX >= minimapXLocMax || (bulletP[i].bPLocationYEnd - yRef)/minimapSize + minimapY >= minimapYLocMax) {
        bulletP[i].ja = false;
      }
    }

    //Enemy bullet on the minimap
    fill(minimapEnemyBulletColor);
    for (int i =0; i<eBullet.length; i++) {
      circle((eBullet[i].bulletX)/minimapSize + minimapX, (eBullet[i].bulletY)/minimapSize + minimapY, minimapBulletSize);

      if ((eBullet[i].bulletX)/minimapSize + minimapX >= 623 || (eBullet[i].bulletY)/minimapSize + minimapY >= 1028) {
        eBullet[i].shot = false;
        eBullet[i].shotIn = 0;
      }
      if ((eBullet[i].bulletX)/minimapSize + minimapX <= minimapXLoc || (eBullet[i].bulletY)/minimapSize + minimapY <= minimapYLoc) {
        eBullet[i].shot = false;
      }
    }
    
    //Enemy on the minimap
  fill(minimapEnemyColor);
  for (int i=0; i<enemy.length; i++) {
    circle((enemy[i].x)/minimapSize + minimapX, (enemy[i].y)/minimapSize + minimapY, minimapEnemySize);
    
    /*
    if((enemy[i].x)/minimapSize + minimapX <= minimapXLoc || (enemy[i].y)/minimapSize + minimapY <= minimapYLoc) {
     enemy[i].ded = true; 
    }
    if((enemy[i].x)/minimapSize + minimapX >= minimapXLocMax || (enemy[i].y)/minimapSize + minimapY >= minimapYLocMax) {
     enemy[i].ded = true; 
    }*/ 
    //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
    //Dit despawnt enemies als ze buiten de playable area gaan, maar gecombineerd met hoe spawning nu werkt wordt het buggy.
  }

    //Healthdrop on the minimap
    fill(minimapHealthdropColor);
    for (int i=0; i<healthDrop.length; i++) {
      if (healthDrop[i].spawnHealth == true) {
        rect((healthDrop[i].healthX)/minimapSize + minimapX, (healthDrop[i].healthY)/minimapSize + minimapY, minimapHealthdropSize, minimapHealthdropSize);
      }
    }
  }
}
