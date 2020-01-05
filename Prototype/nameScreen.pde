boolean nameEntered;
int letterA, letterB, letterC, letterSelected, moveTimer, entering;
String name;
boolean selecting = true;
boolean nameSelected;
char[] alphabet = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'I', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};

String peoep = "7b";
boolean chairExists;

class NameScreen {
  
  int enterWait;

  void display() {
    rectMode(3);
    fill(255);
    textSize(40);
    text("Welcome " + chairNr, width/10, height/4);
    textSize(width/6);
    rect(width / 6, height/2, width/6 * 1.5, width/5);
    rect(width / 6 * 3, height/2, width/6 * 1.5, width/5);
    rect(width / 6 * 5, height/2, width/6 * 1.5, width/5);
    fill(100);
    text(alphabet[letterA], width / 6 - width/15 + 5, 655);
    text(alphabet[letterB], width / 6 * 3 - width/15 + 5, 655);
    text(alphabet[letterC], width / 6 * 5 - width/15 + 5, 655);
    fill(0);
    text(alphabet[letterA], width / 6 - width/15, 650);
    text(alphabet[letterB], width / 6 * 3 - width/15, 650);
    text(alphabet[letterC], width / 6 * 5 - width/15, 650);
    fill(255);
    switch(letterSelected) {
    case 0:
      arrow(width/6, height/4 * 3, 60);
      break;
    case 1:
      arrow(width/6 * 3, height/4 * 3, 60);
      break;
    case 2:
      arrow(width/6 * 5, height/4 * 3, 60);
      break;
    }
  }


  void update() {
    if (selecting) {
      if (keysPressed['a'] || keysPressed['A'] || keysPressed['d'] || keysPressed['D'] || keysPressed['w'] || keysPressed['W'] || keysPressed['s'] || keysPressed['S']) {
        moveTimer++;
      }
      if (!(keysPressed['a'] || keysPressed['A']) && !(keysPressed['d'] || keysPressed['D'] || keysPressed['w'] || keysPressed['W'] || keysPressed['s'] || keysPressed['S'])) {
        moveTimer = 0;
      }
      if (moveTimer == 1) {
        if (keysPressed['d'] || keysPressed['D']) {
          letterSelected++;
        }
        if (keysPressed['a'] || keysPressed['A']) {
          letterSelected--;
        }
        if (keysPressed['w'] || keysPressed['W']) {
          switch(letterSelected) {
          case 0:
            letterA++;
            break;
          case 1:
            letterB++;
            break;
          case 2:
            letterC++;
            break;
          }
        }
        if (keysPressed['s'] || keysPressed['S']) {
          switch(letterSelected) {
          case 0:
            letterA--;
            break;
          case 1:
            letterB--;
            break;
          case 2:
            letterC--;
            break;
          }
        }

        if (letterSelected>2) {
          letterSelected = 2;
        }
        if (letterSelected<0) {
          letterSelected = 0;
        }
        if (letterA > 25) {
          letterA = 0;
        }
        if (letterB > 25) {
          letterB = 0;
        }
        if (letterC > 25) {
          letterC = 0;
        }
        if (letterA < 0) {
          letterA = 25;
        }
        if (letterB < 0) {
          letterB = 25;
        }
        if (letterC < 0) {
          letterC = 25;
        }
      }
      name = "";
      name = name + alphabet[letterA];
      name = name + alphabet[letterB];
      name = name + alphabet[letterC];
    }


    if (keysPressed[RIGHT]) {
      entering++;
    } else entering = 0;

      if (entering == 1) {
      if (msql.connect()) {
        doesChairExist();
        print(name + "  ");
        uploadName();
        achievement.insertData();
        nameEntered = true;
        msql.close();
        enterWait = 0;
      }
    }
  }

  void check() {
    int deleting = 0;
    enterWait ++;
    if (keysPressed['m'] || keysPressed['M']) {
      deleting++;
      if (deleting == 1) {
        deleteUser();
        achievement.deleteUserAchiements();
      }
    }
    if (pauze.pauze && keysPressed[RIGHT] && nameEntered && enterWait > 60) {
      nameEntered = false;
    }
  }

  void doesChairExist() {
    if (msql.connect()) {
      msql.query("SELECT * FROM User;");
      while (msql.next()) {
        String peop = msql.getString("Chair_nr");
        if (peop.equals(chairNr)) {
          chairExists = true;
        }
      }
    }
    println("is hij er? " + chairExists);
  }

  void uploadName() {
    if (!chairExists) {
      if (msql.connect()) {
        msql.query("INSERT INTO User (`Chair_nr`, `Username`) VALUES ( '" +  chairNr + "', '" +  name + "')");
        println("INSERT INTO User (`Chair_nr`, `Username`) VALUES ( '" +  chairNr + "', '" +  name + "')");
      }
    }
    if (chairExists) {
      if (msql.connect()) {
        msql.query("UPDATE User SET Username = '"+ name +"' WHERE Chair_nr = '" + chairNr + "'");
        println("UPDATE User SET Username = '"+ name +"' WHERE Chair_nr = '" + chairNr + "'");
      }
    }
  }

  void deleteUser() {
    if (msql.connect()) {
      msql.query("DELETE FROM User WHERE Chair_nr = '" + chairNr + "'");
      println("DELETE FROM User WHERE Chair_nr = '" + chairNr + "'");
    }
  }



  void arrow(float middleX, float middleY, float size) {
    triangle(middleX, middleY - size/2, middleX + size/2, middleY + size/2, middleX - size/2, middleY + size/2);
  }
}
