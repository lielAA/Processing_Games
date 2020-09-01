/*image - objects constructors*/
Image imgBackgroung = new Image();
Image imgAlien = new Image();
Image imgSpaceShip = new Image();

/*music constructors*/
Music  music = new Music();
Music collectAMusic = new Music();
Music missAMusic = new Music();

/*reference points to alien and spaceship location*/
Ellipse ref1 = new Ellipse();
Ellipse ref4= new Ellipse();

/*border around "play again" text*/
Rect resetRect = new Rect();
Rect PlayRect = new Rect();

/*Text constructors*/
Text scoreT = new Text();
Text scoreV = new Text();
Text LifeT = new Text();
Text LifeV = new Text();
Text GameOver = new Text();
Text resetT = new Text();
Text level = new Text();
Text levelValue = new Text();
Text play = new Text();
Text finish = new Text();

/*Strings for text constructors*/
String scoreText = "score: ";
String scoreValue = "0";
String LifeText = "Life: ";
String LifeValue = "❤❤❤";
String GO = "Game - Over!";
String resetG = "Play Again";
String levelText = "Level: ";
String playText = "Play";
String finishText = "Well Done - Mission Accomplished";

boolean isMissed = false;
boolean countMissed = false;
boolean mouseIsPressed = false;

int Alienspeed; // alien speed faling
int spaceShipSpeed; // space ship speed
String levelV = "1";

void setup() 
{
  size(1900, 950);
  background(255);
  
  // objects setup
  imgBackgroung.setImage("Gamebackground.png");
  imgAlien.setImage("alien.png");
  imgSpaceShip.setImage("spaceship.png");
  
  // Music setup
  music.load("Hooked_on_a_ Feeling.mp3");
  music.play();
  collectAMusic.load("collectAlien.mp3");
  missAMusic.load("missAlien.mp3");
  //
  Alienspeed = 4;// alien speed faling
  spaceShipSpeed = 9; // space ship speed
  
  // alien setup
  imgAlien.width = 70;
  imgAlien.height = 70;
  
  // spaceship setup
  imgSpaceShip.x = (1500/2);
  imgSpaceShip.y = 800;
  imgSpaceShip.width = 170;
  imgSpaceShip.height = 130;
  
  // points setup
  ref1.radiusX = 1;
  ref1.radiusY = 1;
  ref4.radiusX = 1;
  ref4.radiusY = 1;
  
  // "Score" Text setup
  scoreT.x = 0;
  scoreT.y = 50;
  scoreT.text = scoreText;
  scoreT.brush = color(0,255,0);
  scoreT.textSize = 40;
  // score value setup
  scoreV.x = 120;
  scoreV.y = 50;
  scoreV.text = scoreValue;
  scoreV.brush = color(0,255,0);
  scoreV.textSize = 40;
  // "Life" Text setup
  LifeT.x = 0;
  LifeT.y = 100;
  LifeT.text = LifeText;
  LifeT.brush = color(255,0,0);
  LifeT.textSize = 40;
  // Life value setp
  LifeV.x = 100;
  LifeV.y = 100;
  LifeV.text = LifeValue;
  LifeV.brush = color(255,0,0);
  LifeV.textSize = 40;
  // gameOver Text setup
  GameOver.x = 500;
  GameOver.y = 950/2;
  GameOver.text = GO;
  GameOver.brush = color(255,0,0);
  GameOver.textSize = 130;
  // "Play message"
  play.x = 760;
  play.y = 950/2;
  play.text = playText;
  play.brush = color(0,191,255);
  play.textSize = 70;
  // play message border
  PlayRect.x = 735;
  PlayRect.y = 410;
  PlayRect.width = 180;
  PlayRect.height = 80;
  PlayRect.pen = color(255,69,0);
  PlayRect.penThickness = 5;
  // finish message
  finish.x = 255;
  finish.y = 950/2;
  finish.text = finishText;
  finish.brush = color(0,255,0);
  finish.textSize = 90;
  
  // "Play Again" Text setup
  resetT.x = 790;
  resetT.y = (950/2)+150;
  resetT.text = resetG;
  resetT.brush = color(0,204,102);
  resetT.textSize = 40;
  // border around "Play Again" Text setup
  resetRect.x = 775;
  resetRect.y = 585;
  resetRect.width = 230;
  resetRect.height = 70;
  resetRect.pen = color(255,69,0);
  resetRect.penThickness = 5;
  // "level" Text setup
  level.x = 0;
  level.y = 150;
  level.text = levelText;
  level.brush = color(255);
  level.textSize = 40;
  // level value setup
  levelValue.x = 115;
  levelValue.y = 150;
  levelValue.text = levelV;
  levelValue.brush = color(255);
  levelValue.textSize = 40;
  noLoop();
}

void draw() 
{
  imgBackgroung.draw();
  imgSpaceShip.draw();
  
  
  
  scoreT.draw();
  scoreV.draw();
  LifeT.draw();
  LifeV.draw();
  level.draw();
  levelValue.draw();
  if(!mouseIsPressed) // player not click "play"
  {
    PlayRect.draw();
    play.draw();
  }
  else // player click "play"
  {
    imgAlien.draw();
  }
    
  // centered reference points 
  ref1.x = imgSpaceShip.getX() + 85;
  ref1.y = imgSpaceShip.getY()+65;
  ref4.x = imgAlien.getX()+35;
  ref4.y = imgAlien.getY()+35;
  
  if(ref4.getY() <= 950) // alien fall up to end of y vertex 
  {
    imgAlien.y += Alienspeed;
  }
  else  // create new alien in random x location
  {
    imgAlien.y = 0; 
    imgAlien.x = (int)random(50, 1650);
    if(countMissed)
      countMissed = false;
  }
  
  if((ref1.getX() <= ref4.getX()+85) && (ref1.getX() >= ref4.getX()-85) && (ref1.getY() <= ref4.getY())) // if alien between spaceship x borders && not pass it by y vertex  
  {
    collectAMusic.play();
    scoreV.text = String.valueOf(parseInt(scoreV.text)+1); // increase score
    imgAlien.y = 0; // move alien to top of screen
    imgAlien.x = (int)random(50, 1650); // create new random alien
  }
  if(ref1.getY() < ref4.getY()-85 && !isMissed) // missed alien 
  {
    isMissed = true;
    missAMusic.play();
    if(LifeV.text.length() == 0) // end of life 
    {
      GameOver.draw(); // print game over
      resetRect.draw(); // print rect around "play again"
      resetT.draw(); // print "play again"
      noLoop(); // stop 
    }
    if(LifeV.text.length() > 0 && !countMissed) // there is more life
    { 
      LifeV.text = LifeV.text.substring(0,LifeV.text.length()-1); // decrease 1 life
      countMissed = true;
    }
    isMissed = false;
  }
  
  if(parseInt(scoreV.text) >= 5 && parseInt(scoreV.text) <= 10) // move to level 2
  {
    Alienspeed = 5; // increase alien speed
    levelValue.text = "2"; // increase level
  }
  else if(parseInt(scoreV.text) >= 10 && parseInt(scoreV.text) <= 15)
  {
    Alienspeed = 6;
    levelValue.text = "3";
  }
  else if(parseInt(scoreV.text) > 15)
  {
    finish.draw(); // print finsih message
    resetRect.draw(); // print rect around "play again"
    resetT.draw(); // print "play again"
    noLoop();
  }
  
  /*control spaceship movements --> right, left, stop*/
  if(imgSpaceShip.getX() >= 35 && imgSpaceShip.getX() <= 1700) // spaceship borders
  {
    if(keyCode == RIGHT && keyCode != UP) // 
      {
        imgSpaceShip.x += spaceShipSpeed;
      }
    else if(keyCode == LEFT && keyCode != UP) 
      imgSpaceShip.x -= spaceShipSpeed;
  }
  else if(imgSpaceShip.getX() < 35)
  {
    if(keyCode == RIGHT)
      imgSpaceShip.x += spaceShipSpeed;
  }
  else if(imgSpaceShip.getX() > 1700)
  {
    if(keyCode == LEFT)
      imgSpaceShip.x -= spaceShipSpeed;
  }
}

void mousePressed()
{
  if(mouseY >= 585 && mouseY <= 585+70 && mouseX >= 775 && mouseX <= 775+230 && mousePressed)
  {
    setup();
    loop();
  }
  if(mousePressed && mouseY >= 410 && mouseY <= 410+80 && mouseX >= 735 && mouseX <= 735+180)
  {
    mouseIsPressed = true;
    loop();
    
  }
}
