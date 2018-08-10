import processing.awt.PSurfaceAWT;
import processing.awt.PSurfaceAWT.SmoothCanvas;

int cols = 4;
int rows = 1;

static final int DATA_PERIOD = 100;
static final int SIZE_PERIOD = 4000;
static final int GRID_COLS = 3;
static final int GRID_ROWS = 3;
static final int MAX_SIZE_CHANGES = 6;
static final int SOUND_ENGINE_VOICES = 128;

//use sizes: 128, 256, 512, 1024, 2048, etc
//apparently processing will not go smaller then 100 by 100 pixels so 128 is the minimum
static final int CLUSTER_HEIGHT = 256;
final int NUM_CLUSTERS = cols * rows;

Cluster[] clusters;
DataParser dataParser;
SoundEngine soundEngine;

//we make a soundengine instance here, use MAX_SIZE_CHANGES to dertermine how many voices the Sampler instances should use
//maximum number voices is (4^MAX_SIZE_CHANGE) * NUM_CLUSTERS = 16384
//that number is very big, probably too big, so we will have to use a fraction of it maybe simply 1/4 or the size of one single cluster
//what this will mean for the volume is a bigger mystery, we have to use 1/4096 in the multiplier at the end

int gridState = 0;
int dataPeriodStart = 0;
int sizePeriodStart = 0;
int numSizeChanges = 0;

void settings() {
  size(CLUSTER_HEIGHT * cols, CLUSTER_HEIGHT * rows);
}

void setup() {
  dataParser = new DataParser(sketchPath()+"/data/datafiles", NUM_CLUSTERS);
  clusters = new Cluster[NUM_CLUSTERS];
  //the voices will have to be fixed, it means that maybe not all grids will be playing audio but the feeling will remain the same
  soundEngine = new SoundEngine(this, sketchPath()+"/data/sounds", SOUND_ENGINE_VOICES); 
  float amplitude = 1.0f / 24.0f;
  soundEngine.setAmplitude(amplitude);
  
  int y = 0;
  for (int i = 0; i < clusters.length; i++) {
    int xCluster = (i % cols) * CLUSTER_HEIGHT;
    int yCluster = y * CLUSTER_HEIGHT;
    Cluster cluster = new Cluster(xCluster, yCluster, CLUSTER_HEIGHT, CLUSTER_HEIGHT, GRID_COLS, GRID_ROWS, soundEngine);
    clusters[i] = cluster;
    if (i % cols == cols - 1) y += 1;
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

  for (int i = 0; i < clusters.length; i++) {
    clusters[i].draw();
  }

  if (millis() - dataPeriodStart >= DATA_PERIOD) {
    for (int i = 0; i < clusters.length; i++) {
      float[] values = dataParser.getNextValues(i, clusters[i].getNumGrids());
      clusters[i].setGridStates(values);
      dataPeriodStart = millis();
    }
  }

  if (millis() - sizePeriodStart >= SIZE_PERIOD && numSizeChanges < MAX_SIZE_CHANGES) {
    for (int i = 0; i < clusters.length; i++) {
      clusters[i].expandGrid();
      //here we should determine the new volume for each sample in the sound engine with 1.0 / maximum_voices
    }
    //float amplitude = pow(4, -numSizeChanges);
    //soundEngine.setAmplitude(0.3f);
    sizePeriodStart = millis();
    numSizeChanges += 1;
  } else if (millis() - sizePeriodStart >= SIZE_PERIOD && numSizeChanges >= MAX_SIZE_CHANGES) {
    //TODO: put something here that properly closes the soundengine!!
    exit();
  }
}

void mousePressed() {
  //press the mouse to change colors on random cells
  for (int i = 0; i < clusters.length; i++) {
    clusters[i].randomize();
  }
}

void keyPressed() {
  if (key == 'a') {
    for (int i = 0; i < clusters.length; i++) {
      clusters[i].expandGrid();
    }
  } else if (key == 'q') {
    gridState += 1;
    gridState %= 512;
    for (int i = 0; i < clusters.length; i++) {
      for (int j = 0; j < clusters[i].getNumGrids(); j++) {
        clusters[i].setGridState(j, gridState);
      }
    }
  }
}