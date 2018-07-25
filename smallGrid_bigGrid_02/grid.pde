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
  }
  
  void setGridPos(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  int getNumCells(){
    return cells.length;
  }
  
  void draw(){
    for(int i = 0; i < cells.length; i++){
      Cell cell = cells[i];
      Coordinate coord = cell.getCoordinate();
      
      int cellWidth = w / cols;
      int cellHeight = h / rows;
      
      stroke(127);
      fill(cell.getColor());
      rect((coord.x * cellWidth) + x, (coord.y * cellHeight) + y, cellWidth, cellHeight);
    }
  }
}