class Wobble {
  float wobbleIntensity;
  
  void wobble(int wobbleDuration, float wobbleIntensity2) {
    //sets the intensity and duration of the screen shake
    wobbleTimer = wobbleDuration;
    wobbleIntensity = wobbleIntensity2;
  }
  
  void wobbleMovement() {
    //makes the screen shake  according to the timer and the intensity
    if (wobbleTimer >19) {
      wobbleTimer =19;
    }
    if (wobbleTimer ==1) { 
      wobbleX = 0; 
      wobbleY = 0;
    }
    if (wobbleTimer ==2) { 
      wobbleX = wobbleIntensity; 
      wobbleY = wobbleIntensity;
    }
    if (wobbleTimer ==3) { 
      wobbleX = -wobbleIntensity; 
      wobbleY = wobbleIntensity;
    }
    if (wobbleTimer ==4) { 
      wobbleX = -wobbleIntensity; 
      wobbleY = -wobbleIntensity;
    }
    if (wobbleTimer ==5) { 
      wobbleX = wobbleIntensity; 
      wobbleY = -wobbleIntensity;
    }
    if (wobbleTimer ==6) { 
      wobbleX = wobbleIntensity; 
      wobbleY = wobbleIntensity;
    }
    if (wobbleTimer ==7) { 
      wobbleX = -wobbleIntensity; 
      wobbleY = wobbleIntensity;
    }
    if (wobbleTimer ==8) { 
      wobbleX = -wobbleIntensity; 
      wobbleY = -wobbleIntensity;
    }
    if (wobbleTimer ==9) { 
      wobbleX = wobbleIntensity; 
      wobbleY = -wobbleIntensity;
    }
    if (wobbleTimer ==10) { 
      wobbleX = wobbleIntensity; 
      wobbleY = wobbleIntensity;
    }
    if (wobbleTimer ==11) { 
      wobbleX = -wobbleIntensity; 
      wobbleY = wobbleIntensity;
    }
    if (wobbleTimer ==12) { 
      wobbleX = -wobbleIntensity; 
      wobbleY = -wobbleIntensity;
    }
    if (wobbleTimer ==13) { 
      wobbleX = wobbleIntensity; 
      wobbleY = -wobbleIntensity;
    }
    if (wobbleTimer ==14) { 
      wobbleX = wobbleIntensity; 
      wobbleY = wobbleIntensity;
    }
    if (wobbleTimer ==15) { 
      wobbleX = -wobbleIntensity; 
      wobbleY = wobbleIntensity;
    }
    if (wobbleTimer ==16) { 
      wobbleX = -wobbleIntensity; 
      wobbleY = -wobbleIntensity;
    }
    if (wobbleTimer ==17) { 
      wobbleX = wobbleIntensity; 
      wobbleY = -wobbleIntensity;
    }
    if (wobbleTimer ==18) { 
      wobbleX = wobbleIntensity; 
      wobbleY = wobbleIntensity;
    }
    if (wobbleTimer ==19) { 
      wobbleX = wobbleIntensity; 
      wobbleY = -wobbleIntensity;
    }
    if (wobbleTimer >0) {
      wobbleTimer--;
    }
  }
}
