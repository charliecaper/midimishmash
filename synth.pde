import javax.sound.midi.*;

public class Synth {
  Synthesizer synthesizer;
  MidiChannel[] channel;
  boolean useSynth;
  int noteOffset = -2;
   
  public void initialize(boolean activateSynth) {
    try {
      if (activateSynth) {
        useSynth = activateSynth;
        synthesizer = MidiSystem.getSynthesizer();
        synthesizer.open();
        channel = synthesizer.getChannels();
         
        Instrument[] instr = synthesizer.getDefaultSoundbank().getInstruments();
        synthesizer.loadInstrument(instr[0]);
      }
    }
    
    catch (Exception ex) {
      System.out.println("Could not load the MIDI synthesizer.");
    }
  }
  
  public void noteOn(final int note, final int velocity) {
    println("a"+note);
    if (useSynth) {
      channel[0].noteOn(note+noteOffset, velocity);
    }
  }
  
  public void noteOff(final int note, final int velocity) {
    if (useSynth) {
      channel[0].noteOff(note+noteOffset, velocity);
    }
  }
  
  public void playNote(final int note, final int time) {
    println("a"+note);
    if (useSynth) {
      Thread t = new Thread() {
        public void run() {
          try {
           // if (channels != null && channels.length > 0) {
              channel[0].noteOn(note, 120);
              sleep(time);
              channel[0].noteOff(note, 0);
            //}
          } 
          catch (Exception ex) {
            System.out.println("ERROR: " + ex);
          }
        }
      };
      t.start();
    }
  }
  
  private void sleep(int length) {
    try {
      Thread.sleep(length);
    }
    catch (Exception ex) {
    }
  }
  
}
