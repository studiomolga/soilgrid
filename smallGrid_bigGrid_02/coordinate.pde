class Coordinate{
  int x, y;
  
  Coordinate(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  Coordinate multiply(int scalar){
    return new Coordinate(x * scalar, y * scalar);
  }
}
