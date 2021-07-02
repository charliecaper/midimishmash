import themidibus.*;
import g4p_controls.*;

MidiBus myBus;
PFont f;

// value of first key on keyboard
int keyOffset = 48;

int horiMargin = 80;
int vertMargin = 40;

int amountOfKeys = 25;//97-keyOffset;
int amountFullKeys = 15;
boolean[] keys = new boolean[amountOfKeys];

float keyWidthFloat = 0.0; 
int keyWidth = 0;

boolean actedOnChord = false;

long lastCommandSent = System.currentTimeMillis();
int lastControllerValue = -1;

int baseNote = 0;

GButton btnDisableKM;
boolean KMdisabled = false;

Synth synth;
 // set this to false if you would rather use another program to create the sound.
boolean useSynth = true;

void setup() {
  size(1200, 400);
  
  btnDisableKM = new GButton(this, horiMargin, height-vertMargin-20, 100, 20, "Maestro");

  f = createFont("Arial",16,true);
  textFont(f,32);
  keyWidthFloat = (width-horiMargin*2) / (amountFullKeys) ;
  keyWidth = floor(keyWidthFloat);
  background(100);
  
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  myBus = new MidiBus(this, "APC Key 25", "APC Key 25"); // Create a new MidiBus using the device names to select the Midi input and output devices respectively.

  flashMidiBoard();

  synth = new Synth();
  synth.initialize(useSynth);
}

void draw() {
  int[] chord = new int[0];
  String chordString = "";
  int baseNote = 0;
  if (KMdisabled) {
    background(210);
  } else {
    background(255);
  }

  // draw the keys
  int keyCount = 0;
  for (int i = 0; i < keys.length; i++) {
    int note = i % 12;
      // if a key is pressed, add it to the current chord.
    if (keys[i]) {
      chord = append(chord, i);
      if (chordString.length() > 0) {
        chordString += ","+(i-baseNote);// % 12;
      } else {
        chordString += 0;
        baseNote = i;
      }
    }
    if (!(note == 1 || note == 3 || note == 6 || note == 8 || note == 10)) {
      if (keys[i]) {
        fill(noteColors[note]);
      } else {
        fill(255);
      }
      rect(horiMargin+keyWidth*keyCount, vertMargin, keyWidth, 200);
      keyCount++;
    }
  }
  keyCount = 0;
  for (int i = 0; i < keys.length; i++) {
    int note = i % 12;
    if (note == 1 || note == 3 || note == 6 || note == 8 || note == 10) {
      if (keys[i]) {
        fill(noteColors[note]);
      } else {
        fill(0);
      }
      rect(horiMargin+keyWidth/2+ keyWidth*keyCount+keyWidth/4, vertMargin, keyWidth/2, 100);
      keyCount++;
    } else if (note == 4 || note == 11) {
      keyCount++;
    }
  }
  
  String chordText = "";
  // figure out what chord it is
  for (int i = 0; i < chords.length; i++) {
    if (chordString.equals(chords[i][0])) {
      chordText = notes[baseNote % 12] + " - " + chords[i][1];
      if (!actedOnChord && baseNote == int(chords[i][2])) {
        if (chords[i][3].length() > 1) {
          if (chords[i][3].substring(0,2).equals("KM")) {
            messageKM(chords[i][3]);
          }
        }
      } else if (!actedOnChord && chords[i][3].equals("Interval")) {
        fill(noteColors[i % 12]);
        rect(width-horiMargin/2, 0, horiMargin/2, height);
        fill(0);
        text(noteNames[i % 12], width-horiMargin*2, height-vertMargin);
      }
    }
  }
  
  strokeWeight(1);
  fill(0);
  if (chordString.length() > 0) {
    text(chordText, width/2, 330);
  } else {
    actedOnChord = false;
  }
  
  handleVolume();
}

public void handleButtonEvents(GButton button, GEvent event) {
  if(button == btnDisableKM){
    enableKM(!KMdisabled);
  }
}

void enableKM(boolean state) {
  KMdisabled = state;
  if (KMdisabled) {
    keyLed(71, 1);
  } else {
    keyLed(71, 0);
  }
}

void messageKM(String script) {
    if (!KMdisabled) {
        for (int i = 0; i < 40; i++) {
      keyLed(i, 1);
      delay(5);
    }
    for (int i = 0; i < 40; i++) {
      keyLed(i, 0);
      delay(5);
    }
    println(script);
    String[] cmd = { "osascript", "-e",  "tell app \"Keyboard Maestro Engine\" to do script \""+script+"\"" };
    exec(cmd);
    actedOnChord = true;
  }
}

  // change volume
void handleVolume() {
  if (System.currentTimeMillis() > lastCommandSent +250) {
    lastCommandSent = System.currentTimeMillis();
    if (lastControllerValue > -1) {
      float volume = floor(lastControllerValue / 1.28);
      println(volume);
      lastControllerValue = -1;
      String[] cmd = { "osascript", "-e",  "tell app \"Keyboard Maestro Engine\" to do script \"KMSetVolume\" with parameter \""+int(volume)+"\"" };
      exec(cmd);
    }
  }
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
