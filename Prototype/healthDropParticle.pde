float healthParticleX, healthParticleY, Yspeed, healthParticleSize;
class HealthDropParticle {
  
  HealthDropParticle() {
    healthParticleX = character.xLocation+xRef+(random(-character.size, character.size));
    healthParticleY = character.yLocation+yRef+(random(-character.size, character.size));
    healthParticleSize = 35;
    Yspeed = random(-7, -3);
  }
  
  void draw(){
    image(healthParticle, healthParticleX, healthParticleY, healthParticleSize, healthParticleSize);
  }
  
  void updateHealthaParticle(){
    healthParticleY= healthParticleY+Yspeed;
  }
}
