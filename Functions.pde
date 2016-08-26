void createBricks() {
  for (int i = 0; i < brickHorizontalNum; i++) {
    for (int j = 0; j < brickVerticalNum; j++)
      brickArray.add(new Brick(i*brickDistHorizontal, j*brickDistVertical));
  }
}

void drawBackground() {
  rectMode(CENTER);
  background(0);
  strokeWeight(3);
  stroke(255);
  noFill();
  rect(width/4, height/2, width/2, height);
  rect(width*3/4, height/2, width/2, height);
  strokeWeight(1);
  rect(width/2, height/2, width*0.7, height*0.6);
}

void winGame2() {
  for (int i = 0; i <2; i++) {
    if (scoreArray[i].score == winScore) {
      scoreArray[i].endScene();
    }
  }
}

void winGame1() {
  if (brickArray.size() <= 0) {
    createBricks();
    scoreArray[2].playerWinScene();
  }
  if (scoreArray[2].lifeLeft == 0) { // No life left
    createBricks();
    scoreArray[2].playerLoseScene();
  }
}