class Ball {
  float x, y;
  float xSpeed, ySpeed;
  float size;
  float accel;

  Ball() {
    x = width/2;
    y = random(10, height - 10);
    xSpeed = -2;
    ySpeed = 2;
    size = 10;
  }
  void move() {
    x += xSpeed;
    y += ySpeed;
  }
  void drawBall() {
    fill(255);
    ellipse(x, y, size, size);
  }
  void increaseBallSpeed() {
    xSpeed *= -1;
    if (scene == breakBricksGame) {
      accel = 0.05;
    } else {
      accel = 0.2;
    }
    if (xSpeed > 0) {
      xSpeed += accel;
    } else {
      xSpeed -= accel;
    }

    if (ySpeed >0) {
      ySpeed += accel;
    } else {
      ySpeed -= accel;
    }
  }
  void bounceBallX() {
    if (this.x > width - blockArray[0].w) {
      if (abs(this.y - blockArray[0].y) < blockArray[0].h/2) {
        increaseBallSpeed();
        //blockHit1.play();
        this.x =  width - blockArray[0].w;
      }
    }
    if (this.x < blockArray[1].w) {
      if (abs(this.y - blockArray[1].y) < blockArray[0].h/2) {
        increaseBallSpeed();
        //blockHit1.play();
        this.x = blockArray[1].w;
      }
    }
    if ((this.x > width) || (this.x < 0)) {
      //outSound.play();
      this.getScore();
      this.x = width/2;
      this.y = random(10, height - 10);
      this.ySpeed = 2;
      if (this.x > width) {
        this.xSpeed = 2;
        this.x = width;
      } else {
        this.xSpeed = -2;
        this.x = 0;
      }
    }
  }
  void bounceBallX_P1() {
    if (this.x > width - blockArray[0].w) {
      if (abs(this.y - blockArray[0].y) < blockArray[0].h/2) {
        increaseBallSpeed();
        //blockHit1.play();
        this.x = width - blockArray[0].w;
      }
    }
    if (this.x < 0) {
      increaseBallSpeed();
      //brickSoundPlay();
      this.x = 0;
    }
    if (this.x > width) {
      scoreArray[2].looseLife(); // 1player mode
      //outSound.play();
      this.x = width;
      this.y = random(10, height - 10);
      this.xSpeed = -2;
      this.ySpeed = 2;
    }
  }
  void bounceBallY() {
    if (y < 0 || y > height) {
      ySpeed *= -1;
      //blockHit2.play();
      if (y > height) {
        y = height;
      } else {
        y = 0;
      }
    }
  }


  void getScore() {
    if (this.x > width) {
      scoreArray[0].addScore();
    }
    if (this.x < 0) {
      scoreArray[1].addScore();
    }
  }
}