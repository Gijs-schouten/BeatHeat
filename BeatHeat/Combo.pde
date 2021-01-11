void comboSpeed() {

  if (trueSpawnInterval < 0.6) {
    if (combo > 9) {
      if (musicSpeed < 1.1) {
        if (totalCombo < 10) {
          totalCombo ++;
        }
        if (comboPowerUp) {
          if (totalCombo != 10) {
            tempCombo = totalCombo;
          }
          totalCombo = 10;
          misscombo = 0;
        }
        comboCalc *= comboChange[totalCombo];
        musicSpeed = musicSpeed + 0.02;
        file.rate(musicSpeed);
        trueSpawnInterval = comboCalc;
        combo = 0;
      }
    }
  }

  if (misscombo == 75) {
    if (totalCombo > 0) {
      totalCombo --;
    }
    comboCalc *= comboChange[totalCombo]; 
    musicSpeed = musicSpeed - 0.02;
    file.rate(musicSpeed);
    trueSpawnInterval = comboCalc;
    misscombo = 0;
  }
}
