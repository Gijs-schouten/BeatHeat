//Hier staat de powerup class die de speler laat weten welke powerup actief is.
PowerUp powerUpCombo = new PowerUp(1);
PowerUp powerUpOneRow = new PowerUp(2);
PowerUp powerUpDoubleScore = new PowerUp(3);

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
    if (powerUpType == 2) {
      rowBoost();
    }
    if (powerUpType == 3) {
      scoreBoost();
    }
  }

  void comboBoost() {

    textFont(font, 100);
    textSize(30);
    text("Perfect Combo Boost!", 320, 570);
  }

  void rowBoost() {


    textFont(font, 100);
    textSize(30);
    text("One Row Boost!", 320, 570);
  }

  void scoreBoost() {


    textFont(font, 100);
    textSize(30);
    text("Double Score Boost!", 320, 570);
  }
}
