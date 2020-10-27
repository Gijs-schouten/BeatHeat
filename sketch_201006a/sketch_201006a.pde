private Ball myBall;
public float score;
public int indexPos = 3;
public int spawnPos;
PFont font;

void setup() {
  size(900, 600);
  frameRate = 144;
  font = createFont("Arial", 32);
  SpawnBall();
  myBall.setup();
}

void draw() {
  background(135, 135, 135);
  textFont(font);
  text((int)score, 12, 60);
  fill(CalcColor(indexPos));
  ellipse(150, positions[indexPos], 50, 50);
  fill(CalcColor(spawnPos));
  myBall.draw();
}

public void SpawnBall() {
  spawnPos = int(random(0, 5));
  myBall = new Ball(ballSpeed, positions[spawnPos]);
  myBall.setup();
}

void mousePressed() {
  myBall.mousePressed();
  SpawnBall();
}

void keyPressed() {
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
