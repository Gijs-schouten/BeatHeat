//Hier worden variabelen die nog worden aangepast gedeclareerd.
public float playerHealth = floor(10.0);
public boolean menuActive = true;
public float comboCalc;
public int totalCombo = 5;
public SoundFile file;
public float musicSpeed = 1;
private Ball[] myBalls;
public float score;
public float scoreMultiplier = 1;
public int indexPos = 3;
private int ballIndex = 0;
//private int frontBall = 0;
public int spawnPos;
private boolean timeStarted;
private int startTime;
public int combo = 0;
public int misscombo = 0;
public int scoreChange;
public float trueSpawnInterval = 0.8571428571428571f;
private int screenState;
public boolean powerUpActive = false;
public boolean comboPowerUp = false;
public boolean rowPowerUp = false;
public boolean scorePowerUp = false;
public int powerUpDecider = 0;
public int powerUpTimerStart;
public int menuTime = 0;
public int totalPowerUpTime = 0;
public int powerUpDelayer = 0;
public int powerUpDuration = 0;
public int powerUpActivationTimer = 0;
public int powerUpTimerReset = 0;
public int tempCombo = 10;
public int timerStart = 0;
public int intervalTimer = millis() - timerStart;
public int timerReset = 0;
public boolean particleActive = false;
public int particleTimer = 0;
public int particleTimerCheck = 0;
public int fadeValue;
