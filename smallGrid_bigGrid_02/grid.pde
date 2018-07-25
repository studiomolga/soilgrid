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
      Cell cell = new Cell(x, y, i);
      cells[i] = cell;
    }
  }
  
  void draw(){
    for(int i = 0; i < cells.length; i++){
      Cell cell = cells[i];
      Coordinate coord = cell.getCoordinate();
      
      //maybe find a way to include these in to the Cell class
      int cellWidth = width / cols;
      int cellHeight = height / rows;
      stroke(127);
      noFill();
      rect(coord.x * cellWidth, coord.y * cellHeight, cellWidth, cellHeight);
    }
  }
}