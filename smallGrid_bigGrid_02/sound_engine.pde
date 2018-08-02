import ddf.minim.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//TODO: this class could extend or implement FilePlayer
class SoundFile{
  FilePlayer filePlayer;
  Multiplier multiplier;
  String path;
  
  SoundFile(Minim minim, AudioOutput out, String path){
    this.path = path;
    
    filePlayer = new FilePlayer(minim.loadFileStream(this.path));
    multiplier = new Multiplier(0.1f);
    filePlayer.patch(multiplier).patch(out);
  }
  
  boolean isPlaying(){
    return filePlayer.isPlaying();
  }
  
  void play(){
    filePlayer.rewind();
    filePlayer.play();
  }
}

class SoundEngine{
  Minim minim;
  AudioOutput out;
  SoundFile[] soundFiles;
  int playIndex;
  
  SoundEngine(PApplet parent, String path){
    minim = new Minim(parent);
    out = minim.getLineOut();
    playIndex = -1;
    
    File[] fileObjects = listFiles(path);
    soundFiles = new SoundFile[fileObjects.length];
    for(int i = 0; i < soundFiles.length; i++){
      String absolutePath = fileObjects[i].getAbsolutePath();   
      soundFiles[i] = new SoundFile(minim, out, absolutePath);
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