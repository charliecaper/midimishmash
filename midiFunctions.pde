
void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println("On -- Channel: "+channel+" Pitch: "+pitch+" Velocity: "+velocity);
  if (channel == 1 && (pitch-keyOffset > -1 && pitch-keyOffset < keys.length)) {
    keys[pitch-keyOffset] = true;
    synth.noteOn(pitch-keyOffset+50,velocity+40);
  } else if (channel == 0) {
    synth.noteOn(pitch-keyOffset+50,100);
    if (pitch == 71) {
      enableKM(!KMenabled);
    } else if (pitch == 69) {
      enableIntervalTeacher(!intervalTeacherEnabled);
    } else if (pitch == 93) {
      messageKM("KMActivateMidiKeys");
    }
  }
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  //println("Off -- Channel: "+channel+" Pitch:"+pitch+" Velocity: "+velocity);
  if (channel == 1 && (pitch-keyOffset > -1 && pitch-keyOffset < keys.length)) {
    keys[pitch-keyOffset] = false;
    synth.noteOff(pitch-keyOffset+50,velocity);
  } else {
    synth.noteOff(pitch-keyOffset+50,100);
  }
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change --- Channel: "+channel+" Number:"+number+" Value: "+value);
  if (number == 55) {
    lastControllerValue = value;
  } 
}

void flashMidiBoard() {
  for (int i = 0; i < 40; i++) {
    keyLed(i, 5);
    delay(5);
  }
  for (int i = 0; i < 40; i++) {
    keyLed(i, 0);
    delay(5);
  }
  for (int i = 64; i < 72; i++) {
    keyLed(i, 1);
    delay(15);
  }
  for (int i = 64; i < 72; i++) {
    keyLed(i, 0);
    delay(15);
  }
  for (int i = 81; i < 87; i++) {
    keyLed(i, 1);
    delay(15);
  }
  for (int i = 81; i < 87; i++) {
    keyLed(i, 0);
    delay(15);
  }
}

//OFF = 0
//Green = 1
//Green Blink = 2
//Red = 3
//Red Blink = 4
//Yellow = 5
//Yellow Blink = 6
void keyLed(int keyPitch, int colour) {
  int channel = 0;
  myBus.sendNoteOn(channel, keyPitch, colour); // Send a Midi noteOn
}
