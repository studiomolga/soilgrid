class Grid{
  int cols;
  int rows;
  Coordinate pos;
  int cellSize;
  int currState;
  Cell cells[];
  
  Grid(int cols, int rows, Coordinate pos, int cellSize){
    this.cols = cols;
    this.rows = rows;
    this.pos = pos;
    this.cellSize = cellSize;
    
    //init cells
    cells = new Cell[cols * rows];
    for(int i = 0; i < cells.length; i++){
      Coordinate cellPos = new Coordinate((int) i % cols, (int) i / cols);
      Cell cell = new Cell(cellPos, i, color(255));
      cells[i] = cell;
    }
    
    currState = -1;
    setGridState(0);
  }
  
  void setCellSize(int size){
    cellSize = size;
  }
  
  void setPos(Coordinate pos){
    this.pos = pos;
  }
  
  void randomize(){
    for(Cell cell : cells){
      int randClr = ((int) random(2)) * 255;
      cell.setColor(color(randClr));
    }
  }
  
  void setGridState(int state) {
    if(state != currState){
      currState = state;
      String binaryString = binary(currState, cells.length);
      char[] binaryChars = binaryString.toCharArray();
      for (int i = 0; i < binaryChars.length; i++) {
        if (binaryChars[i] == '0') {
          cells[abs(binaryChars.length - i) - 1].setColor(color(255));
        } else {
          cells[abs(binaryChars.length - i) - 1].setColor(color(0));
        }
      }
    }
  }
  
  void display(float noisePerc){
    for(int i = 0; i < cells.length; i++){
      Coordinate normCellPos = cells[i].getPos();
      Coordinate cellPos = normCellPos.multiply(cellSize);
      color cellClr = cells[i].getColor();
      
      for(int y = cellPos.y; y < (cellPos.y + cellSize); y++){
        for(int x = cellPos.x; x < (cellPos.x + cellSize); x++){
          if(random(100) < noisePerc){
            int randomClr = ((int) random(2)) * 255;
            set(x + pos.x, y + pos.y, color(randomClr));
          } else {
            set(x + pos.x, y + pos.y, cellClr);
          }
        }
      }
    }
  }
}
