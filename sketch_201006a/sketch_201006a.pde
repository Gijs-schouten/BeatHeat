private Ball myBall;
public float score;
PFont font;

void setup(){
  size(900, 600);
  frameRate = 144;
  font = createFont("Arial", 32);
  SpawnBall();
  myBall.setup();
}

void draw(){
  background(135, 135, 135);
  textFont(font);
  text((int)score, 12, 60);
  ellipse(150, height / 2, 50, 50);
  myBall.draw();
}

public void SpawnBall(){
  myBall = new Ball(ballSpeed);
  myBall.setup();
}

void mouseClicked(){
  myBall.mouseClicked();
  SpawnBall();
}
