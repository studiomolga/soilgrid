import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Date;

/* notes to self:
- we will make one instance of the dataparser object which will passed to all clusters by reference
- a cluster will get assigned a file or portion of a dataset based on how many clusters and how many datasets are available, we will have to assign some ID number to each cluster
- cluster can request data by calling getNextValue(int clusterID)
*/
class DataParser{
  String path;
  int numClusters;
  String[] files;
  JSONArray[] values;
  int[] valueIndices;
  
  DataParser(String path, int numClusters){
    this.path = path;
    this.numClusters = numClusters;
    File[] fileObjects = listFiles(this.path);
    files = new String[fileObjects.length];
    for(int i = 0; i < fileObjects.length; i++){
      String absolutePath = fileObjects[i].getAbsolutePath();
      files[i] = absolutePath;
    }
    
    values = new JSONArray[files.length];
    for(int i = 0; i < values.length; i++){
      JSONObject json = loadJSONObject(files[i]);
      JSONObject dataObject = json.getJSONArray("Data").getJSONObject(0);
      values[i] = dataObject.getJSONArray("Data");
    }
    
    valueIndices = new int[numClusters];
    for(int i = 0; i < valueIndices.length; i++){
      valueIndices[i] = 0;
    }
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
  
  int timeStampToEpoch(String timeStamp){
    try {
      SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
      //sdf.setTimeZone(); if it turns out to be relevant we can try to set the timezones as they are available via the json data file
      Date dt = sdf.parse(timeStamp);
      long epoch = dt.getTime();
      return (int)(epoch/1000);
    } catch(ParseException e){
      print("ERROR: ");
      println(e);
      return 0;
    }
  }
}