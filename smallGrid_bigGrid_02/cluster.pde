import papaya.*;

class Cluster{
  Coordinate pos;
  int gridCols;
  int gridRows;
  int clusterCols;
  int clusterRows;
  int maxCellSize;
  int numGrids;
  int sizeChanges;
  float noisePerc;
  
  Grid grids[];
  
  Cluster(Coordinate pos, int gridCols, int gridRows, int maxCellSize, int sizeChanges){
    this.pos = pos;
    this.gridCols = gridCols;
    this.gridRows = gridRows;
    this.maxCellSize = maxCellSize;
    clusterCols = 1;
    clusterRows = 1;
    numGrids = 1;
    this.sizeChanges = sizeChanges;
    noisePerc = 0;
    
    grids = new Grid[numGrids];
    for(int i = 0; i < grids.length; i++){
      int gridWidth = maxCellSize * gridCols;
      int gridHeight = maxCellSize * gridRows;
      int xGrid = ((i % clusterCols) * gridWidth) + pos.x;
      int yGrid = ((i / clusterRows) * gridHeight) + pos.y;
      Grid grid = new Grid(gridCols, gridRows, new Coordinate(xGrid, yGrid), maxCellSize);
      grids[i] = grid;
    }
  }
  
  int getNumGrids() {
    return numGrids;
  }
  
  void setGridStates(float[] states) {
    for (int i = 0; i < states.length; i++) {
      float value = (states[i] / 100.0) * 512;
      setGridState(i, (int) value);
    }
    float soundIndex = round((Descriptive.mean(states) / 100.0f) * (float) soundEngine.getNumFiles());
    soundEngine.play((int) soundIndex);
    //println((int) soundIndex);
  }
  
  void setGridState(int gridIndex, int state) {
    grids[gridIndex].setGridState(state);
  }
  
  void randomize() {
    for (int i = 0; i < grids.length; i++) {
      grids[i].randomize();
    }
  }
  
  void increaseGrids(){
    if(sizeChanges > 1){
      sizeChanges -= 1;
      maxCellSize = (int) pow(2, sizeChanges);
      numGrids *= 4;
      clusterCols *= 2;
      clusterRows *= 2;
      addGrids(numGrids);
    } else {
      sizeChanges = 1;
    }
  }

  void addGrids(int amount){
    int gridWidth = maxCellSize * gridCols;
    int gridHeight = maxCellSize * gridRows;
    
    for (int i = 0; i < grids.length; i++) {
      int xGrid = ((i % clusterCols) * gridWidth) + pos.x;
      int yGrid = ((i / clusterRows) * gridHeight) + pos.y;
      grids[i].setCellSize(maxCellSize);
      grids[i].setPos(new Coordinate(xGrid, yGrid));
    }
    
    for (int i = grids.length; i < amount; i++) {
      int xGrid = ((i % clusterCols) * gridWidth) + pos.x;
      int yGrid = ((i / clusterRows) * gridHeight) + pos.y;
      Grid grid = new Grid(gridCols, gridRows, new Coordinate(xGrid, yGrid), maxCellSize);
      grids = (Grid[]) append(grids, grid);
    }
  }
  
  void setNoisePerc(float noisePerc){
    this.noisePerc = noisePerc;
  }
  
  void display(){
    for(Grid grid : grids){
      grid.display(noisePerc);
    }
  }
}
