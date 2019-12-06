int minimapXLoc = 75; //The X value of the location of the minimap
int minimapYLoc = 720; //The Y value of the location of the minimap
int minimapSize = 7; //Standard is 7. The size of the minimap is the same size as the playable area, divided by seven.
int minimapXLocMax = 623;
int minimapYLocMax = 1028; //1028

int minimapX = 350; //@@@@@@@@@@@@@@@Kijk even wat dit is
int minimapY = 875; //Height of the minimap
int minimapPlayerSize = 20;
int minimapBulletSize = 5;
int minimapEnemySize = 15;
int minimapHealthdropSize = 10;
int minimapBossSize = 25;

//These final ints give the minimap its colors

final int minimapBackgroundColor = color(50);
final int minimapStrokeColor = color(255);
final int minimapPlayerColor = color(255, 200, 30);
final int minimapPlayerBulletColor = color(0, 0, 200);
final int minimapEnemyBulletColor = color(200, 0, 0);
final int minimapEnemyColor = color(160, 10, 230);
final int minimapHealthdropColor = color(255);
final int minimapBossColor = color(0, 255, 0);


class Minimap {

  void setup() {
  }

  void draw() {
    //The minimap outline
    fill(minimapBackgroundColor);
    stroke(minimapStrokeColor);
    rect(minimapXLoc+wobbleX, minimapYLoc+wobbleY, world.worldWidth/minimapSize, world.worldHeight/minimapSize);

    //The player on the minimap
    fill(minimapPlayerColor);
    circle(((character.xLocation - xRef)/minimapSize + minimapX)+wobbleX, ((character.yLocation - yRef)/minimapSize + minimapY)+wobbleY, minimapPlayerSize);

    //Player bullet on the minimap
    fill(minimapPlayerBulletColor);
    for (int i = 0; i <bullets; i++) {
      //if (bulletP[i].ja) {
      //  circle((bulletP[i].bPLocationXEnd - xRef)/minimapSize + minimapX, (bulletP[i].bPLocationYEnd - yRef)/minimapSize + minimapY, minimapBulletSize);
      //}
      if ((bulletP[i].bPLocationXEnd - xRef)/minimapSize + minimapX <= minimapXLoc || (bulletP[i].bPLocationYEnd - yRef)/minimapSize + minimapY <= minimapYLoc) {
        bulletP[i].reset();
      }
      if ((bulletP[i].bPLocationXEnd - xRef)/minimapSize + minimapX >= minimapXLocMax || (bulletP[i].bPLocationYEnd - yRef)/minimapSize + minimapY >= minimapYLocMax) {
        bulletP[i].reset();
      }
    }

    for (int i = 0; i < boss.length; i++) {
      fill(minimapBossColor);
      if (!boss[i].ded) {
        circle(((boss[i].x)/minimapSize + minimapX)+wobbleX, ((boss[i].y)/minimapSize + minimapY)+wobbleY, minimapBossSize);
      }
    }

    //Enemy bullet on the minimap
    fill(minimapEnemyBulletColor);
    for (int i =0; i<eBullet.length; i++) {
      //if (eBullet[i].shot) {
      //  circle((eBullet[i].bulletX)/minimapSize + minimapX, (eBullet[i].bulletY)/minimapSize + minimapY, minimapBulletSize);
      //}
    }

    for (int i = 0; i<enemy.length; i++) {
      if ((eBullet[i].bulletX)/minimapSize + minimapX >= minimapXLocMax || (eBullet[i].bulletY)/minimapSize + minimapY >= minimapYLocMax) {
        eBullet[i].reset(i);
      }
      if ((eBullet[i].bulletX)/minimapSize + minimapX <= minimapXLoc || (eBullet[i].bulletY)/minimapSize + minimapY <= minimapYLoc) {
        eBullet[i].reset(i);
      }


      if ((eBullet[i+enemy.length].bulletX)/minimapSize + minimapX >= minimapXLocMax || (eBullet[i+enemy.length].bulletY)/minimapSize + minimapY >= minimapYLocMax) {

        eBullet[i+enemy.length].reset(i);
      }
      if ((eBullet[i+enemy.length].bulletX)/minimapSize + minimapX <= minimapXLoc || (eBullet[i+enemy.length].bulletY)/minimapSize + minimapY <= minimapYLoc) {

        eBullet[i+enemy.length].reset(i);
      }


      if ((eBullet[i+enemy.length*2].bulletX)/minimapSize + minimapX >= minimapXLocMax || (eBullet[i+enemy.length*2].bulletY)/minimapSize + minimapY >= minimapYLocMax) {

        eBullet[i+enemy.length*2].reset(i);
      }
      if ((eBullet[i+enemy.length*2].bulletX)/minimapSize + minimapX <= minimapXLoc || (eBullet[i+enemy.length*2].bulletY)/minimapSize + minimapY <= minimapYLoc) {

        eBullet[i+enemy.length*2].reset(i);
      }
    }

    //Enemy on the minimap
    fill(minimapEnemyColor);
    for (int i=0; i<currentEnemyAmount; i++) {
      circle(((enemy[i].x)/minimapSize + minimapX)+wobbleX, ((enemy[i].y)/minimapSize + minimapY)+wobbleY, minimapEnemySize);


      if ((enemy[i].x)/minimapSize + minimapX <= minimapXLoc || (enemy[i].y)/minimapSize + minimapY <= minimapYLoc) {
        enemy[i].ded = true;
      }
      if ((enemy[i].x)/minimapSize + minimapX >= minimapXLocMax || (enemy[i].y)/minimapSize + minimapY >= minimapYLocMax) {
        enemy[i].ded = true;
      } 
      //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      //Dit despawnt enemies als ze buiten de playable area gaan, maar gecombineerd met hoe spawning nu werkt wordt het buggy.
    }

    //Healthdrop on the minimap
    fill(minimapHealthdropColor);
    for (int i=0; i<healthDrop.length; i++) {
      if (healthDrop[i].spawnHealth == true) {
        rect(((healthDrop[i].healthX)/minimapSize + minimapX)+wobbleY, ((healthDrop[i].healthY)/minimapSize + minimapY)+wobbleY, minimapHealthdropSize, minimapHealthdropSize);
      }
    }
  }
}
