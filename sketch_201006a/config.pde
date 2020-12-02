public float ballRightMin = 160;
public float ballRightMax = 200;
public float ballLeftMin = 140;
public float ballLeftMax = 90;

public float perfectScore = 5;
public float minScore = 3;
public float missScore = -4;

//public float spawnInterval = 0.8571428571428571f;

public float ballSpeed = 7;

public int[] positions = { 140, 220, 300, 380, 460 };

//Nummers van de spawnInterval zijn nu nog placeholders om het systeem werkend te krijgen die later kunnen worden aangepast om het stuk volledig werkend te krijgen.
public float[] spawnInterval = new float[]{
1.3,
100,
0.8071428571428571f,
0.9071428571428571f,
0.8571428571428571f
};

public float[] comboChange = new float[]{
  1.1,
  1.08,
  1.06,
  1.04,
  1.02,
  1,
  0.98,
  0.96,
  0.94,
  0.92,
  0.9
};

public final int menuScreen = 0;
public final int gameScreen = 1;
public final int ballAmount = 7;
