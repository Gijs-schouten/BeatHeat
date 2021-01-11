//Dit script gaat in het algemeen over het doodgaan en bijna doodzijn
public void gameOver() {
  imageMode(CENTER);
  image(gameOverScreen, 450, 300, 900, 600);
  textFont(font, 100);
  textSize(60);
  text("Game Over", 320, 300);
  textSize(40);
  text("Press 'R' to exit or 'H' to submit highscore", 180, 500);
  file.stop();

  if (key == 'r' || key == 'R') {
    exit();
  }

  if (key == 'h' || key == 'H'){
   playerHealth = 10;
   screenState = 3;
  }
}
