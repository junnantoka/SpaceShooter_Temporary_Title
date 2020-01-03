int soundSetting, artSetting, enemiesKilled;
String chairNr = "3b";
class Sql {

  //void construct() {
  //  chairNr = "";
  //  chairNr = chairNr + int(random(1, 12));
  //  chairNr = chairNr + alphabet[int(random(12))];
  //}
  void SettingGet() {
    if ( msql.connect() ) {
      msql.query( "SELECT User.Chair_nr, Setting.sound, Setting.art FROM User INNER JOIN Setting ON User.Chair_nr = Setting.Chair_nr WHERE User.Chair_nr = '" + chairNr + "'");


      println( "Table \t Chair_nr \t sound \t\t art \t\t " );
      println( "===========================================" );


      while ( msql.next() ) {        
        // println( "  \t " + msql.getString("Chair_nr") + " \t\t " + msql.getString("Username") + " \t\t " );
        println("  \t " + msql.getString("User.Chair_nr") + " \t\t " + msql.getInt("Setting.sound") + " \t\t " + " " + msql.getInt("Setting.art") + " \t\t ");
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

      //Update total enemies killed in the database
      //msql.query("UPDATE Testdata SET enemies_killed = " + enemiesKilled + " WHERE chair_nr = '" + chairNr + "'");
    }
  }
}
