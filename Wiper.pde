// Author: Kiet Tran
// Dec 17, 2018

class Wiper {
  // Private vars
  float x, y, radius;
  float borderX, borderY;
  int lineColor;
  
  // Constructor
  Wiper(float x, float y, float radius, int lineColor) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.lineColor = lineColor;
  }
  
  void setX(float x) {this.x = x;}
  void setY(float y) {this.y = y;}
  float getBorderX() {return this.borderX;}
  float getBorderY() {return this.borderY;}
  
  // Draw the Wiper
  void show(float t) {
    float borderX = this.x + this.radius * cos(t);
    float borderY = this.y + this.radius * sin(t);
    
    // Draw a line from center to border
    stroke(lineColor);
    strokeWeight(2);
    line(this.x, this.y, borderX, borderY);
    
    // Draw the radius of the Wiper
    fill(lineColor, 10);
    strokeWeight(4);
    ellipse(this.x, this.y, this.radius*2, this.radius*2);
    
    // Set this border X,Y for other Wipers to use
    this.borderX = borderX;
    this.borderY = borderY;
  }
}
