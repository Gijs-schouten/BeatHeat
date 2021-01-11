//Deze code past de snelheid waarop ballen spawnen aan op de snelheid van de muziek.
void spawnRate() {
  
  if (menuActive == true) {
    timerStart =+ millis();
  }


  if (intervalTimer < 30000 * comboChange[totalCombo]) {
    trueSpawnInterval = spawnInterval[0];
    comboCalc = spawnInterval[0];
  }

  if (intervalTimer > 30000 * comboChange[totalCombo]) {
    if (intervalTimer < 36000) {
      trueSpawnInterval = spawnInterval[1];
      comboCalc = spawnInterval[1];
    }
  }

  if (intervalTimer > 36000 * comboChange[totalCombo]) {
    if (intervalTimer < 65000) {
      trueSpawnInterval = spawnInterval[2];
      comboCalc = spawnInterval[2];
    }

    if (intervalTimer > 65000 * comboChange[totalCombo]) {
      if (intervalTimer < 87500) {
        trueSpawnInterval = spawnInterval[3];
        comboCalc = spawnInterval[3];
      }
    }
    if (intervalTimer > 87500 * comboChange[totalCombo]) {
      if (intervalTimer < 110000) {
        trueSpawnInterval = spawnInterval[4];
        comboCalc = spawnInterval[4];
      }
    }

    if (intervalTimer > 110000 * comboChange[totalCombo]) {
      if (intervalTimer < 165000) {
        trueSpawnInterval = spawnInterval[2];
        comboCalc = spawnInterval[2];
      }
    }

    if (intervalTimer > 165000 * comboChange[totalCombo]) {
      if (intervalTimer < 226000) {
        trueSpawnInterval = spawnInterval[0];
        comboCalc = spawnInterval[0];
      }
      if (intervalTimer > 226000 * comboChange[totalCombo]) {
        timerReset = millis() - timerStart;
        intervalTimer -= timerReset;
        timerReset = 0;
      }
    }
  }
}
