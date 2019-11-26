class PowerUp {
  
  float healthExtra = 2;
  
  
  void use(){
    if(keysPressed['h'] ||keysPressed['H'] ){
      healthMax += healthExtra;
      println(healthMax);
    }
  }
  
  
}
