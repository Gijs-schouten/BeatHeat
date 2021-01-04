import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_201006a extends PApplet {



//import processing.video.*;
//Movie background;


public int playerHealth = 10;
public boolean menuActive = true;
public float comboCalc;
public int totalCombo = 5;
public SoundFile file;
public float musicSpeed = 1;
private Ball[] myBalls;
public float score;
public float scoreMultiplier = 1;
public int indexPos = 3;
private int ballIndex = 0;
//private int frontBall = 0;
public int spawnPos;
private boolean timeStarted;
private int startTime;
public int combo = 0;
public int misscombo = 0;
public int scoreChange;
public float trueSpawnInterval = 0.8571428571428571f;
private int screenState;
public boolean powerUpActive = false;
public boolean comboPowerUp = false;
PFont font;
PImage Player;
PImage Background, 
  XboardLine, 
  YboardLine, 
  Notes, 
  MainMenuBG, 
  HighScoreBG, 
  FireEffect, 
  Healthbar, 
  BarOHealth, 
  gameOverScreen;

public void setup() {
  screenState = 0;
  
  frameRate = 144;
  //Movie background = new Movie(this, "vid.mp4");
  myBalls = new Ball[ballAmount];
  //background.play();
  font = createFont("Streamster.ttf", 32);
  SpawnBall();
  perfectHit = new SoundFile(this, "perfect_hit.wav");  
  normalHit = new SoundFile(this, "normal_hit.wav");
  menuMusic = new SoundFile(this, "MainMenu.wav");
  menuMusic.amp(0.2f);
  gameOverTheme = new SoundFile(this, "GameOver.wav");
  file = new SoundFile(this, "UltimateDestruction.wav");
  file.amp(0.9f);
  //file.loop();
  LoadImages();
}

public void draw() {
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
  spawnPos = PApplet.parseInt(random(0, 5));
  myBalls[ballIndex] = new Ball(ballSpeed, positions[spawnPos]);
  myBalls[ballIndex].setup();
  ballIndex++;
  ballIndex = ballIndex%ballAmount;
}

public void keyPressed() {
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
    screenState++;
  }
}




public int CalcColor(int pos) {
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

public void DrawBoard() {
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


public void DrawBalls() {
  for (int i = 0; i < myBalls.length; i++) {
    if (myBalls[i] != null) {
      myBalls[i].draw();
    }
  }
}

public void BallSpawner() {
  if (!timeStarted) startTime = millis(); 
  timeStarted = true;

  if (millis() > startTime + trueSpawnInterval * 1000) {
    SpawnBall();
    timeStarted = false;
  }
}

public void ScoreCounter() {
  score += 1 / frameRate * scoreMultiplier;
}

public void HitBall() {
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
  if (powerUpActive == true) {
    tint(253, 0, 77);
    image(Player, 150, positions[indexPos], 55, 55);
    noTint();
  }
  if(powerUpActive == false){
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
}


private void DrawGame() {
  fill(255, 255, 255, 255);
  tint(255, 255);
  background(Background);
  //image(background,0,0);
  DrawBoard();

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
  powerUpActivator();
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
  imageMode(CENTER);
  image(HighScoreBG, 450, 300, 900, 600);
  HighScoreBG.resize(1280, 720);
  fill(204, 0, 255, 30);
  text("High Scores", 58, 110);
  textFont(font, 60);
  fill(255, 255, 255, 60);
  text("High Scores", 55, 110);
  FadeText(80, 255);
}

public void AddHealth(int amount) {
  playerHealth += amount;
  if (playerHealth > 10) {
    playerHealth = 10;
  }
}
class Ball {
  private float _speed;
  private float xPos;
  private float yPos;
  public boolean clicked;

  Ball(float speed, float y) {
    _speed = speed;
    yPos = y;
  }

  public void setup() {
    xPos = 900;
  }

  private void Move() {
    if (clicked) return;
    imageMode(CENTER);
    image(Notes, xPos -= _speed, yPos, 45, 45);
  }

  public void draw() {
    spawnRate();
    Move();
    CheckPos();
    if (millis() >= 5000) {
      speed();
    }
  }

  public void Hit() {
    if (clicked) return;

    clicked = true;
    /*if (xPos > ballRightMax) {
     System.out.println("veel te vroeg");
     AddScore(missScore);
     return;
     }*/

    ScoreCalculate();
  }

  public void CheckPos() {
    if (xPos < 50) {
      if (!clicked) { 
        AddScore(missScore);
        AddHealth(-1);
        clicked = true;
      }
    }
  }

  public void AddScore(float amount) {
    score += amount;
    scoreChange = (int)amount;
    fadeValue = 255;
  }

  public void ScoreCalculate() {
    if (xPos >= ballLeftMin && xPos <= ballRightMin || comboPowerUp == true) {
      AddScore(perfectScore);
      System.out.println("goed");
      perfectHit();
      combo += 2;
      misscombo = 0;
     AddHealth(1);
    } 
    if (xPos >= ballRightMin && xPos <= ballRightMax) {
      if(comboPowerUp == false){
      AddScore(minScore);
      System.out.println("te vroeg");
      normalHit();
      combo++;
      misscombo = 0;
      }
      if(comboPowerUp == true){
        
      }
    }

    if (xPos <= ballLeftMin && xPos >= ballLeftMax) {
      if(comboPowerUp == false){
      AddScore(minScore);
      System.out.println("te laat");
      combo = 0;
      }
    }
  }
}


public void spawnRate() {
  int timerStart = 0;
  if (menuActive == true) {
    timerStart =+ millis();
  }

  int intervalTimer = millis() - timerStart;
  int timerReset = 0;

  if (intervalTimer < 30000 * comboChange[totalCombo]) {
    trueSpawnInterval = spawnInterval[0];
    comboCalc = spawnInterval[0];
  }

  if (intervalTimer > 30000 * comboChange[totalCombo]) {
    if (intervalTimer < 36000) {
      trueSpawnInterval = spawnInterval[1];
      comboCalc = spawnInterval[1];
    }
  }

  if (intervalTimer > 36000 * comboChange[totalCombo]) {
    if (intervalTimer < 65000) {
      trueSpawnInterval = spawnInterval[2];
      comboCalc = spawnInterval[2];
    }

    if (intervalTimer > 65000 * comboChange[totalCombo]) {
      if (intervalTimer < 87500) {
        trueSpawnInterval = spawnInterval[3];
        comboCalc = spawnInterval[3];
      }
    }
    if (intervalTimer > 87500 * comboChange[totalCombo]) {
      if (intervalTimer < 110000) {
        trueSpawnInterval = spawnInterval[4];
        comboCalc = spawnInterval[4];
      }
    }

    if (intervalTimer > 110000 * comboChange[totalCombo]) {
      if (intervalTimer < 165000) {
        trueSpawnInterval = spawnInterval[2];
        comboCalc = spawnInterval[2];
      }
    }

    if (intervalTimer > 165000 * comboChange[totalCombo]) {
      if (intervalTimer < 226000) {
        trueSpawnInterval = spawnInterval[0];
        comboCalc = spawnInterval[0];
      }
      if (intervalTimer > 226000 * comboChange[totalCombo]) {
        timerReset = millis() - timerStart;
        intervalTimer -= timerReset;
        timerReset = 0;
      }
    }
  }
}

public void speed() {

  if (trueSpawnInterval < 0.6f) {
    if (combo > 9) {
      if (musicSpeed < 1.1f) {
        if (totalCombo < 10) {
          totalCombo ++;
        }
        comboCalc *= comboChange[totalCombo];
        musicSpeed = musicSpeed + 0.02f;
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
    musicSpeed = musicSpeed - 0.02f;
    file.rate(musicSpeed);
    trueSpawnInterval = comboCalc;
    misscombo = 0;
  }
}
//Minim minim;
SoundFile perfectHit;
SoundFile normalHit;
SoundFile menuMusic;
SoundFile gameOverTheme;
class Beat {

  
  public void setup(){

  }
  
}

public void music(){
  if(menuActive == true){
    if(menuMusic.isPlaying() == false){
      menuMusic.play();
    }
  }
  if(menuActive == false){
    if(file.isPlaying() == false){
      menuMusic.stop();
     file.play();
    }
  }
  if(screenState == 4 || screenState == 3){
    file.stop();
    if(gameOverTheme.isPlaying() == false){
      gameOverTheme.play();
    }
  }
  
  
  
}

public void perfectHit(){ perfectHit.play();
}

public void normalHit(){
  normalHit.play();
}
//Dit script gaat in het algemeen over het doodgaan en bijna doodzijn
public void gameOver() {
  imageMode(CENTER);
  image(gameOverScreen, 450, 300, 900, 600);
  textFont(font, 100);
  textSize(60);
  text("Game Over", 320, 300);
  textSize(40);
  text("Press 'R' to exit or 'H' to submit highscore", 180, 500);

  if (key == 'r' || key == 'R') {
    exit();
  }

  if (key == 'h' || key == 'H'){
   playerHealth = 10;
   screenState = 3;
  }
}
public float ballRightMin = 160;
public float ballRightMax = 220;
public float ballLeftMin = 120;
public float ballLeftMax = 80;

public float perfectScore = 5;
public float minScore = 3;
public float missScore = -4;

//public float spawnInterval = 0.8571428571428571f;

public float ballSpeed = 7;

public int[] positions = { 140, 220, 300, 380, 460 };

//Nummers van de spawnInterval zijn nu nog placeholders om het systeem werkend te krijgen die later kunnen worden aangepast om het stuk volledig werkend te krijgen.
public float[] spawnInterval = new float[]{
1.3f,
100,
0.8071428571428571f,
0.9071428571428571f,
0.8571428571428571f
};

public float[] comboChange = new float[]{
  1.1f,
  1.08f,
  1.06f,
  1.04f,
  1.02f,
  1,
  0.98f,
  0.96f,
  0.94f,
  0.92f,
  0.9f
};

public final int menuScreen = 0;
public final int gameScreen = 1;
public final int ballAmount = 7;
PowerUp powerUpCombo = new PowerUp(1);
//PowerUp powerUpRow = new PowerUp(2);
//PowerUp powerUpScore = new PowerUp(3);

   int powerUpTimerStart;
  class PowerUp {

  int powerUpTimer;
  int powerUpType;
  int tempCombo = 10;


  PowerUp(int tempPowerUpType) {
    powerUpType = tempPowerUpType;
  }


  public void setup() {
  }


  public void draw() {
    if (powerUpActive == true) {
      powerUpTimer = millis() - powerUpTimerStart;
    }
  if (powerUpType == 1) {
      if (totalCombo != 10) {
        tempCombo = totalCombo;
      }
        comboPowerUp = true;
        powerUpActive = true;
      
      comboBoost();
    }
  }

  public void comboBoost() {
    if (powerUpTimer > 10000) {
      powerUpType = 0;
      powerUpActive = false;
      totalCombo = tempCombo;
      tempCombo = 10;
      comboPowerUp = false;
    }

    totalCombo = 10;
    misscombo = 0;

    textFont(font, 100);
    textSize(30);
    text("Perfect Combo Boost!", 320, 570);
  }
}

public void powerUpActivator() {
  if (powerUpActive == false) {
      powerUpTimerStart = millis();
    }
  int powerUpDecider = 0;
  if (powerUpActive == false) {
    powerUpDecider = 0;
  }

  int menuTime = 0;
  if (menuActive == true) {
    menuTime += millis();
  }
  int totalPowerUpTime = 0;

  int  powerUpActivationTimer = millis() - menuTime - totalPowerUpTime;
  int powerUpDelayer = 0;
  int powerUpDuration = 0;

  if (powerUpActivationTimer >= 20000 + powerUpDelayer) {
    if (powerUpActive == false) {
      totalPowerUpTime = millis() - powerUpActivationTimer;
      //wordt verplaats met random nummer tussen 1 en 3 wanneer andere powerups erin staan.
      powerUpDecider = 1;
      powerUpActivationTimer = 0;
      powerUpDelayer += 5000;
    }
  }
  if (powerUpDecider == 1) {
    if (powerUpDuration == 5000) {
      powerUpDecider = 0;
      powerUpDuration = 0;
    }
    powerUpCombo.draw();
  }
}
  public void settings() {  size(900, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_201006a" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
