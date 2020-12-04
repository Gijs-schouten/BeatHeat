//Dit script gaat in het algemeen over het doodgaan en bijna doodzijn

PImage gameOverScreen;




void gameOver(){
  gameOverScreen = loadImage("GameOverScreen.jpg");
  image(gameOverScreen, 0, 0);
  textFont(font, 100);
  textSize(60);
  text("Game Over", 320, 300);
  textSize(40);
  text("Press 'R' to exit sketch or 'H' to submit highscore", 180, 500);
  
  
  if(key == 'r' || key == 'R'){
    exit();
  }
  
}
