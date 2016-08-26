//import processing.sound.*;

//SoundFile blockHit1;
//SoundFile blockHit2;
//SoundFile outSound;
//SoundFile[] brickHitSound;
/*-----------------------------------------------------
 Simple ping pong & break bricks Game
 by semi kwon
 
 Game 1 - break bricks(1Player)
 1 paddle on the right wall moves up and down by 'UP' or 'Down' keys.
 ball moves and bounces cross the window.
 gamer should block the ball with paddle and bounce it to break the bricks.
 if player breaks every brick(WIN) or lost all life(Lose), game ends.
 
 Game 2 - ping pong (2Player)
 2 paddles on the left and right wall.
 right paddle moves by 'w' and 's', left paddle moves up/down by 'UP' or 'Down' keys
 ball moves and bounces cross the window.
 players should block the ball with paddle so it can't go throught out.
 if ball go out throught left of right wall, the other side player get one score.
 when one gets enought score, game ends.
 
 
 Scene structure 
 Three main scene : start scene, break bricks game scene, ping pong game scene.
 some ending scene : connected to fuction of win or lose
 
 
 Class and Elements  
 Class : Brick, Block, Ball, Score, Button  
 Array List : brickArray, buttonArray
 Array : blockArray, scoreArray
 object : ballP1, ballP2
 -------------------------------------------------------*/




PFont scoreFont; // font for display text and score.

// Scene Numbers -----------------------------------------
// scene 1 : start scene - player can choose 1player mode or 2player mode. 
//           Elements - button and text
// scene 2 : in game scene, 1 player mode (break brick game) 
//           Elements - ball1P, block1, bricks, life left
// scene 3 : in game scene, 2 player mode (ping pong game)
//           Elements - ballP2, block1, block2, score system
// -------------------------------------------------------------
int startScene = 1;
int breakBricksGame = 2;
int pingPongGame = 3;
int scene = startScene; //initial scene sets to start scene

// color setup
color yellow = color(255, 255, 0);
color red = color(255, 0, 0);
color green = color(0, 255, 0);
color white = color(255, 255, 255);

// declare brick & button arrayList.
ArrayList<Brick> brickArray; //declaration brick arrayList
ArrayList<Button> buttonArray;

// declare block object Array
Block[] blockArray = new Block[2];
// declare ball objects
Ball ballP1;
Ball ballP2;
// declare score object array
Score[] scoreArray = new Score[3];


//brick variables
float w = 30;
float h = 65;

float brickDistHorizontal = w + 5;
float brickDistVertical = h + 5;
int brickHorizontalNum;
int brickVerticalNum;

//win and lose variables
int winScore = 5; // player who get this score wins.



void setup() {
  size(600, 400);
  scoreFont = loadFont("Courier-Bold-60.vlw");
  rectMode(CENTER);

  brickHorizontalNum = int(width*0.4/w);
  brickVerticalNum = int(height/h);

  //brick 생성
  brickArray = new ArrayList<Brick>();
  createBricks(); 
  //block 생성
  for (int i = 0; i <2; i++) {
    blockArray[i] = new Block();
  }
  blockArray[1].x = blockArray[1].w/2;
  //ballP1 생성
  ballP1 = new Ball();
  ballP1.x = width;
  ballP2 = new Ball();

  //score 생성
  // scoreArray[0] : for ping pong game Player 1 (right Block)
  // scoreArray[1] : for ping pong game Player 2 (left Block)
  // scoreArray[2] : for break bricks game Player 1 (life left)
  for (int i = 0; i < 3; i++) {
    scoreArray[i] = new Score();
  }
  scoreArray[1].scoreX = width/2 + scoreArray[1].offset;
  // button 생성 for start scene
  buttonArray = new ArrayList<Button>();
  buttonArray.add(new Button(scoreArray[0].scoreX, 300, 90, 40, "1Player")); // if clicks going to break bricks game
  buttonArray.add(new Button(scoreArray[1].scoreX, 300, 90, 40, "2Player")); // if clicks going to ping pong game


  //// load SoundFile
  //blockHit1 = new SoundFile(this, "blockHit1.mp3");
  //blockHit2 = new SoundFile(this, "blockHit2.mp3");
  //outSound= new SoundFile(this, "out.mp3");

  //brickHitSound = new SoundFile[4];
  //for (int i = 0; i < 4; i++) {
  //  int index = i+1;
  //  brickHitSound[i] = new SoundFile(this, "brickHit"+index+".mp3");
  //}
}


void draw() {
  if (scene == startScene) {
    startDisplay();
  } else if (scene == breakBricksGame) {
    background(0);
    //ball move, bounce, display
    ballP1.move();
    ballP1.bounceBallY();
    ballP1.bounceBallX_P1();
    ballP1.drawBall();

    //brick crushed, display
    for (int i = 0; i < brickArray.size(); i++) {
      Brick temp = brickArray.get(i);
      temp.display();
      temp.crushed();
      temp.bounceBrick();
      temp.removeBrick(i);
    }

    //block move, display
    println(blockArray[0].blockColor);
    blockArray[0].move();
    blockArray[0].colorChange();
    blockArray[0].drawBlock();
    println(blockArray[0].blockColor);

    //life left
    scoreArray[2].displayLife();

    // win
    winGame1();
  } else if (scene == pingPongGame) {
    drawBackground();

    ballP2.move();
    ballP2.drawBall();
    ballP2.bounceBallY();
    ballP2.bounceBallX();

    for (int i = 0; i < 2; i++) {
      blockArray[i].drawBlock();
      blockArray[i].colorChange();
      blockArray[i].move();
    }

    for (int i = 0; i < 2; i++) {
      scoreArray[i].displayScore();
    }
    winGame2();
  }
}


void keyPressed() {
  // control two blocks
  // block 1 (player2)
  if (keyCode == UP) {
    blockArray[0].speed = -4; // block 1 moves up
  }
  if (keyCode == DOWN) {
    blockArray[0].speed = 4; // block 2 moves down
  }
  // block 2
  if (key == 'w') {
    blockArray[1].speed = -4; // block 1 moves up
  }
  if (key == 's') {
    blockArray[1].speed = 4; // block 1 moves down
  }
  if (keyCode == ENTER) {
    scene = 1;
    loop();
  }
}


void keyReleased() {
  //when key released blocks' Yspeed become 0 so it stopped 
  if (keyCode == UP || keyCode == DOWN) {
    blockArray[0].speed = 0;
  }
  if (key == 'w' || key == 's') {
    blockArray[1].speed = 0;
  }
}


void mouseClicked() {
  // buttons on start page
  // ArrayList 0 : 1player button - if Clicked go to scene 2(1Player game scene)
  // ArrayList 1 : 2player button - if Clicked go to scene 3(2Player game scene)
  for (int i = 0; i < buttonArray.size(); i++) {
    Button is = buttonArray.get(i);
    if (is.button == is.on) {
      is.gameOn(i);
    }
  }
}