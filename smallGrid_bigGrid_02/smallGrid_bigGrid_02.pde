int cols = 4;
int rows = 1;

static final int GRID_COLS = 3;
static final int GRID_ROWS = 3;
static final int CLUSTER_HEIGHT = 256;
final int NUM_CLUSTERS = cols * rows;

Cluster[] clusters;

int gridState = 0;

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

void mousePressed(){
  //press the mouse to change colors on random cells
  for(int i = 0; i < clusters.length; i++){
    clusters[i].randomize();
  }  
}

void keyPressed(){
  if(key == 'a'){
    for(int i = 0; i < clusters.length; i++){
      clusters[i].expandGrid();
    }
  }
  else if(key == 'q'){
    gridState += 1;
    gridState %= 512;
    for(int i = 0; i < clusters.length; i++){
      for(int j = 0; j < clusters[i].getNumGrids(); j++){
        clusters[i].setGridState(j, gridState);
      }
    }
  }
}