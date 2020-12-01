class Ball {
  private float _speed;
  private float xPos;
  private float yPos;
  private boolean clicked;

  Ball(float speed, float y) {
    _speed = speed;
    yPos = y;
  }

  void setup() {
    xPos = 900;
    //yPos = 300;
  }

  private void Move() {
    if (clicked) return;
  imageMode(CENTER);
  image(Notes, xPos -= _speed, yPos, 45, 45);
}

  void draw() {
    spawnRate();
    Move();
    CheckPos();
    if(millis() >= 5000){
     speed();
   }
  }

  void Hit() {
    System.out.println(yPos);
    clicked = true;
    if (xPos > ballRightMax) {
      System.out.println("veel te vroeg");
      AddScore(missScore);
      return;
    }

    ScoreCalculate();
  }

  void CheckPos() {
    if (xPos < 50) {
      if (!clicked) AddScore(missScore);
      clicked = true;
    }
  }

  void AddScore(float amount) {
    score += amount;
    scoreChange = (int)amount;
    fadeValue = 255;
  }

  void ScoreCalculate() {


    if (xPos >= ballLeftMin && xPos <= ballRightMin) {
      AddScore(perfectScore);
      System.out.println("goed");
      combo += 2;
      misscombo = 0;
    } 

    if (xPos > ballRightMin && xPos < ballRightMax) {
      AddScore(minScore);
      System.out.println("te vroeg");
        combo++;
        misscombo = 0;
    }

    if (xPos < ballLeftMin && xPos > ballLeftMax) {
      AddScore(minScore);
      System.out.println("te laat");
      combo = 0;
    }
  }
}


void spawnRate() {
  int timerStart = 0;
  if (menuActive == true) {
    timerStart =+ millis();
  }

  int intervalTimer = millis() - timerStart;

  if (intervalTimer > 5000) {
    if (intervalTimer < 9000) {
      trueSpawnInterval = spawnInterval[4];
      comboCalc = spawnInterval[4];
    }

    if (intervalTimer > 10000) {
      if (intervalTimer < 14000) {
        trueSpawnInterval = spawnInterval[1];
        comboCalc = spawnInterval[1];
      }
    }
  }
}




void speed() {



  
  if (combo > 9) {
    if (musicSpeed < 1.1) {
      totalCombo ++;
      if(totalCombo == 0){
        comboCalc *= comboChange[0];
      }
      if(totalCombo == 1){
        comboCalc *= comboChange[1];
      }
      if(totalCombo == 2){
        comboCalc *= comboChange[2];
      }
      if(totalCombo == 3){
        comboCalc *= comboChange[3];
      }
      if(totalCombo == 4){
        comboCalc *= comboChange[4];
      }
      if(totalCombo == 5){
        comboCalc *= comboChange[5];
      }
      if(totalCombo == 6){
        comboCalc *= comboChange[6];
      }
      if(totalCombo == 7){
        comboCalc *= comboChange[7];
      }
      if(totalCombo == 8){
        comboCalc *= comboChange[8];
      }
      if(totalCombo == 9){
        comboCalc *= comboChange[9];
      }
      if(totalCombo == 10){
        comboCalc *= comboChange[10];
      }
      musicSpeed = musicSpeed + 0.02;
      file.rate(musicSpeed);
      trueSpawnInterval = comboCalc;
      combo = 0; 
    }
  }

  if (misscombo == 75) {
    if (musicSpeed > 0.9) {
      totalCombo -= 1; 
      if(totalCombo == 0){
         comboCalc *= comboChange[0];
      }
      if(totalCombo == 1){
        comboCalc *= comboChange[1];
      }
      if(totalCombo == 2){
        comboCalc *= comboChange[2];
      }
      if(totalCombo == 3){
        comboCalc *= comboChange[3];
      }
      if(totalCombo == 4){
        comboCalc *= comboChange[4];
      }
      if(totalCombo == 5){
        comboCalc *= comboChange[5];
      }
      if(totalCombo == 6){
        comboCalc *= comboChange[6];
      }
      if(totalCombo == 7){
        comboCalc *= comboChange[7];
      }
      if(totalCombo == 8){
        comboCalc *= comboChange[8];
      }
      if(totalCombo == 9){
        comboCalc *= comboChange[9];
      }
      if(totalCombo == 10){
        comboCalc = comboChange[10];
      }
       
      musicSpeed = musicSpeed - 0.02;
      file.rate(musicSpeed);
      trueSpawnInterval = comboCalc;
      misscombo = 0;
    }
  }
}
