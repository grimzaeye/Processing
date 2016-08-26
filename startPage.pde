void startDisplay() {
  fill(0);
  rect(width/2, height/2, width, height);
  float p1X = width*0.2;
  float p2X = width*0.8;
  textAlign(CENTER);
  textFont(scoreFont);
  fill(255);
  //Title
  textSize(50);
  text("Ssem's Pong Game", width/2, 60);
  //Player1 - left Side
  textSize(30);
  text("Player 1", p1X, height/2-60);
  textSize(20);
  text("W : Move UP", p1X, height/2-20);
  text("S : Move DOWN", p1X, height/2);
  
  //Player2 - right Side
  textSize(30);
  text("Player 2", p2X, height/2 - 60);
  textSize(20);
  text("UP : Move UP", p2X, height/2-20);
  text("DOWN : Move DOWN", p2X, height/2);
  
  text("Click Game Mode", width/2, height - 30);
  for(int i = 0; i < 2; i++) {
    Button temp = buttonArray.get(i);
    temp.isRollover();
    temp.display();
  }
}