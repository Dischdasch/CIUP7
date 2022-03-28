import processing.sound.*;

AudioIn IN;
Amplitude nivel;
float volumenSum;
int volumenCounter;
int ancho = 0;
SoundFile  sound;
SoundFile finish;
int r = 30;
int balonX;
int balonY;
int movX;
int movY;
PImage net;
PImage ball;

int in;
int out;
int timer = 30;

boolean gameStarted;
boolean lastBallMade;
boolean gameJustFinished = true;
boolean startNewGame = false;

void setup() {
  size(500, 500);
  background(255);

  // Entrada de audio, toma primer canal
  IN = new AudioIn(this, 0);

  //Lanza captura
  IN.start();

  // Analizador de amplitud
  nivel = new Amplitude(this);

  // Asocia entrada y analizador
  nivel.input(IN);

  noStroke();
  //Tono de relleno con transparencia
  fill(255, 0, 0, 50);

  volumenCounter = 0;
  volumenSum = 0;

  sound = new SoundFile(this, "swish.wav");
  finish = new SoundFile(this, "finish.wav");

  balonY = 15;
  balonX = int(random(15, width-15));
  int[] movVal = { 2, 3, 4};
  int movYIndex = int(random(3));
  movY = movVal[movYIndex];
  net = loadImage("Net.png");
  ball = loadImage("ball.png");
  
  lastBallMade = false;
}

void draw() {
  background(245);
  if(!gameStarted)
  {
    //introduction
    fill(100);
    textSize(20);
    text("Try to Catch Falling Balls With a Basket", 13, 220);
    text("Move the Basket by Changing the Volume of Your Voice", 13, 250);
    text("You Have 30 Seconds", 13, 280);
    text("Press Enter to Start", 13, 480);
    
     //Display game information
    fill(100);
    rect(150, 50, 200, 100);
    fill(255, 165, 0);
    textSize(60);
    text(timer, 215, 100);
  
    //draw net
    net.resize(100, 0);
    image(net, 400, 405);

    //draw ball
    ball.resize(r,r);
    image(ball,435, 300);
  }
  else{
    //play and initiate game
  if(startNewGame){
    //reset timer and points
    timer = 30;
    in = 0;
    out = 0;
    startNewGame = false;
  }
  //Display game information
  fill(100);
  rect(150, 50, 200, 100);
  fill(255, 165, 0);
  textSize(60);
  if(timer >= 10)
  {
    text(timer, 215, 100);
  }
  else{
    text(timer, 230, 100);
  }
  fill(255);
  textSize(25);
  text("IN", 160, 80);
  text("OUT", 290, 80);
  fill(255, 0, 0);
  textSize(50);
  text(in, 160, 125);
  text(out, 295, 125);
  
  if (timer > 0 || lastBallMade == false)
  {
    //game is running
    //decrease timer each second
    if (frameCount % 60==0 && timer >0)
    {
      timer--;
    }
    //get the users volume
    float volumen = nivel.analyze();
    
    //Average of volume for smoothness
    volumenSum += volumen;
    volumenCounter += 1;
    //every 6th of second
    if (frameCount % 10 == 0)
    {
      volumenSum = volumenSum / volumenCounter;
      //get volume mapped to width
      ancho = int(map(volumenSum, 0, 0.3, 0, 400));
      if (ancho >= 400)
      {
        ancho = 400;
      }
      volumenSum = 0;
      volumenCounter = 0;
    }
    //draw net
    rectMode(CORNER);
    net.resize(100, 0);
    image(net, ancho, 405);

    //draw ball
    ball.resize(r,r);
    image(ball,balonX-r/2, balonY-r/2);
    
    //move ball
    balonY += movY;

    //check if ball hit net
    if (balonY+r/2>=405 )
    {
      //ball in net
      if (ancho<=balonX-r/2 && balonX+r/2<=ancho+100 && balonY+r/2>=405 && balonY+r/2<=410)
      {
        thread ("Suena");
        balonY = 15;
        balonX = int(random(15, width-15));
        int[] movVal = { 2, 3,4};
        int movYIndex = int(random(3));
        movY = movVal[movYIndex];
        in++;
        //let the last ball be played
        if(timer == 0)
        {
          lastBallMade = true;
        }
      }
      
      //ball hit bottom
      else {
        if (balonY+r/2>=500)
        {
          balonY = 15;
          balonX = int(random(15, width-15));
          int[] movVal = { 2, 3};
          int movYIndex = int(random(2));
          movY = movVal[movYIndex];
          out++;
          //let the last ball be played
          if(timer == 0)
          {
            lastBallMade = true;
          }
        }
      }
    }
  }
  else{
    //game finished
    if(gameJustFinished)
    {
      gameJustFinished = false;
      thread ("Finish");
    }
    else{
      fill(100);
      textSize(45);
      text("Press Enter to Play Again", 13, 250);
    }
  }
  }
}

//helper function sound
void Suena( ) {
  sound.amp(0.1);
  sound.play();
}

void Finish( ) {
  finish.amp(0.5);
  finish.play();
}

void keyPressed()
{
  if(keyCode == ENTER && (timer == 0 || !gameStarted))
  {
  startNewGame = true;
  gameStarted = true;
  }
}
