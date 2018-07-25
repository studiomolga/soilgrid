class Grid{
  int cols, rows;
  Cell[] cells;
  
  Grid(int cols, int rows){
    this.cols = cols;
    this.rows = rows;
    
    cells = new Cell[this.cols * this.rows];
    for(int i = 0; i < cells.length; i++){
      int x = i % cols;
      int y = i / cols;
      Cell cell = new Cell(x, y, i, color(255));
      cells[i] = cell;
    }
  }
  
  void setCellColor(int cellIndex, color clr){
    cells[cellIndex].setColor(clr);
  }
  
  color getCellColor(int cellIndex){
    return cells[cellIndex].getColor();
  }
  
  int getNumCells(){
    return cols * rows;
  }
  
  void draw(){
    for(int i = 0; i < cells.length; i++){
      Cell cell = cells[i];
      Coordinate coord = cell.getCoordinate();
      
      //maybe find a way to include the width and height in to the Cell class
      //but in a way that it could automatically adjust to window size changes
      int cellWidth = width / cols;
      int cellHeight = height / rows;
      
      stroke(127);
      fill(cell.getColor());
      rect(coord.x * cellWidth, coord.y * cellHeight, cellWidth, cellHeight);
    }
  }
}