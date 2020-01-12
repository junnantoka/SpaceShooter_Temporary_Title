class End {

  boolean end, button = false;
  int timerEnd= 0;
  int opacityGameOver, opacityTitleCard, opacityStarting, opacitycontrols=0;
  int endTimer = 0;
  int testdataID;
  String users;
  void setup() {
  }

  void draw() {
    timerEnd++;
    if (timerEnd == 1 && soundSetting == 2){
      //titlescreen.stop();
      doodSound.play();
    }
    if ( timerEnd <=50) {
      fill(255, 0, 0, opacityGameOver);
      textSize(100);
      opacityGameOver+= 10;

      text("GAME OVER", width/3+10, height/2+50);
    }
    if (timerEnd >=50) {
      fill(255);
      opacityTitleCard+= 3;
      textSize(150);
      tint(255, opacityTitleCard);
      image(titleCard, width / 2, height/4);
    }
    if (timerEnd >=65) {
      opacityStarting+= 3;
      tint(255, opacityStarting);
      image(startImg, width / 2, height/ 2 +200, 500, 300);
    }
    if (timerEnd >=80) {
      opacitycontrols+= 3;
      tint(255, opacitycontrols);
      image(movement, width/4-75, height/2, 500, 500);
      image(shooting, width/4*3+75, height/2, 500, 500);
    }
    tint(255, 255);
  }

  void update() {
    //detect of het spel verder mag van de speler
    if (keysPressed['p']||keysPressed['P']) {
      end = false;
      goSettings = false;
      goAchievement = false;
      reset();
      timer++;
      titlescreen.loop();
      if (random(0, 1) >= 0.5) {
        clickA.play();
      } else {
        clickB.play();
      }
    }

    if (end) {//Checks if game ended
      titlescreen.stop();
      if ( endTimer == 1) {
        getTestdata();
        setTestdata();
        updateTestdata();
        highscore.highscoreSave();
      }
      endTimer++;
    } else endTimer = 0;
  }

  void reset() {
    timerEnd = 0;
    opacityGameOver = 0; 
    opacityTitleCard = 0;   
    opacityStarting = 0; 
    opacitycontrols = 0; 
    for (int i = enemy.size()-1; i >= 0; i--) {
      enemy.remove(i);
    }
    for (int i = healthDrop.size()-1; i >= 0; i--) { 
      healthDrop.remove(i);
    }

    for (int i = eBullet.size()-1; i >= 0; i--) {
      eBullet.remove(i);
    }
    for (int i = boss.size()-1; i >= 0; i--) {
      boss.remove(i);
    }

    health.reset();
    highscore.score = 0;
    //highscore.reset();
    yRef = 0;
    xRef = 0;

    for (int i = 0; i < bulletP.length; i++) {
      bulletP[i].reset();
    }
    wave.construct();
    character.reset();
    bossTotal = 1;
    enemyCounter = 0;
    enemiesRequired = enemiesRequiredStart;
    bossSpawn = false;
    wobbleX = 0;
    wobbleY = 0;
    wobbleTimer = 0;
    for (int i =boss.size(); i > 0; i--) {
      

    }
    wave.reset();

    for (int i = 0; i < star.length; i++) {
      star[i].construct();
    }
  }

  void updateTestdata() {
    //Update total enemies killed in the database IF user exists
    String updateQry = "UPDATE Testdata SET enemies_killed = " + achievement.enemyCounter + " WHERE User_Chair_nr = '" + chairNr + "'";
    if (msql.connect()) {
      msql.query("SELECT User_Chair_nr FROM Testdata;");
      while (msql.next()) {
        users = msql.getString("User_Chair_nr");
      }endTimer++;
      if (chairNr == users && endTimer == 1) {
        msql.query(updateQry);
      }
    }
  }

  void getTestdata() {
    //Get the data out of the table Testdata
    String userQry = "SELECT COUNT(u.Chair_nr) AS Users, a.AchievementID, a.AchievementName FROM User u INNER JOIN User_has_Achievement UA ON u.Chair_nr = UA.Chair_nr INNER JOIN Achievement a ON UA.AchievementID = a.AchievementID WHERE Obtained = 'Yes' GROUP BY a.achievementID";

    if (msql.connect()) {
      msql.query(userQry);
      while (msql.next()) {
        int users = msql.getInt("Users");
        int achievementID = msql.getInt("a.AchievementID");
        String achievement = msql.getString("a.AchievementName");
       
        print(users + " "  + achievementID + " " + achievement + " ");
      } 
    }
  }
  void chairCheck(){
      msql.query("INSERT INTO Testdata (User_Chair_nr) VALUES('" + chairNr + "')"); //add new record in Testdata
  }

  void setTestdata() {
    //Insert data IF the player hasn't played the game yet
    String insertQry = "INSERT INTO Testdata (`inputs_per_frame`, `enemies_killed`, `time_played`, `User_Chair_nr`) VALUES('" + input_per_frame + "','" + achievement.enemyCounter + "','" + timerEnd + "','" + chairNr + "');";
    if (msql.connect()) {
      msql.query("SELECT User_Chair_nr FROM Testdata;");
      while (msql.next()) {
        users = msql.getString("User_Chair_nr");
      }
      if (chairNr == users) {
        msql.query(insertQry);
      }
    }
  }

  void stop() {
    //Drop data on close of application
    if (msql.connect()) {
      String userChair = "SELECT id, User.Chair_nr FROM User INNER JOIN Testdata ON User.Chair_nr = Testdata.User_Chair_nr WHERE Testdata.User_Chair_nr = '" + chairNr + "';";
      msql.query(userChair);
      msql.next();

      testdataID = msql.getInt("id");
      String dropQuery = "DELETE FROM Testdata WHERE id = '" + testdataID + "' AND User_Chair_nr = '" + chairNr + "';";
      while (msql.next()) {
        users = msql.getString("User_Chair_nr");
      }
      if (users.equals(chairNr)) {
        msql.query(dropQuery);
      }
    }
  }
}
