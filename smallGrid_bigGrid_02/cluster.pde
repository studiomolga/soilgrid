class Cluster{
//Cluster represent a cluster of grids
  int x, y, w, h;
  int gridCols;
  int gridRows;
  int numGrids = 1;
  //int gridState = 0;
  Grid[] grids;
  int cols = 1;
  int rows = 1;
  
  Cluster(int x, int y, int w, int h, int gridCols, int gridRows){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.gridCols = gridCols;
    this.gridRows = gridRows;
    grids = new Grid[numGrids];
    for(int i = 0; i < grids.length; i++){
      int xGrid = ((i % cols) * w) + x;
      int yGrid = ((i / rows) * h) + y;
      Grid grid = new Grid(this.gridCols, this.gridRows, xGrid, yGrid, w, h);
      grids[i] = grid;
    }
  }
  
  int getNumGrids(){
    return numGrids;
  }
  
  void setGridState(int gridIndex, int state){
    grids[gridIndex].setGridState(state);
  }
  
  void randomize(){
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
  
  void draw(){
    for(int i = 0; i < grids.length; i++){
      grids[i].draw();
    }
  }
}