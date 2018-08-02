class Cluster{
//Cluster represent a cluster of grids
  int x, y, w, h;
  int gridCols, gridRows;
  int gridWidth, gridHeight;
  int numGrids = 1;
  Grid[] grids;
  int cols = 1;
  int rows = 1;
  SoundEngine soundEngine;
  
  Cluster(PApplet parent, int x, int y, int w, int h, int gridCols, int gridRows){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    gridWidth = w;
    gridHeight = h;
    this.gridCols = gridCols;
    this.gridRows = gridRows;
    
    soundEngine = new SoundEngine(parent, sketchPath()+"/data/sounds");
    
    grids = new Grid[numGrids];
    for(int i = 0; i < grids.length; i++){
      int xGrid = ((i % cols) * gridWidth) + x;
      int yGrid = ((i / rows) * gridHeight) + y;
      Grid grid = new Grid(this.gridCols, this.gridRows, xGrid, yGrid, gridWidth, gridHeight);
      grids[i] = grid;
    }
  }
  
  int getNumGrids(){
    return numGrids;
  }
  
  void setGridStates(float[] states){
    for(int i = 0; i < states.length; i++){
      float value = (states[i] / 100.0) * 512;
      setGridState(i, (int) value);
      if(i == 0){
        float soundIndex = (states[i] / 100.0) * (float) soundEngine.getNumFiles();
        soundEngine.play((int) soundIndex);
      }
    }
  }
  
  void setGridState(int gridIndex, int state){
    grids[gridIndex].setGridState(state);
  }
  
  void randomize(){
    for(int i = 0; i < grids.length; i++){
      grids[i].randomize();
    }
  }
  
  void expandGrid(){
    gridWidth /= 2;
    gridHeight /= 2;
    numGrids *= 4;
    cols *= 2;
    rows *= 2;
    addGrids(numGrids);
  }
  
  void addGrids(int amount){
    for(int i = 0; i < grids.length; i++){
      int xGrid = ((i % cols) * gridWidth) + x;
      int yGrid = ((i / rows) * gridHeight) + y;
      grids[i].setGridSize(gridWidth, gridHeight);
      grids[i].setGridPos(xGrid, yGrid);
    }
      
    for(int i = grids.length; i < amount; i++){
      int xGrid = ((i % cols) * gridWidth) + x;
      int yGrid = ((i / rows) * gridHeight) + y;
      Grid grid = new Grid(gridCols, gridRows, xGrid, yGrid, gridWidth, gridHeight);
      grids = (Grid[]) append(grids, grid);
      
    }
  }
  
  void draw(){
    for(int i = 0; i < grids.length; i++){
      grids[i].draw();
    }
  }
}