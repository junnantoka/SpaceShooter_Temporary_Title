int minimapXLoc = 1; //The X and Y values of the location of the minimap.
int minimapYLoc = 770;

int minimapXLocMax = 550; //The minimap width and height sizes. The minimap player/bullets can't go beyond these points.
int minimapYLocMax = 1080;

int minimapX = 276; //The player starting X and Y locations on the minimap. These coordinates start at the centre of the minimap.
int minimapY = 925;

int minimapSize = 7; //Standard is 7. The visual size of the minimap is the same size as the playable area, divided by seven.

int minimapPlayerSize = 20; //Sizes of stuff on the minimap.
int minimapBulletSize = 5;
int minimapEnemySize = 15;
int minimapHealthdropSize = 30;
int minimapBossSize = 25;

//These final ints give the minimap its colors.

final int minimapBackgroundColor = color(50);
final int minimapStrokeColor = color(255);
final int minimapPlayerColor = color(255, 200, 30);
final int minimapPlayerBulletColor = color(0, 0, 200);
final int minimapEnemyBulletColor = color(200, 0, 0);
final int minimapEnemyColor = color(160, 10, 230);
final int minimapHealthdropColor = color(255);
final int minimapBossColor = color(255, 0, 0);


class Minimap {

  void draw() {
    //The minimap outline.
    fill(minimapBackgroundColor);
    stroke(minimapStrokeColor);
    rect(minimapXLoc+wobbleX+bulletWobbleX, minimapYLoc+wobbleY+bulletWobbleY, world.worldWidth/minimapSize, world.worldHeight/minimapSize);

    //The player on the minimap.
    fill(minimapPlayerColor);
    circle(((character.xLocation - xRef)/minimapSize + minimapX) + wobbleX+bulletWobbleX, ((character.yLocation - yRef)/minimapSize + minimapY)+wobbleY+bulletWobbleY, minimapPlayerSize);

    //Player bullet on the minimap.
    for (int i = 0; i <bullets; i++) {      
      //The bullets themselves are not actually visible on the minimap for balancing reasons.

      //Bullets get deleted if they hit the edge of the minimap.
      if ((bulletP[i].bPLocationX - xRef)/minimapSize + minimapX <= minimapXLoc || (bulletP[i].bPLocationY - yRef)/minimapSize + minimapY <= minimapYLoc) {
        bulletP[i].reset();
      }
      if ((bulletP[i].bPLocationXEnd - xRef)/minimapSize + minimapX >= minimapXLocMax || (bulletP[i].bPLocationYEnd - yRef)/minimapSize + minimapY >= minimapYLocMax) {
        bulletP[i].reset();
      }
    }

    //Boss on the minimap.
    for (int i = 0; i < boss.size(); i++) {
      fill(minimapBossColor);
      Boss a = boss.get(i);
      circle(((a.x)/minimapSize + minimapX)+wobbleX+bulletWobbleX, ((a.y)/minimapSize + minimapY)+wobbleY+bulletWobbleY, minimapBossSize);
    }

    //Once again the enemy bullets are not visible on the minimap for balancing reasons.
    //Enemy bullet get deleted when they hit the edge of the minimap.
    for (int i = eBullet.size() -1; i>0; i--) {
      EnemyBullet e = eBullet.get(i);
      if ((e.bulletX)/minimapSize + minimapX >= minimapXLocMax || (e.bulletY)/minimapSize + minimapY >= minimapYLocMax) {
        eBullet.remove(i);
      } else if ((e.bulletX)/minimapSize + minimapX <= minimapXLoc || (e.bulletY)/minimapSize + minimapY <= minimapYLoc) {
        eBullet.remove(i);
      }
    }

    //Enemy on the minimap
    fill(minimapEnemyColor);
    for (int i = enemy.size() -1; i >= 0; i--) {
      Enemy e = enemy.get(i);
      circle(((e.x)/minimapSize + minimapX)+wobbleX+bulletWobbleX, ((e.y)/minimapSize + minimapY)+wobbleY+bulletWobbleY, minimapEnemySize);

      //These lines ensure that the enemy does not go beyond the playable area. If an enemy hits the edge of the minimap, it will turn the other way around.
      if ((e.x)/minimapSize + minimapX <= minimapXLoc || (e.y)/minimapSize + minimapY <= minimapYLoc) {
        e.x = minimapXLocMax - e.radius;
        e.y = minimapXLocMax - e.radius;
      } else if ((e.x)/minimapSize + minimapX >= minimapXLocMax || (e.y)/minimapSize + minimapY >= minimapYLocMax) {
        e.x = minimapXLocMax - e.radius;
        e.y = minimapXLocMax - e.radius;
      }
    }

    //The snail is visible on the minimap unlike some other powerups. This is because its spawn location is random and therefore harder to find for players.
    if (snailPowerUp.snailVisible) {
      image(snailIcon, ((snailPowerUp.snailPowerUpX)/minimapSize + minimapX)+wobbleX+bulletWobbleX, ((snailPowerUp.snailPowerUpY)/minimapSize + minimapY)+wobbleY+bulletWobbleY, minimapHealthdropSize, minimapHealthdropSize);
    } 
    //The healthdrop is visible on the minimap unlike some other powerups. This is because its spawn location is random and therefore harder to find for players.
    fill(minimapHealthdropColor);
    for (HealthDrop i : healthDrop) {
      image(healthIcon, ((i.healthX)/minimapSize + minimapX)+wobbleX+bulletWobbleX, ((i.healthY)/minimapSize + minimapY)+wobbleY+bulletWobbleY, minimapHealthdropSize, minimapHealthdropSize);
    }
  }
}
