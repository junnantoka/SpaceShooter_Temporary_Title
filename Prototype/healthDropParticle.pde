float healthParticleX, healthParticleY, Yspeed, healthParticleSize;
int amountOfParticles = 25;
class HealthDropParticle {

  HealthDropParticle() {
    healthParticleX = width/2+(random(-character.size, character.size));
    healthParticleY = height/2+(random(-character.size/2, character.size/2));
    healthParticleSize = 35;
    Yspeed = random(-2, -1);
  }

  void Display() {
    image(healthParticle, healthParticleX, healthParticleY, healthParticleSize, healthParticleSize);
  }

  void updateHealthParticle() {
    healthParticleY= healthParticleY+Yspeed;
  }
}
