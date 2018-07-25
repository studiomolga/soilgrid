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

void mousePressed(){
  //press the mouse to change colors on random cells
  int randCellIndex = int(random(grid.getNumCells()));
  
  if(grid.getCellColor(randCellIndex) == color(255)) {
    grid.setCellColor(randCellIndex, color(0));
  } else {
    grid.setCellColor(randCellIndex, color(255));
  }
}