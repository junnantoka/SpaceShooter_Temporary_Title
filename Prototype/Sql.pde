int soundSetting, artSetting, enemiesKilled, deleteTimer;

class Sql {

  void SettingGet() {
    //asks for the last used settings for the chair_nr and if it can't find the chair_nr takes the default settings
    if ( msql.connect() ) {
      msql.query( "SELECT User.Chair_nr, Setting.sound, Setting.art FROM User INNER JOIN Setting ON User.Chair_nr = Setting.Chair_nr WHERE User.Chair_nr = '" + chairNr + "'");
int amount = 0;
      while ( msql.next() ) {        
        soundSetting = msql.getInt("Setting.sound");
        artSetting = msql.getInt("Setting.art");
        amount++;
      } 
      if (amount == 0){
        createUserData();
        println("kaas 2");
      }
    } else {
      soundSetting = 1;
      artSetting = 1;
      println("kaas");
    }
  }
  


  void updateData() {
    //makes the settings connected to the chair_nr in the database equal to the settings of the program
    if ( msql.connect() ) {
      msql.query("UPDATE Setting SET sound =" + soundSetting + " WHERE chair_nr = '" + chairNr + "'");
      msql.query("UPDATE Setting SET art =" + artSetting + " WHERE chair_nr = '" + chairNr + "'");
    }
  }
  
  void deleteData(){
   if (msql.connect()) {
     //if user is deleted deletes the settings of user settings
        if (deleteTimer == 0) {
          msql.query("DELETE FROM Setting WHERE Chair_nr='" + chairNr + "'");
          deleteTimer++;
        }
      }  
  }
  
  void createUserData(){
    
      //creates settings if they don't exist yet in the database
       msql.query("INSERT INTO `zdorpl2`.`Setting` (`Chair_nr`, `sound`, `art`) VALUES ('" + chairNr + "', '1', '1')");
    msql.query( "SELECT User.Chair_nr, Setting.sound, Setting.art FROM User INNER JOIN Setting ON User.Chair_nr = Setting.Chair_nr WHERE User.Chair_nr = '" + chairNr + "'");
      while ( msql.next() ) {        
        soundSetting = msql.getInt("Setting.sound");
        artSetting = msql.getInt("Setting.art");
        
      } 
  }
}
