import ddf.minim.*;
import ddf.minim.ugens.*;

class SoundFile {
  Sampler sample;
  Constant amp;

  SoundFile(Minim minim, AudioOutput out, String path, int voices) {
    sample = new Sampler(path, voices, minim);
    amp = new Constant(0.1f);
    amp.patch(sample.amplitude);
    sample.patch(out);
  }

  void amplitude(float val){
    amp.setConstant(val);
  }

  void play() {
    sample.trigger();
  }
}

class SoundLibrary {
  SoundFile[] soundFiles;
  
  SoundLibrary(Minim minim, AudioOutput out, String path, int voices){
    String files[] = listFiles(path);
    printArray(files);
    println("-------------");
    soundFiles = new SoundFile[files.length];
    for(int i = 0; i < soundFiles.length; i++){
      SoundFile soundFile = new SoundFile(minim, out, files[i], voices);
      soundFiles[i] = soundFile;
    }
  }
  
  int getNumFiles() {
    return soundFiles.length;
  }
  
  void setAmplitude(float amp){
    for(SoundFile soundFile : soundFiles){
      soundFile.amplitude(amp);
    }
  }

  void play(int index) {
    soundFiles[index].play();
  }
  
  String[] listFiles(String dir) {
    File file = new File(dir);
    if (file.isDirectory()) {
      File files[] = file.listFiles();
      String names[] = new String[files.length];
      for(int i = 0; i < files.length; i++){
        String absolutePath = files[i].getAbsolutePath();
        names[i] = absolutePath;
      }
      names = sort(names);
      return names;
    } else {
      // If it's not a directory
      return null;
    }
  }
}

class SoundEngine {
  Minim minim;
  AudioOutput out;
  SoundLibrary[] soundLibraries;
  int lid;

  SoundEngine(PApplet parent, String path, int voices, int clusters) {
    minim = new Minim(parent);
    out = minim.getLineOut();
    lid = 0;
  
    String libDirs[] = listDirs(path);
    soundLibraries = new SoundLibrary[libDirs.length];
    for(int i = 0; i < libDirs.length; i++){
      SoundLibrary soundLibrary = new SoundLibrary(minim, out, libDirs[i], voices);
      soundLibrary.setAmplitude(0.75f / (float) clusters);
      soundLibraries[i] = soundLibrary;
    }
  }
  
  void setLibrary(int lid){
    this.lid = lid;
  }
  
  int getNumLibraries(){
    return soundLibraries.length;
  }

  int getNumFiles() {
    return soundLibraries[lid].getNumFiles();
  }

  void play(int index) {
    soundLibraries[lid].play(index);
  }
  
  String[] listDirs(String path) {
    File filepath = new File(path);
    if(filepath.isDirectory()) {
      File files[] = filepath.listFiles();
      String names[] = {};
      for(File file : files){
        if(file.isDirectory()){
          String absPath = file.getAbsolutePath();
          names = append(names, absPath);
        }
      }
      names = sort(names);
      return names;
    } else {
      return null;
    }
  }
}
