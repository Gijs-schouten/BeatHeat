class Ball {
  private float _speed;
  private float xPos;
  private float yPos;
  public boolean clicked;
  public boolean isEnemy = false;
  public float enemyChance;
  public PImage NoteSprite;

  Ball(float speed, float y) {
    _speed = speed;
    yPos = y;
  }

  void setup() {
    xPos = 900;
    enemyChanceSetup();
  }

  private void Move() {
    if (clicked) return;
    imageMode(CENTER);
    image(NoteSprite, xPos -= _speed, yPos, 45, 45);
  }

  void draw() {
    spawnRate();
    Move();
    CheckPos();
    if (millis() >= 5000) {
      comboSpeed();
    }
    if (!particleActive) {
      particleTimerCheck = millis();
    }
    if (particleActive) particleTimer = millis() - particleTimerCheck;
    if (particleTimer >= 900) {
      particleActive = false;
    }
    if (particleActive) {
      particlePlay();
    }
  }

  void Hit() {
    if (clicked) return;

    clicked = true;
    /*if (xPos > ballRightMax) {
     System.out.println("veel te vroeg");
     AddScore(missScore);
     return;
     }*/

    ScoreCalculate();
  }

  void CheckPos() {
    if (xPos < 50) {
      if (!clicked && !isEnemy) { 
        AddScore(missScore);
        AddHealth(-1);
        clicked = true;
      }
    }
  }

  void AddScore(float amount) {
    score += amount;
    scoreChange = (int)amount;
    fadeValue = 255;
  }

  void ScoreCalculate() {
    if (isEnemy) {
      AddScore(missScore);
      AddHealth(-4);
      return;
    }
    if (xPos >= ballLeftMin && xPos <= ballRightMin || comboPowerUp) {
      AddScore(perfectScore);
      System.out.println("goed");
      perfectHit();
      combo += 2;
      misscombo = 0;
      AddHealth(1);
      particleActive = true;
      if (scorePowerUp) {
        AddScore(perfectScore);
      }
    } 
    if (xPos >= ballRightMin && xPos <= ballRightMax) {
      if (!comboPowerUp) {
        AddScore(minScore);
        System.out.println("te vroeg");
        normalHit();
        combo++;
        misscombo = 0;
      }
      if (scorePowerUp) {
        AddScore(minScore);
      }
    }

    if (xPos <= ballLeftMin && xPos >= ballLeftMax) {
      if (!comboPowerUp) {
        AddScore(minScore);
        System.out.println("te laat");
        combo = 0;
      }
    }
  }
  void enemyChanceSetup() {
    enemyChance = random(10);
    if (enemyChance > 7) {
      isEnemy = true;
      NoteSprite = EvilNotes;
    } else { 
      NoteSprite = Notes;
    }
  }
}
