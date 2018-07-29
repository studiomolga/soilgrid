class Grid{
  //class that represents a grid
  int cols, rows, x, y, w, h;
  Cell[] cells;
  
  Grid(int cols, int rows, int x, int y, int w, int h){
    this.cols = cols;
    this.rows = rows;
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    
    cells = new Cell[this.cols * this.rows];
    for(int i = 0; i < cells.length; i++){
      int xCell = i % cols;
      int yCell = i / cols;
      Cell cell = new Cell(xCell, yCell, i, color(255));
      cells[i] = cell;
    }
    
    setGridState(0);
  }
  
  void setCellColor(int cellIndex, color clr){
    cells[cellIndex].setColor(clr);
  }
  
  color getCellColor(int cellIndex){
    return cells[cellIndex].getColor();
  }
  
  void setGridSize(int w, int h){
    this.w = w;
    this.h = h;
    print("new grid size: ");
    print(w);
    print(", ");
    println(h);
  }
  
  void setGridPos(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  int getNumCells(){
    return cells.length;
  }
  
  void randomize(){
    int randCellIndex = int(random(getNumCells()));
      
      if(getCellColor(randCellIndex) == color(255)) {
        setCellColor(randCellIndex, color(0));
      } else {
        setCellColor(randCellIndex, color(255));
      }
  }
  
  void setGridState(int state){
    String binaryString = binary(state, cells.length);
    char[] binaryChars = binaryString.toCharArray();
    for(int i = 0; i < binaryChars.length; i++){
      if(binaryChars[i] == '0'){
        cells[abs(binaryChars.length - i) - 1].setColor(color(255));
      } else {
        cells[abs(binaryChars.length - i) - 1].setColor(color(0));
      }
    }
  }
  
  void draw(){
    for(int i = 0; i < cells.length; i++){
      Cell cell = cells[i];
      Coordinate coord = cell.getCoordinate();
      
      float cellWidth = (float)w / (float)cols;
      float cellHeight = (float)h / (float)rows;
      float xCell = ((float)coord.x * cellWidth) + (float)x;
      float yCell = ((float)coord.y * cellHeight) + (float)y;
      
      noStroke();
      fill(cell.getColor());
      rect(xCell, yCell, ceil(cellWidth), ceil(cellHeight));
    }
  }
}