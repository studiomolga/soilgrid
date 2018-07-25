float sizeCell;
int cols = 3;
int rows = 3;

void setup() {
  size(150, 150);

  //grid = new Cell[cols][rows];
  //// size = width/8;
  //sizeCell = (width-1)/3.0;
  //for (int i = 0; i < cols; i++) {
  //  for (int j = 0; j < rows; j++) {
  //    // Initialize each object
  //    grid[i][j] = new Cell(i*sizeCell, j*sizeCell, sizeCell, sizeCell);
  //  }
  //}

  //noStroke();
  //drawGrid();
}

void draw() {
  //  for (int i = 0; i < cols; i++) {
  //  for (int j = 0; j < rows; j++) {
  //    grid[i][j].display(i*sizeCell, j*sizeCell, sizeCell);
  //    //grid[1][0].displayek();
  //  }
  //}
}



//void mousePressed() {
//  if (mouseButton == LEFT) {
//    if (sizeCell < (width-1)/3.0) 
//      sizeCell *= 2.0;
//  } else if (mouseButton == RIGHT) {
//    if (sizeCell > 2) 
//      sizeCell *= 0.5;
//  }
//  drawGrid();
//}


//void drawGrid() {

//  for (int n = 0; n < cols; n++) {
//    for (int m = 0; m < rows; m++) {

//      for (int i = 0; i < width; i += sizeCell) {
//        for (int j = 0; j < height; j += sizeCell) {

//          grid[n][m].display(i, j, sizeCell, 255); // HERE MUST BE A GRID
//          grid[n][m].display(sizeCell*2, sizeCell, sizeCell, 0);
//          grid[n][m].display(sizeCell*0, sizeCell*2, sizeCell, 0);
//        }
//      }
//    }
//  }
//}