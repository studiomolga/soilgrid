import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Date;

class DataFile{
  JSONArray data;
  JSONObject currData;
  int fileIndex;
  int dataIndex;
  int clusterIndex;
  
  DataFile(JSONObject json, int fileIndex, int clusterIndex){
    JSONObject dataObject = json.getJSONArray("Data").getJSONObject(0);
    data = dataObject.getJSONArray("Data");
    this.fileIndex = fileIndex;
    this.clusterIndex = clusterIndex;
  }
  
  int getDataSize(){
    return(data.size());
  }
  
  void setDataIndex(int dataIndex){
    this.dataIndex = dataIndex;
    currData = data.getJSONObject(this.dataIndex);
  }
  
  float[] getNextValues(int range){
    float[] values = new float[range];
    for(int i = 0; i < values.length; i++){
      JSONObject value = data.getJSONObject((this.dataIndex + i) % data.size());
      values[i] = value.getFloat("Value");
    }
    
    dataIndex += 1;
    dataIndex %= data.size();
    setDataIndex(dataIndex);
    return values;
  }
}

class DataParser{
  String path;
  int numClusters;
  String[] files;
  DataFile[] dataFiles;
  
  DataParser(String path, int numClusters){
    this.path = path;
    this.numClusters = numClusters;
    File[] fileObjects = listFiles(this.path);
    files = new String[fileObjects.length];
    for(int i = 0; i < fileObjects.length; i++){
      String absolutePath = fileObjects[i].getAbsolutePath();   
      files[i] = absolutePath;
    }
    
    dataFiles = new DataFile[numClusters];
    int fileIndex = 0;
    for(int i = 0; i < numClusters; i++){
      if(numClusters / files.length > 0){
        if(i % files.length == 0) fileIndex += 1; 
        DataFile dataFile = new DataFile(loadJSONObject(files[fileIndex - 1]), fileIndex - 1, i);
        int offset = dataFile.getDataSize() / (numClusters / files.length);
        dataFile.setDataIndex((i % files.length) * offset);
        dataFiles[i] = dataFile;
      } else {
        DataFile dataFile = new DataFile(loadJSONObject(files[i]), i, i);
        dataFiles[i] = dataFile;
      }
    }
  }
  
  float[] getNextValues(int clusterId, int range){
    //returns a new value when available otherwise it returns the current
    return dataFiles[clusterId].getNextValues(range);
  }
  
  File[] listFiles(String dir) {
    File file = new File(dir);
    if (file.isDirectory()) {
      File[] files = file.listFiles();
      return files;
    } else {
      // If it's not a directory
      return null;
    }
  }
}