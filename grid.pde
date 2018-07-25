// A Cell object
class Cell {
  // A cell object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
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


  void display() {
    stroke(255);
    // Color calculated using sine wave
    fill(255);
    rect(x,y,w,h); 
  }
  
    void displayek() {
    stroke(255);
    // Color calculated using sine wave
    fill(0);
    rect(x,y,w,h); 
  }
}
