int soundSetting, artSetting, enemiesKilled, deleteTimer;

class Sql {

  void SettingGet() {
    if ( msql.connect() ) {
      msql.query( "SELECT User.Chair_nr, Setting.sound, Setting.art FROM User INNER JOIN Setting ON User.Chair_nr = Setting.Chair_nr WHERE User.Chair_nr = '" + chairNr + "'");

      while ( msql.next() ) {        
        soundSetting = msql.getInt("Setting.sound");
        artSetting = msql.getInt("Setting.art");
      }
      println(soundSetting + "  " + artSetting);
    } else {
      soundSetting = 1;
      artSetting = 1;
    }
  }
  


  void updateData() {
    if ( msql.connect() ) {
      msql.query("UPDATE Setting SET sound =" + soundSetting + " WHERE chair_nr = '" + chairNr + "'");
      msql.query("UPDATE Setting SET art =" + artSetting + " WHERE chair_nr = '" + chairNr + "'");
    }
  }
  
  void deleteData(){
   if (msql.connect()) {
        if (deleteTimer == 0) {
          msql.query("DELETE FROM Setting WHERE Chair_nr='" + chairNr + "'");
          deleteTimer++;
        }
      }  
  }
  
  void createUserData(){
    if(!chairExists){
       msql.query("INSERT INTO `zdorpl2`.`Setting` (`Chair_nr`, `sound`, `art`) VALUES ('" + chairNr + "', '1', '1')");
    }
  }
}
