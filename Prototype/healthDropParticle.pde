class HealthDropParticle {
  float healthParticleX, healthParticleY, xSpeed, ySpeed, slowdown, speedVariation, speedLimit,fade;
  float density, fadeSpeed;
  
  HealthDropParticle(float spawnX, float spawnY, float speed, float diss) {
    healthParticleX = spawnX;
    healthParticleY = spawnY;
    speedVariation = speed;
    ySpeed = random(-speedVariation, -4);
    fadeSpeed = random(diss-3,diss+3);
    density = 255;
    slowdown = 0.1;
    speedLimit = 1;
    fade = 255;
  }

  void reset(int inst) {
    if(density<1 || ((xSpeed < speedLimit && xSpeed >-speedLimit) && (ySpeed < speedLimit && ySpeed >-speedLimit) )){
      healthDropParticles.remove(inst);
    }
  }

  void move() {
    healthParticleX+=xSpeed;
    healthParticleY+=ySpeed;
    fade = fade - fadeSpeed;
  }

  void display() {
    tint(density, fade);
    image(healthParticle,healthParticleX + xRef + wobbleX+bulletWobbleX, healthParticleY + yRef + wobbleY+bulletWobbleY);
    tint(255);
  }
}
