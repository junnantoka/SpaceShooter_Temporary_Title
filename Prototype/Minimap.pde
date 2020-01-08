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
int minimapHealthdropSize = 30;
int minimapBossSize = 25;

//These final ints give the minimap its colors

final int minimapBackgroundColor = color(50);
final int minimapStrokeColor = color(255);
final int minimapPlayerColor = color(255, 200, 30);
final int minimapPlayerBulletColor = color(0, 0, 200);
final int minimapEnemyBulletColor = color(200, 0, 0);
final int minimapEnemyColor = color(160, 10, 230);
final int minimapHealthdropColor = color(255);
final int minimapBossColor = color(255, 0, 0);


class Minimap {

  void setup() {
  }

  void draw() {
    //The minimap outline
    fill(minimapBackgroundColor);
    stroke(minimapStrokeColor);
    rect(minimapXLoc+wobbleX+bulletWobbleX, minimapYLoc+wobbleY+bulletWobbleY, world.worldWidth/minimapSize, world.worldHeight/minimapSize);

    //The player on the minimap
    fill(minimapPlayerColor);
    circle(((character.xLocation - xRef)/minimapSize + minimapX) + wobbleX+bulletWobbleX, ((character.yLocation - yRef)/minimapSize + minimapY)+wobbleY+bulletWobbleY, minimapPlayerSize);

    //Player bullet on the minimap
    /*fill(minimapPlayerBulletColor);
    for (int i = 0; i <bullets; i++) {
      if (bulletP[i].shoot) {
        circle((bulletP[i].bPLocationXEnd - xRef)/minimapSize + minimapX, (bulletP[i].bPLocationYEnd - yRef)/minimapSize + minimapY, minimapBulletSize);
      }
      if ((bulletP[i].bPLocationX - xRef)/minimapSize + minimapX <= minimapXLoc || (bulletP[i].bPLocationY - yRef)/minimapSize + minimapY <= minimapYLoc) {
        bulletP[i].reset();
      }
      if ((bulletP[i].bPLocationXEnd - xRef)/minimapSize + minimapX >= minimapXLocMax || (bulletP[i].bPLocationYEnd - yRef)/minimapSize + minimapY >= minimapYLocMax) {
        bulletP[i].reset();
      }
    }*/

    for (int i = 0; i < boss.length; i++) {
      fill(minimapBossColor);
      if (!boss[i].ded) {
        circle(((boss[i].x)/minimapSize + minimapX)+wobbleX+bulletWobbleX, ((boss[i].y)/minimapSize + minimapY)+wobbleY+bulletWobbleY, minimapBossSize);
      }
    }

    //Enemy bullet on the minimap
    /*fill(minimapEnemyBulletColor);
    for (int i =0; i<eBullet.size(); i++) {
      EnemyBullet e =eBullet.get(i);
      if (e.shot) {
      circle((e.bulletX)/minimapSize + minimapX, (e.bulletY)/minimapSize + minimapY, minimapBulletSize);
      }
    }

    /*for (int i = eBullet.size() -1; i>0; i--) {
      EnemyBullet e =eBullet.get(i);
      if ((e.bulletX)/minimapSize + minimapX >= minimapXLocMax || (e.bulletY)/minimapSize + minimapY >= minimapYLocMax) {
        eBullet.remove(i);
      } else if ((e.bulletX)/minimapSize + minimapX <= minimapXLoc || (e.bulletY)/minimapSize + minimapY <= minimapYLoc) {
        eBullet.remove(i);
      } 
    }*/

    //Enemy on the minimap
    fill(minimapEnemyColor);
    for (int i = enemy.size() -1; i >= 0; i--) {
      Enemy e = enemy.get(i);
      circle(((e.x)/minimapSize + minimapX)+wobbleX+bulletWobbleX, ((e.y)/minimapSize + minimapY)+wobbleY+bulletWobbleY, minimapEnemySize);


      if ((e.x)/minimapSize + minimapX <= minimapXLoc || (e.y)/minimapSize + minimapY <= minimapYLoc) {
        enemy.remove(i);
      }
      if ((e.x)/minimapSize + minimapX >= minimapXLocMax || (e.y)/minimapSize + minimapY >= minimapYLocMax) {
        enemy.remove(i);
      } 
      //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      //Dit despawnt enemies als ze buiten de playable area gaan, maar gecombineerd met hoe spawning nu werkt wordt het buggy.
    }

    //Healthdrop on the minimap
    fill(minimapHealthdropColor);
    for (HealthDrop i : healthDrop) {
      
        image(healthIcon,((i.healthX)/minimapSize + minimapX)+wobbleX+bulletWobbleX, ((i.healthY)/minimapSize + minimapY)+wobbleY+bulletWobbleY, minimapHealthdropSize, minimapHealthdropSize);
      
    }
  }
}
