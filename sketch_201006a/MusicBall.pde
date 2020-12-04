class Ball {
  private float _speed;
  private float xPos;
  private float yPos = 0;
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
    if (millis() >= 5000) {
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
      perfectHit();
      combo += 2;
      misscombo = 0;
    } 

    if (xPos > ballRightMin && xPos < ballRightMax) {
      AddScore(minScore);
      System.out.println("te vroeg");
      normalHit();
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
  int timerReset = 0;

  if (intervalTimer < 30000 * comboChange[totalCombo]) {
      trueSpawnInterval = spawnInterval[0];
      comboCalc = spawnInterval[50];
    }

    if (intervalTimer > 30000 * comboChange[totalCombo]) {
      if (intervalTimer < 36000) {
        trueSpawnInterval = spawnInterval[1];
        comboCalc = spawnInterval[1];
      }
    }
  
  if(intervalTimer > 36000 * comboChange[totalCombo]){
    if(intervalTimer < 65000){
        trueSpawnInterval = spawnInterval[2];
        comboCalc = spawnInterval[2];
        
    }
    
    if(intervalTimer > 65000 * comboChange[totalCombo]){
      if(intervalTimer < 87500){
        trueSpawnInterval = spawnInterval[3];
        comboCalc = spawnInterval[3];
        
      }
    }
    if(intervalTimer > 87500 * comboChange[totalCombo]){
      if(intervalTimer < 110000){
        trueSpawnInterval = spawnInterval[4];
        comboCalc = spawnInterval[4];
      }
    }
    
    if(intervalTimer > 110000 * comboChange[totalCombo]){
      if(intervalTimer < 165000){
        trueSpawnInterval = spawnInterval[2];
        comboCalc = spawnInterval[2];
      }
    }
    
    if(intervalTimer > 165000 * comboChange[totalCombo]){
     if(intervalTimer < 226000){
       trueSpawnInterval = spawnInterval[0];
       comboCalc = spawnInterval[0];
    }
    if(intervalTimer > 226000 * comboChange[totalCombo]){
      timerReset = millis() - timerStart;
      intervalTimer -= timerReset;
      timerReset = 0;
    }
    }
    
    
    }
  }





void speed() {

  if(trueSpawnInterval < 0.6){
   if (combo > 9) {
    if (musicSpeed < 1.1) {
      if (totalCombo < 10) {
        totalCombo ++;
      }
      comboCalc *= comboChange[totalCombo];
      musicSpeed = musicSpeed + 0.02;
      file.rate(musicSpeed);
      trueSpawnInterval = comboCalc;
      combo = 0;
    }
  }
  }

  if (misscombo == 75) {
    if (totalCombo > 0) {
      totalCombo --;
    }
    comboCalc *= comboChange[totalCombo]; 
    musicSpeed = musicSpeed - 0.02;
    file.rate(musicSpeed);
    trueSpawnInterval = comboCalc;
    misscombo = 0;
  }
}
