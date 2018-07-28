int GRID_COLS = 3;
int GRID_ROWS = 3;
int cols = 4;
int rows = 1;
int CLUSTER_HEIGHT = 256;
int NUM_CLUSTERS = cols * rows;

int gridState = 0;
Cluster[] clusters;

void settings(){
  size(CLUSTER_HEIGHT * cols, CLUSTER_HEIGHT * rows);
}

void setup() {
  clusters = new Cluster[NUM_CLUSTERS];
  int y = 0;
  for(int i = 0; i < clusters.length; i++){
    int xCluster = (i % cols) * CLUSTER_HEIGHT;
    int yCluster = y * CLUSTER_HEIGHT;
    Cluster cluster = new Cluster(xCluster, yCluster, CLUSTER_HEIGHT, CLUSTER_HEIGHT, GRID_COLS, GRID_ROWS);
    clusters[i] = cluster;
    if(i % cols == cols - 1) y += 1;
  }
}

void draw() {
  background(255);
  for(int i = 0; i < clusters.length; i++){
    clusters[i].draw();
  }
}

//void addGrids(int amount){
//  for(int i = 0; i < grids.length; i++){
//    int x = (i % cols) * gridWidth;
//    int y = (i / rows) * gridHeight;
//    grids[i].setGridSize(gridWidth, gridHeight);
//    grids[i].setGridPos(x, y);
//  }
    
//  for(int i = grids.length; i < amount; i++){
//    int x = (i % cols) * gridWidth;
//    int y = (i / rows) * gridHeight;
//    Grid grid = new Grid(gridCols, gridRows, x, y, gridWidth, gridHeight);
//    grid.setGridState(gridState);
//    grids = (Grid[]) append(grids, grid);
    
//  }
//}

void mousePressed(){
  ////press the mouse to change colors on random cells
  for(int i = 0; i < clusters.length; i++){
    clusters[i].randomize();
  }  
}

void keyPressed(){
  if(key == 'q'){
    gridState += 1;
    gridState %= 512;
    for(int i = 0; i < clusters.length; i++){
      for(int j = 0; j < clusters[i].getNumGrids(); j++){
        clusters[i].setGridState(j, gridState);
      }
    }
  }
  
  //if(key == 'a'){
  //  gridWidth /= 2;
  //  gridHeight /= 2;
  //  numGrids *= 4;
  //  cols *= 2;
  //  rows *= 2;
  //  addGrids(numGrids);
  //} else if (key == 'q'){
  //  gridState += 1;
  //  gridState %= 512;
  //  for(int i = 0; i < grids.length; i++){
  //    grids[i].setGridState(gridState);
  //  }
  //}
}