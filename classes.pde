class Block {
  float x, y, w, h;
  float speed;
  color blockColor;
  
  Block() {
    h = 60;
    w = h/4;
    x = width - w/2;
    y = height/2;
    speed = 0;
    blockColor = white;
  }

  void move() {
    y += speed;
    y = constrain(y, h/2, height - h/2);
  }
  void colorChange(){
    if (abs(ballP1.x - (width - blockArray[0].w)) < 4) {
      if (abs(this.y - blockArray[0].y) < blockArray[0].h/2) {
       blockArray[0].blockColor = yellow;
      }
    } else {
      blockArray[0].blockColor = white;
    }
    
  }

  void drawBlock() {
    fill(blockColor);
    rectMode(CENTER);
    rect(x, y, w, h, 3, 0, 0, 3);
  }
}


class Score {
  //2 Player 
  int score;
  int winScore;
  int scoreX;
  int scoreY;
  int offset;

  //1 Player
  int lifeLeft;


  Score() {
    score = 0;
    winScore = 5;
    offset = width/4;
    scoreX = width/2 - offset;
    scoreY = height/2;
    lifeLeft = 5; // 1Player
  }

  // 1 Player winning system-------------------
  void looseLife() {
    lifeLeft--;
  }
  void displayLife() {
    fill(white);
    textAlign(CENTER);
    textFont(scoreFont);
    textSize(30);
    text("LIFE : "+ lifeLeft, width - 100, 30);
  }
  void playerWinScene() {
    fill(255);
    rect(width/2, height/2, width, height);
    fill(0);
    textSize(60);
    text("YOU ", width/2, height/2 - 30);
    text("WIN!", width/2, height/2 + 30);

    fill(170);
    textSize(30);
    text("press Enter", width/2, height - 20);
    scoreArray[2].score = lifeLeft;
    noLoop();
  }

  void playerLoseScene() {
    fill(0);
    rect(width/2, height/2, width, height);
    fill(255);
    textSize(60);
    text("LOSER!!", width/2, height/2);

    fill(170);
    textSize(30);
    text("press Enter", width/2, height - 20);
    scoreArray[2].score = lifeLeft;
    noLoop();
  }
  // 2 Player score system
  void addScore() {
    this.score ++;
  }
  void displayScore() {
    textAlign(CENTER);
    textFont(scoreFont);
    text(this.score, scoreX, scoreY);
  }
  void endScene() {

    fill(255);
    rect(scoreX, scoreY, width/2, height);
    fill(0);
    text("YOU ", scoreX, scoreY-30);
    text("WIN!", scoreX, scoreY+30);

    fill(0);
    rect(width - scoreX, height/2, width/2, height);
    fill(255);
    text("LOSER", width - scoreX, scoreY);

    fill(170);
    textSize(30);
    text("press Enter", width/2, height - 20);
    for (int i = 0; i < 2; i++) {
      scoreArray[i].score = 0;
    }
    noLoop();
  }
}

class Button {
  float x, y, w, h;
  String name;
  boolean button;
  boolean on, off;

  Button(float x, float y, int w, int h, String buttonName) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.name = buttonName;
    on = true;
    off = false;
  }

  void isRollover() {
    if ((abs(mouseX - x) < w/2) && (abs(mouseY - y) < h/2)) {
      button = on;
    } else {
      button = off;
    }
  }

  void display() {
    int rectCol;
    int textCol;
    if (button == on) {
      rectCol = 230;
      textCol = 0;
    } else {
      rectCol = 0;
      textCol = 255;
    }
    stroke(255);
    strokeWeight(2);
    fill(rectCol);
    rect(x, y - 5, w, h);
    fill(textCol);
    textSize(20);
    textAlign(CENTER);
    text(name, x, y);
  }

  void gameOn (int i) {
    scene = i + 2;
  }
}