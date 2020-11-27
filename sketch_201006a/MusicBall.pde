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
    ellipse(xPos -= _speed, yPos, 50, 50);
  }

  void draw() {
    spawnRate();
    Move();
    CheckPos();
    speed();
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
      misscombo ++;
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
    }

    if (intervalTimer > 10000) {
      if (intervalTimer < 14000) {
        trueSpawnInterval = spawnInterval[1];
      }
    }
  }
}



void speed() {

  if (combo > 9) {
    if (musicSpeed < 1.1) {
      musicSpeed = musicSpeed + 0.02;
      file.rate(musicSpeed);
      combo = 0;
      trueSpawnInterval *= 0.8;
    }
  }

  if (misscombo == 10) {
    if (musicSpeed > 0.9) {
      musicSpeed = musicSpeed - 0.02;
      file.rate(musicSpeed);
      misscombo = 0;
      trueSpawnInterval *= 1.2;
    }
  }
}
