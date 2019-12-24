//ArrayList<healthDropParticle> healthDropParticles = new ArrayList<healthDropParticle>();
class HealthDropParticle {
  float healthParticleX, healthParticleY, Yspeed, healthParticleSize;
  boolean particleIsOnScreen = false;
  void healthDropParticleCreate() {
    healthParticleX = character.xLocation+xRef+(random(-character.size, character.size));
    healthParticleY = character.yLocation+yRef+(random(-character.size, character.size));
    healthParticleSize = 35;
    Yspeed = random(-7, -3);
    
  }
  void healthDropParticleUpdate() {
    image(healthParticle, healthParticleX, healthParticleY, healthParticleSize, healthParticleSize);
    healthParticleY= healthParticleY+Yspeed;
  }
}
