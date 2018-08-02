import ddf.minim.*;
import ddf.minim.effects.*;

class SoundEngine{
  String[] filePaths;
  Minim minim;
  AudioPlayer[] soundFiles;
  
  SoundEngine(PApplet parent, String path){
    minim = new Minim(parent);
    
    File[] fileObjects = listFiles(path);
    filePaths = new String[fileObjects.length];
    for(int i = 0; i < fileObjects.length; i++){
      String absolutePath = fileObjects[i].getAbsolutePath();   
      filePaths[i] = absolutePath;
    }
    
    soundFiles = new AudioPlayer[filePaths.length];
    for(int i = 0; i < soundFiles.length; i++){
      soundFiles[i] = minim.loadFile(filePaths[i], 2048);
    }
  }
  
  int getNumFiles(){
    return soundFiles.length;
  }
  
  void play(int index){
    if(!soundFiles[index].isPlaying()){
      soundFiles[index].play();
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
}