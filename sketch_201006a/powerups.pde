PowerUp powerUpCombo = new PowerUp(1);
PowerUp powerUpOneRow = new PowerUp(2);
PowerUp powerUpDoubleScore = new PowerUp(3);
int powerUpDecider = 0;
int powerUpTimerStart;
int menuTime = 0;
int totalPowerUpTime = 0;
int powerUpDelayer = 0;
int powerUpDuration = 0;
int powerUpActivationTimer = 0;
int powerUpTimerReset = 0;
public int tempCombo = 10;

class PowerUp {

int powerUpType;


  PowerUp(int tempPowerUpType) {
    powerUpType = tempPowerUpType;
  }


  void setup() {
  }


  void draw() {

    if (powerUpType == 1) {
      comboBoost();
    }
    if(powerUpType == 2){
     rowBoost(); 
    }
    if(powerUpType == 3){
      scoreBoost();
    }
  }

  void comboBoost() {

    textFont(font, 100);
    textSize(30);
    text("Perfect Combo Boost!", 320, 570);
  }
  
  void rowBoost(){
    
    
    textFont(font, 100);
    textSize(30);
    text("One Row Boost!", 320, 570);
  }
  
  void scoreBoost(){
    
    
    textFont(font, 100);
    textSize(30);
    text("Double Score Boost!", 320, 570);
  }
}

void powerUpActivator() {
    
    
  if (powerUpDecider == 1 || powerUpDecider == 2 || powerUpDecider == 3) {
    powerUpActive = true;
  } else {
    powerUpActive = false;
  }


  if (powerUpActive == false) {
    powerUpTimerStart = millis();
    comboPowerUp = false;
    rowPowerUp = false;
    scorePowerUp = false;
  }
  if (menuActive == true) {
    menuTime += millis();
  }
  
  
  powerUpActivationTimer = millis() - menuTime - totalPowerUpTime - powerUpTimerReset;


  if (powerUpActivationTimer >= 20000 + powerUpDelayer) {
    if (powerUpActive == false) {
      totalPowerUpTime = millis() - powerUpActivationTimer;
      //wordt verplaats met random nummer tussen 1 en 3 wanneer andere powerups erin staan.
      powerUpDecider = int(random(1, 3));
      powerUpActivationTimer = 0;
      powerUpDelayer += 5000;
    }
  }
  if (powerUpDecider == 1) {
    powerUpCombo.draw();
    comboPowerUp = true;
  }
  if(powerUpDecider == 2){
    powerUpOneRow.draw();
    rowPowerUp = true;
  }
  
  if(powerUpDecider == 3){
    powerUpDoubleScore.draw();
    scorePowerUp = true;
  }

  if (powerUpActive == true) {
    powerUpDuration = millis() - powerUpTimerStart;
    powerUpTimerReset = millis() - menuTime;
  }
  if (powerUpDuration >= 5000) {
    powerUpDecider = 0;
    powerUpDuration = 0;
    powerUpActivationTimer = 0;
    tempCombo = 10;
  }
}
