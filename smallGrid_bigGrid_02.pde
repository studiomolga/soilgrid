float sizeCell;
Cell[][] grid;


int cols = 3;
int rows = 3;

void setup() {
  size(150, 150);
  // size = width/8;
  sizeCell = (width-1)/3.0;
  noStroke();
  drawGrid();
}
 
void draw() {
  // do nothing
}
 

 
void mousePressed() {
  if (mouseButton == LEFT) {
    if (sizeCell < (width-1)/3.0) 
      sizeCell *= 2.0;
  } 
  else if (mouseButton == RIGHT) {
    if (sizeCell > 2) 
      sizeCell *= 0.5;
  }
  drawGrid();
}
 
void drawGrid() {
  for (float i = 0; i < width; i += sizeCell) {
    for (float j = 0; j < height; j += sizeCell) {
      stroke(120);
      strokeWeight(0.2);
      fill(255);
      rect(i, j, sizeCell, sizeCell);
    }
  }
}
