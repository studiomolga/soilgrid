
class Cell {
  float x,y;   // x,y location
  float w,h;   // width and height
  float angle; // angle for oscillating brightness

  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
  } 


  void display(float posx, float posy, float d, int colors) {
    strokeWeight(0.1);
    stroke(120);
    fill(colors);
    rect(posx,posy,d,d); 
  }
  
    void displayek() {
    strokeWeight(0.1);
    stroke(120);
    fill(0);
    rect(x,y,w,h); 
  }
}
