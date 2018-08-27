import processing.awt.PSurfaceAWT;
import processing.awt.PSurfaceAWT.SmoothCanvas;

static final int BG_COLOR = 255;
static final int MAX_SIZE_CHANGES = 7;
static final int GRID_COLS = 3;
static final int GRID_ROWS = 3;
static final float DATA_PERIOD = 1000;
static final int SIZE_PERIOD = 10;
static final int COLS = 4;
static final int ROWS = 1;
static final float NOISE_SPEED = 0.1f;
final int NUM_CLUSTERS = COLS * ROWS;
final int MAX_CELL_SIZE = (int) pow(2, MAX_SIZE_CHANGES);
final Coordinate MAX_GRID_SIZE = new Coordinate(MAX_CELL_SIZE * GRID_COLS, MAX_CELL_SIZE * GRID_ROWS); 
final int SOUND_ENGINE_VOICES = NUM_CLUSTERS * 4;

float dataPeriodStart;
int numDataChanges = 0;
int numSizeChanges = 0;
int soundLibIndex = 0;
float noisePerc = 0.0f;

Cluster clusters[];
DataParser dataParser;
SoundEngine soundEngine;

PSurface initSurface() {
  PSurface pSurface = super.initSurface();
  ( (SmoothCanvas) ((PSurfaceAWT)surface).getNative()).getFrame().setUndecorated(true);
  return pSurface;
}

void settings(){
  dataParser = new DataParser(sketchPath()+"/data/datafiles", NUM_CLUSTERS);
  soundEngine = new SoundEngine(this, sketchPath()+"/data/sounds", SOUND_ENGINE_VOICES, NUM_CLUSTERS); 
  size(MAX_GRID_SIZE.x * COLS, MAX_GRID_SIZE.y * ROWS);
}

void setup(){
  clusters = new Cluster[NUM_CLUSTERS];
  int y = 0;
  for(int i = 0; i < clusters.length; i++){
    int xCluster = i * MAX_GRID_SIZE.x;
    int yCluster = y * MAX_GRID_SIZE.y;
    Cluster cluster = new Cluster(new Coordinate(xCluster, yCluster), GRID_COLS, GRID_ROWS, MAX_CELL_SIZE, MAX_SIZE_CHANGES);
    clusters[i] = cluster;
    if (i % COLS == COLS - 1) y += 1;
  }
  dataPeriodStart = millis();
}

void draw(){
  background(BG_COLOR);
  
  if(millis() - dataPeriodStart >= DATA_PERIOD){
    numDataChanges += 1;
    
    if(numDataChanges % SIZE_PERIOD == 0 && numSizeChanges < (MAX_SIZE_CHANGES - 1)){
      for(Cluster cluster : clusters){
        cluster.increaseGrids();
      }
      if(numSizeChanges % (ceil((float) (MAX_SIZE_CHANGES - 1) / (float)soundEngine.getNumLibraries())) == 0 && numSizeChanges != 0){
        soundLibIndex += 1;
        soundEngine.setLibrary(soundLibIndex);
      }
      numSizeChanges += 1;
    } 
    
    for(int i = 0; i < clusters.length; i++){
      float[] values = dataParser.getNextValues(i, clusters[i].getNumGrids());
      clusters[i].setGridStates(values);
    }
    dataPeriodStart = millis();
  }
  
  if(numSizeChanges == MAX_SIZE_CHANGES - 1){
    noisePerc += NOISE_SPEED;
    for(Cluster cluster : clusters){
      cluster.setNoisePerc(noisePerc);
    }
  }

  for(Cluster cluster : clusters){
    cluster.display();
  }
  
  if(noisePerc >= 100.0f) exit();
}
