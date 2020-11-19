class Ball {
  private float _speed;
  private float xPos;
  private float yPos;
  private boolean clicked;
  
  Ball(float speed, float y){
      _speed = speed;
      yPos = y;
  }
  
  void setup(){
    xPos = 900;
    //yPos = 300;
  }
  
  private void Move(){
    if(clicked) return;
    ellipse(xPos -= _speed, yPos, 50, 50);
  }
  
  void draw(){
    Move();
    CheckPos();
  }
  
  void Hit(){
    System.out.println(yPos);
    clicked = true;
      if(xPos > ballRightMax){
        System.out.println("veel te vroeg");
        AddScore(missScore);
        return;      
      }
      
      ScoreCalculate();
  }
  
  void CheckPos(){
    if(xPos < 50){
      if(!clicked) AddScore(missScore);
      clicked = true;
    }  
  }
  
  void AddScore(float amount){
    score += amount;
  }
  
  void ScoreCalculate(){
    
    
    if(xPos >= ballLeftMin && xPos <= ballRightMin){
      AddScore(perfectScore);
      System.out.println("goed");
    } 
    
    if(xPos > ballRightMin && xPos < ballRightMax){
      AddScore(minScore);
      System.out.println("te vroeg");
    }
    
    if(xPos < ballLeftMin && xPos > ballLeftMax){
      AddScore(minScore);
      System.out.println("te laat");
    }
  }
  
  
}
