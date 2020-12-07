//Minim minim;
SoundFile perfectHit;
SoundFile normalHit;
SoundFile menuMusic;
SoundFile gameOverTheme;
class Beat {

  
  void setup(){

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
