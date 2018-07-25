class Coordinate {
  //a little helper class for containing a coordinate
  int x, y;
  Coordinate(int x, int y){
    this.x = x;
    this.y = y;
  }
}

class Cell {
  //a class that represents a single cell
  Coordinate coord;
  int index, w, h;
  color clr;

  Cell(int x, int y, int index, color clr) {
    coord = new Coordinate(x, y);
    this.index = index;
    this.clr = clr;
  }
  
  Coordinate getCoordinate(){
    return coord;
  }
  
  int getIndex(){
    return index;
  }
  
  color getColor(){
    return clr;
  }
  
  void setColor(color clr){
    this.clr = clr;
  }
}