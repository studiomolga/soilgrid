import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Date;

/* notes to self:
- we will make one instance of the dataparser object which will passed to all clusters by reference
- a cluster will get assigned a file or portion of a dataset based on how many clusters and how many datasets are available, we will have to assign some ID number to each cluster
- cluster can request data by calling getNextValue(int clusterID)
*/
class DataParser{
  DataParser(){
  
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