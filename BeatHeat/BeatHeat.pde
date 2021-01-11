import processing.sound.*;

ParticleSystem ps;
PFont font;
PImage Player, 
  Background, 
  XboardLine, 
  YboardLine, 
  Notes, 
  MainMenuBG, 
  HighScoreBG, 
  FireEffect, 
  Healthbar, 
  BarOHealth, 
  gameOverScreen,
  EvilNotes;


void setup() {
  ps = new ParticleSystem(new PVector(145, 60));
  screenState = 0;
  size(900, 600);
  frameRate = 144;
  LoadImages();
  myBalls = new Ball[ballAmount];
  font = createFont("Streamster.ttf", 32);
  SpawnBall();
  perfectHit = new SoundFile(this, "perfect_hit.wav");  
  normalHit = new SoundFile(this, "normal_hit.wav");
  file = new SoundFile(this, "UltimateDestruction.wav");
  file.amp(0.9);
  
}

void draw() {
  music();
  switch(screenState) {
  case 0:
    DrawMenu();
    break;

  case 1:
    DrawGame();
    break;

  case 3:
    DrawHighScore();
    file.stop();
    break;

  case 4:
    gameOver();
    break;



  default:
    println("screen state error");
    break;
  }
  if (playerHealth == 0) {
    screenState = 4;
  }
}

public void SpawnBall() {
  spawnPos = int(random(0, 4));
  if (rowPowerUp) {
    spawnPos = 2;
  }
  myBalls[ballIndex] = new Ball(ballSpeed, positions[spawnPos]);
  myBalls[ballIndex].setup();
  ballIndex++;
  ballIndex = ballIndex%ballAmount;
}

void keyPressed() {
  if (screenState == 1) { 
    if (key == ' ' || key == 'z' || key == 'Z') {
      HitBall();
    }

    if (keyCode == UP || keyCode == 'W') {
      if (indexPos == 0) {
        indexPos = 5;
      }
      indexPos--;
    }

    if (keyCode == DOWN || keyCode == 'S') {
      indexPos++;
      indexPos = indexPos%5;
    }
  }

  if (key == 'x' || key == 'X' && screenState == 0) {
    menuActive = false;
    screenState = 1;
  }
}




public color CalcColor(int pos) {
  switch (pos) {
  case 0:
    return color(255, 0, 0);

  case 1:
    return color(0, 255, 0);

  case 2:
    return color(0, 0, 255);

  case 3:
    return color(255, 255, 0);

  case 4:
    return color(0, 255, 255);

  case 5:
    return color(255, 0, 255);
  }

  return color(255, 0, 0);
}

void DrawBoard() {
  imageMode(CENTER);
  image(XboardLine, 0, 100, 1900, 55);
  imageMode(CENTER);
  image(XboardLine, 0, 180, 1900, 55);
  imageMode(CENTER);
  image(XboardLine, 0, 260, 1900, 55);
  imageMode(CENTER);
  image(XboardLine, 0, 340, 1900, 55);
  imageMode(CENTER);
  image(XboardLine, 0, 420, 1900, 55);
  imageMode(CENTER);
  image(XboardLine, 0, 500, 1900, 55);
  imageMode(CENTER);
  image(YboardLine, 110, 300, 110, 530);
  imageMode(CENTER);
  image(YboardLine, 190, 300, 110, 530);
}


void DrawBalls() {
  for (int i = 0; i < myBalls.length; i++) {
    if (myBalls[i] != null) {
      myBalls[i].draw();
    }
  }
}

void BallSpawner() {
  if (!timeStarted) startTime = millis(); 
  timeStarted = true;

  if (millis() > startTime + trueSpawnInterval * 1000) {
    SpawnBall();
    timeStarted = false;
  }
}

void ScoreCounter() {
  score += 1 / frameRate * scoreMultiplier;
}

void HitBall() {  
  for (int i = 0; i < myBalls.length; i++) {
    if (myBalls[i] != null && myBalls[i].yPos == positions[indexPos]) {
      if (myBalls[i].xPos <= ballRightMax 
        && myBalls[i].xPos >= ballLeftMax) {
        myBalls[i].Hit();
        return;
      }
    }
  }
}

public int fadeValue;

public void DrawAddedScore() {
  fill(255, 255, 255, fadeValue);
  if (scoreChange >= perfectScore) {
    text("+" + scoreChange + " Perfect!", 70, 60);
  } else if (scoreChange == 3) {
    text("+" + scoreChange + " Good!", 70, 60);
  } else if (scoreChange < 0) {
    text(scoreChange + " Miss...", 70, 60);
    misscombo++;
  }

  fadeValue -= 8;
}

public void DrawPlayer() {
  imageMode(CENTER);
  image(Player, 150, positions[indexPos], 55, 55);
  if (powerUpActive) {
    tint(253, 0, 77);
    image(Player, 150, positions[indexPos], 55, 55);
    noTint();
  }
  if (!powerUpActive) {
    noTint(); 
    image(Player, 150, positions[indexPos], 55, 55);
  }
}

public void LoadImages() {
  Player = loadImage("Sprite2.PNG");
  Background = loadImage("Background.png");
  XboardLine = loadImage("Lines1.png");
  YboardLine = loadImage("Lines2.png");
  Notes = loadImage("Note1.PNG");
  FireEffect = loadImage("Effect.gif");
  MainMenuBG = loadImage("mainmenu.jpg");
  HighScoreBG = loadImage("highscore.jpg");
  Healthbar = loadImage("Health Bar Border.png");
  BarOHealth = loadImage("Health Bar.png");
  gameOverScreen = loadImage("GameOverScreen.jpg");
  EvilNotes = loadImage("EvilNote.PNG");
}


private void DrawGame() {
  fill(255, 255, 255, 255);
  tint(255, 255);
  background(Background);
  //image(background,0,0);
  DrawBoard();

  powerUpActivator();

  textFont(font);
  text((int)score, 12, 60);
  fill(CalcColor(indexPos));
  DrawPlayer();
  fill(CalcColor(spawnPos));
  BallSpawner();
  DrawBalls();
  ScoreCounter();
  DrawAddedScore();
  image(BarOHealth, 470, 68, 40 * playerHealth, 40);
  image(Healthbar, 470, 68, 400, 40);
}

private int textFade = 0;
boolean fading = true;

private void FadeText(int min, int max) {
  if (fading) {
    textFade--;
    if (textFade <= min) fading = false;
  } else {
    textFade++;
    if (textFade >= max) fading = true;
    println(textFade);
  }
}

private void DrawMenu() {

  image(MainMenuBG, 0, 0);
  tint(100, 75);
  textFont(font, 101);
  fill(204, 0, 255, textFade / 2);
  text("Beat Heat", 55, 110);
  textFont(font, 100);
  fill(255, 255, 255, textFade * 2);
  text("Beat Heat", 50, 110);
  textFont(font, 50);
  fill(255, 255, 255, textFade);
  text("Press 'X' to start!", 90, 300);
  textFont(font, 35);
  text("Press 'up' and 'down' to move", 90, 500);
  text("Press 'space' or 'z' to hit", 90, 540);
  FadeText(0, 100);
}

private void DrawHighScore() {
  textFont(font, 60);
  tint(textFade, 50);
  image(HighScoreBG, 0, 0);
  HighScoreBG.resize(1280, 720);
  fill(204, 0, 255, 30);
  text("High Scores", 58, 110);
  textFont(font, 60);
  fill(255, 255, 255, 60);
  text("High Scores", 55, 110);
  FadeText(80, 255);
}

public void AddHealth(float amount) {
  playerHealth += amount;
  if (playerHealth > 10) {
    playerHealth = 10;
  }
}
public void particlePlay() {
  ps.addParticle();
  ps.run();
}
