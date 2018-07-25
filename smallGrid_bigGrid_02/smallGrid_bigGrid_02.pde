float sizeCell;
int gridCols = 3;
int gridRows = 3;
int numGrids = 1;
int gridWidth;
int gridHeight;
int cols = 1;
int rows = 1;

Grid[] grids;

void setup() {
  size(1024, 1024);
  gridWidth = width;
  gridHeight = height;
  grids = new Grid[numGrids];
  for(int i = 0; i < grids.length; i++){
    int x = (i % cols) * gridWidth;
    int y = (i / rows) * gridHeight;
    Grid grid = new Grid(gridCols, gridRows, x, y, gridWidth, gridHeight);
    grids[i] = grid;
  }
}

void draw() {
  background(255);
  for(int i = 0; i < grids.length; i++){
    grids[i].draw();
  }
}

void addGrids(int amount){
  for(int i = 0; i < grids.length; i++){
      int x = (i % cols) * gridWidth;
      int y = (i / rows) * gridHeight;
      grids[i].setGridSize(gridWidth, gridHeight);
      grids[i].setGridPos(x, y);
  }
    
  for(int i = grids.length; i < amount; i++){
    int x = (i % cols) * gridWidth;
    int y = (i / rows) * gridHeight;
    Grid grid = new Grid(gridCols, gridRows, x, y, gridWidth, gridHeight);
    grids = (Grid[]) append(grids, grid);
  }
}

void mousePressed(){
  //press the mouse to change colors on random cells
  for(int i = 0; i < grids.length; i++){
    Grid grid = grids[i];
    int randCellIndex = int(random(grid.getNumCells()));
    
    if(grid.getCellColor(randCellIndex) == color(255)) {
      grid.setCellColor(randCellIndex, color(0));
    } else {
      grid.setCellColor(randCellIndex, color(255));
    }
  }
  
}

void keyPressed(){
  if(key == 'a'){
    gridWidth /= 2;
    gridHeight /= 2;
    numGrids *= 4;
    cols *= 2;
    rows *= 2;
    addGrids(numGrids);
  }
}