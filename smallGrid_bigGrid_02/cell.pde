class Cell{
  Coordinate pos;
  color clr;
  int index;
  
  Cell(Coordinate pos, int index, color clr){
    this.pos = pos;
    this.index = index;
    this.clr = clr;
  }
  
  void setColor(color clr){
    this.clr = clr;
  }
  
  color getColor(){
    return clr;
  }
  
  Coordinate getPos(){
    return this.pos;
  }
}
