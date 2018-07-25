float sizeCell;
int cols = 3;
int rows = 3;

Grid grid;

void setup() {
  size(150, 150);
  grid = new Grid(cols, rows);
}

void draw() {
  background(255);
  grid.draw();
}