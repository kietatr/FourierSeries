// Visualising the Fourier Series
// Something similar to this:
// https://bl.ocks.org/jinroh/7524988
// 
// Author: Kiet Tran
// Dec 17, 2018

color bgColor = #000000;
color mainWiperColor = #2EC4B6;
color wiper1Color = #E71D36;
color wiper2Color = #FF9F1C;
color wiper3Color = #2EC4B6;
color lineColor = #E71D36;
color waveColor = #E71D36;

Wiper mainWiper, wiper1, wiper2, wiper3;

void setup() {
  size(1000, 500);
  background(bgColor);
  
  float mainRadius = 120; // amplitude
  mainWiper = new Wiper(150, height/2, mainRadius, mainWiperColor);
  wiper1 = new Wiper(0, 0, mainRadius/2, wiper1Color);
  wiper2 = new Wiper(0, 0, mainRadius/4, wiper2Color);
  wiper3 = new Wiper(0, 0, mainRadius/8, wiper3Color);
}

float t = 0;
ArrayList<Float> waveY = new ArrayList<Float>();

void draw() {
  // TRAILING EFFECT
  noStroke();
  fill(bgColor, 50);
  rect(0, 0, width, height);
  
  // Draw the wipers
  mainWiper.show(t * mouseY * 0.002);
  
  wiper1.setX(mainWiper.getBorderX());
  wiper1.setY(mainWiper.getBorderY());
  wiper1.show(t * 2); // amplitude?
  
  wiper2.setX(wiper1.getBorderX());
  wiper2.setY(wiper1.getBorderY());
  wiper2.show(t * 3); // amplitude?
  
  wiper3.setX(wiper2.getBorderX());
  wiper3.setY(wiper2.getBorderY());
  wiper3.show(t * 4); // amplitude?
  
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
  strokeWeight(3);
  fill(wiper1Color, 10);
  beginShape();
  for(int i = 0; i < waveY.size(); i++) {
    vertex(width/2.5 + i, waveY.get(i));
    if ((width/2.5 + i) > width) {waveY.remove(i);} // remove the vertex when it gets out of screen
  }
  endShape();
  
  t += 2e-4 * mouseX; // frequency
}
