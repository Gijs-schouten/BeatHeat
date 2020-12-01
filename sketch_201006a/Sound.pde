//Minim minim;
SoundFile perfectHit;
SoundFile normalHit;
class Beat {

  
  void setup(){

  }
  
}

public void music(){
  if(menuActive == false){
    if(file.isPlaying() == false){
     file.play();
    }
  }
  
  
  
}

public void perfectHit(){ perfectHit.play();
}

public void normalHit(){
  normalHit.play();
}
