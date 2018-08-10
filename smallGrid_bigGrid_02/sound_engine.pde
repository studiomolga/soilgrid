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

class SoundEngine {
  Minim minim;
  AudioOutput out;
  SoundFile[] soundFiles;
  int playIndex;

  SoundEngine(PApplet parent, String path, int voices) {
    minim = new Minim(parent);
    out = minim.getLineOut();
    playIndex = -1;

    String[] fileNames = listFiles(path);
    printArray(fileNames);
    soundFiles = new SoundFile[fileNames.length];
    for (int i = 0; i < soundFiles.length; i++) {
      soundFiles[i] = new SoundFile(minim, out, fileNames[i], voices);
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