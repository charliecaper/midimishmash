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
  
  public void noteOn(final int note, int velocity) {
    if (useSynth) {
      channel[0].noteOn(note+noteOffset, velocity);
    }
  }
  
  public void noteOff(final int note, int velocity) {
    if (useSynth) {
      channel[0].noteOff(note+noteOffset, velocity);
    }
  }
}
