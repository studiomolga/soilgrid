class GridStates{
  GridStates(){
    for(int i = 0; i < 512; i++){
      String binaryString = binary(i, 9);
      char[] binaryCharArray = binaryString.toCharArray();
      println(binaryString);
    }
  }
}