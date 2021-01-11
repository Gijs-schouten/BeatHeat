//Hier staat de code die powerups activeert.
void powerUpActivator() {


  if (powerUpDecider == 1 || powerUpDecider == 2 || powerUpDecider == 3) {
    powerUpActive = true;
  } else {
    powerUpActive = false;
  }


  if (!powerUpActive) {
    powerUpTimerStart = millis();
    comboPowerUp = false;
    rowPowerUp = false;
    scorePowerUp = false;
  }
  if (menuActive) {
    menuTime += millis();
  }


  powerUpActivationTimer = millis() - menuTime - totalPowerUpTime - powerUpTimerReset;


  if (powerUpActivationTimer >= 20000 + powerUpDelayer) {
    if (!powerUpActive) {
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
  if (powerUpDecider == 2) {
    powerUpOneRow.draw();
    rowPowerUp = true;
  }

  if (powerUpDecider == 3) {
    powerUpDoubleScore.draw();
    scorePowerUp = true;
  }

  if (powerUpActive) {
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
