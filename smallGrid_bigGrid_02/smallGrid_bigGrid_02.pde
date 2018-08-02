import processing.awt.PSurfaceAWT;
import processing.awt.PSurfaceAWT.SmoothCanvas;

int cols = 4;
int rows = 1;

static final int DATA_PERIOD = 100;
static final int SIZE_PERIOD = 4000;
static final int GRID_COLS = 3;
static final int GRID_ROWS = 3;
static final int MAX_SIZE_CHANGES = 6;

//use sizes: 128, 256, 512, 1024, 2048, etc
//apparently processing will not go smaller then 100 by 100 pixels so 128 is the minimum
static final int CLUSTER_HEIGHT = 256;
final int NUM_CLUSTERS = cols * rows;

Cluster[] clusters;
DataParser dataParser;
SoundEngine soundEngine;

int gridState = 0;
int dataPeriodStart = 0;
int sizePeriodStart = 0;
int numSizeChanges = 0;

void settings(){
  size(CLUSTER_HEIGHT * cols, CLUSTER_HEIGHT * rows);
}

void setup() {
  dataParser = new DataParser(sketchPath()+"/data/datafiles", NUM_CLUSTERS);

  clusters = new Cluster[NUM_CLUSTERS];
  int y = 0;
  for(int i = 0; i < clusters.length; i++){
    int xCluster = (i % cols) * CLUSTER_HEIGHT;
    int yCluster = y * CLUSTER_HEIGHT;
    Cluster cluster = new Cluster(this, xCluster, yCluster, CLUSTER_HEIGHT, CLUSTER_HEIGHT, GRID_COLS, GRID_ROWS);
    clusters[i] = cluster;
    if(i % cols == cols - 1) y += 1;
  }
  
  dataPeriodStart = millis();
  sizePeriodStart = millis();
}

PSurface initSurface() {
  PSurface pSurface = super.initSurface();
  ( (SmoothCanvas) ((PSurfaceAWT)surface).getNative()).getFrame().setUndecorated(true);
  return pSurface;
}

void draw() {
  background(255);
  
  for(int i = 0; i < clusters.length; i++){
    clusters[i].draw();
  }
  
  if(millis() - dataPeriodStart >= DATA_PERIOD){
    for(int i = 0; i < clusters.length; i++){
      float[] values = dataParser.getNextValues(i, clusters[i].getNumGrids());
      clusters[i].setGridStates(values);
      dataPeriodStart = millis();
    }
  }
  
  if(millis() - sizePeriodStart >= SIZE_PERIOD && numSizeChanges < MAX_SIZE_CHANGES){
    for(int i = 0; i < clusters.length; i++){
      clusters[i].expandGrid();
    }
    sizePeriodStart = millis();
    numSizeChanges += 1;
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
  } else if(key == 'z'){          //TODO: remove this, just here for testing purposes
    for(int i = 0; i < clusters.length; i++){
      int soundIndex = int(random(clusters[i].soundEngine.getNumFiles()));
      clusters[i].soundEngine.play(soundIndex);
    }
  }
}