class Brick {
  float x, y;
  color brickColor;
  boolean isCrushedX, isCrushedY;

  Brick(float x, float y) {
    this.x = x;
    this.y = y;
    w = 30;
    h = 65;
    isCrushedX = false;
    isCrushedY = false;
    brickColor = color(x, 255, 255);
  }


  void display() {
    rectMode(CORNER);
    fill(brickColor);
    noStroke();
    rect(x, y, w, h, 3);
  }
  void removeBrick(int i) {
    if (this.isCrushedX || this.isCrushedY) {
      brickArray.remove(i);
    }
  }

  void crushed() {
    float centerX = (this.x + w/2);
    float centerY = (this.y + h/2);
    if ((abs(ballP1.y - centerY) < h/2)) {
      if (abs(ballP1.x - centerX) < w/2) {
        isCrushedX = true;
      } else {
        isCrushedX = false;
      }
    }
    if ((abs(ballP1.x - centerX) < w/2)) {
      if (abs(ballP1.y - centerY) == h/2) {
        isCrushedY = true;
      } else {
        isCrushedY = false;
      }
    }
  }
  void bounceBrick() {
    if (this.isCrushedY ) {
      ballP1.ySpeed *= -1;
      //brickSoundPlay();
    }
    if (this.isCrushedX ) {
      ballP1.increaseBallSpeed();
      //brickSoundPlay();
    }
  }
}