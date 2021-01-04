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


  void setup() {
  }


  void draw() {
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

  void comboBoost() {
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

void powerUpActivator() {
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
