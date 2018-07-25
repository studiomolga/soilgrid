class Coordinate {
  //a little helper class for containing a coordinate
  int x, y;
  Coordinate(int x, int y){
    this.x = x;
    this.y = y;
  }
}

class Cell {
  //a class that represents a single class
  Coordinate coord;
  int index;
  //float w,h;   // width and height
  //float angle; // angle for oscillating brightness

  // Cell Constructor
  Cell(int x, int y, int index) {
    coord = new Coordinate(x, y);
    this.index = index;
  } 
  
  Coordinate getCoordinate(){
    return coord;
  }
  
  int getIndex(){
    return index;
  }
}