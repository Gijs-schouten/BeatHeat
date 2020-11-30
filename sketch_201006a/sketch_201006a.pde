import processing.sound.*;
//import processing.video.*;
//Movie background;

//Nummers van de spawnInterval zijn nu nog placeholders om het systeem werkend te krijgen die later kunnen worden aangepast om het stuk volledig werkend te krijgen.
public float[] spawnInterval = new float[]{
0.8571428571428571f,
0.8571428571428571f,
0.8571428571428571f,
0.8571428571428571f,
0.8571428571428571f
};
public boolean menuActive = false;
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
PFont font;
PImage Player;
PImage Background;
PImage XboardLine;
PImage YboardLine;
PImage Notes;
PImage FireEffect;


void setup() {
  size(900, 600);
  frameRate = 144;
  //Movie background = new Movie(this, "vid.mp4");
  myBalls = new Ball[5];
  //background.play();
  font = createFont("Streamster.ttf", 32);
  SpawnBall();
  file = new SoundFile(this, "UltimateDestruction.wav");
  file.loop();
   Player = loadImage("Sprite2.PNG");
   Background = loadImage("Background.png");
   XboardLine = loadImage("Lines1.png");
   YboardLine = loadImage("Lines2.png");
   Notes = loadImage("Note1.PNG");
   FireEffect = loadImage("Effect.gif");
}

void draw() {;
  background(Background);
  //image(background,0,0);
  DrawBoard();
  fill(255);
  textFont(font);
  text((int)score, 12, 60);
  fill(CalcColor(indexPos));
  DrawPlayer();
  fill(CalcColor(spawnPos));
  BallSpawner();
  DrawBalls();
  ScoreCounter();
  DrawAddedScore();
}

public void SpawnBall() {
  spawnPos = int(random(0, 5));
  myBalls[ballIndex] = new Ball(ballSpeed, positions[spawnPos]);
  myBalls[ballIndex].setup();
  ballIndex++;
  ballIndex = ballIndex%5;
}

void keyPressed() {
  if (key == ' ') {
    HitBall();
  }

  if(key == ' '){
    for(int i = 0; i < myBalls.length; i++){
      if(myBalls[i].yPos == positions[indexPos]){
        myBalls[i].Hit();
        return;
      }
    }
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


void DrawBalls(){
  for(int i = 0; i < myBalls.length; i++){
      if(myBalls[i] == null) return;
      myBalls[i].draw();
    }
  }

void BallSpawner(){
  if(!timeStarted) startTime = millis(); timeStarted = true;
  
  if(millis() > startTime + trueSpawnInterval * 1000){
    SpawnBall();
    timeStarted = false;
  }
}

void ScoreCounter() {
  score += 1 / frameRate * scoreMultiplier;
}

void HitBall() {
  for (int i = 0; i < myBalls.length; i++) {
    if (myBalls[i].yPos == positions[indexPos] && myBalls[i].xPos < 300) {
      myBalls[i].Hit();
      return;
    }
  }
}

public int fadeValue;

public void DrawAddedScore() {
  fill(255, 255, 255, fadeValue);
  if(scoreChange >= perfectScore){
    text("+" + scoreChange + " Perfect!", 70, 60);
  } else if(scoreChange == 3) {
    text("+" + scoreChange + " Good!", 70, 60);
  } else {
    text(scoreChange + " Miss...", 70, 60);
  }
  
  fadeValue -= 8;
  
}

public void DrawPlayer(){
imageMode(CENTER);
  image(Player, 150, positions[indexPos], 55, 55);
}
public void PlayEffect(){
  


}
