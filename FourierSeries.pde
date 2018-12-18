// Visualising the Fourier Series
// Something similar to this:
// https://bl.ocks.org/jinroh/7524988
// 
// Author: Kiet Tran
// Dec 17, 2018

color bgColor = #FFFFFF;
color mainWiperColor = #FF9393;
color wiper1Color = #FFFF93;
color wiper2Color = #93FF93;
color wiper3Color = #9393FF;
color lineColor = #FF1100;
color waveColor = #0000FF;

Wiper mainWiper, wiper1, wiper2, wiper3;

void setup() {
  size(800, 500);
  background(bgColor);
  
  float mainRadius = 100 * (4 / PI); // amplitude
  mainWiper = new Wiper(230, height/2, mainRadius, mainWiperColor);
  wiper1 = new Wiper(0, 0, mainRadius/3, wiper1Color);
  wiper2 = new Wiper(0, 0, mainRadius/5, wiper2Color);
  wiper3 = new Wiper(0, 0, mainRadius/7, wiper3Color);
}

float t = 0;
ArrayList<Float> waveY = new ArrayList<Float>();
int angleScale = 1;

void draw() {
  // TRAILING EFFECT
  noStroke();
  fill(bgColor, 50);
  rect(0, 0, width, height);
  
  angleScale = int(map(mouseY, 0, height, 1, 10));
  
  // Draw the wipers
  mainWiper.show(t * (1 + angleScale * 0));
  
  wiper1.setX(mainWiper.getBorderX());
  wiper1.setY(mainWiper.getBorderY());
  wiper1.show(t * (1 + angleScale * 1));
  
  wiper2.setX(wiper1.getBorderX());
  wiper2.setY(wiper1.getBorderY());
  wiper2.show(t * (1 + angleScale * 2));
  
  wiper3.setX(wiper2.getBorderX());
  wiper3.setY(wiper2.getBorderY());
  wiper3.show(t * (1 + angleScale * 3));
  
  // Draw a line from last wiper to wave
  stroke(lineColor);
  strokeWeight(2);
  fill(lineColor);
  line(wiper3.getBorderX(), wiper3.getBorderY(), width/2.5, wiper3.getBorderY());
  triangle(width/2.5, wiper3.getBorderY(), 
  width/2.5 - 15, wiper3.getBorderY() - 10, 
  width/2.5 - 15, wiper3.getBorderY() + 10);
  
  // Add the y position of the wiper line to the array of wave y's
  waveY.add(0, wiper3.getBorderY());
  
  // Draw the wave
  stroke(waveColor);
  strokeWeight(1);
  noFill();
  beginShape();
  for(int i = 0; i < waveY.size(); i++) {
    vertex(width/2.5 + i, waveY.get(i));
    if ((width/2.5 + i) > width) {waveY.remove(i);} // remove the vertex when it gets out of screen
  }
  endShape();
  
  t += 2e-4 * mouseX; // frequency
  
  drawText();
}

void drawText() {
  fill(0);
  textSize(20);
  textAlign(LEFT);
  text("4" + 
  " sin(" + (1 + angleScale * 3) + " theta)" +
  " / " + (1 + angleScale * 3) + " PI", 
  20, 30);
}
