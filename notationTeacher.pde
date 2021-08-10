// can not be 0
int middleCNote = 12;


int noteX = 400;
int notationHoriMargin = 300;
int notationVertMargin = 350;
int notationHeight = 200;
int notationWidth = 300;
int firstClefHeight = 400;
int clefDistance = 16;
int noteStep = clefDistance/2;
int middleCHeight = firstClefHeight + noteStep*3;

int noteDrawHeight = 16;
int noteDrawWidth = 20;

int[] notationNoteSteps = { 0, 0, 1, 1, 2, 3, 3, 4, 4, 5, 5, 6};
boolean[] notationSharps = {false, true, false, true, false, false, true, false, true, false, true, false};


public void drawNotation() {
  line(notationHoriMargin, notationVertMargin, notationHoriMargin, notationVertMargin + notationHeight);
  
  for (int i = 0; i < 5; i++) {
    line(notationHoriMargin, firstClefHeight+clefDistance*i, notationHoriMargin+notationWidth, firstClefHeight+clefDistance*i);
  }
  if (chordString != "") {
    String[] chordArray = split(chordString, ',');
    
    for (int noteI = 0; noteI < chordArray.length; noteI++) {
      int note = int(chordArray[noteI])+baseNote;
      int octave = 0;
      if (note != 0) {
        octave = (note)/12;
      }
      int noteVal = (notationNoteSteps[note % 12] + octave*7) - (notationNoteSteps[middleCNote%12]+((middleCNote/12)*7));
      int noteHeight = noteVal * noteStep ;
      ellipse(noteX, middleCHeight-noteHeight, noteDrawWidth, noteDrawHeight);
      if (notationSharps[note % 12] ) {
        drawSharp(noteX-noteDrawWidth-3, middleCHeight-noteHeight, int(noteDrawWidth/1.2), int(noteDrawHeight*1.2));
      }
      //println(noteVal);
      if (noteVal >= 5) {
        for (int j = noteVal -((noteVal+1) % 2); j >= 5; j -= 2) {
          line(noteX-noteDrawWidth*2, middleCHeight - j*noteStep, noteX+noteDrawWidth*2, middleCHeight - j*noteStep);
        }
      }
      if (noteVal <= 5) {
        for (int j = noteVal -((noteVal+1) % 2); j <= -7; j += 2) {
          line(noteX-noteDrawWidth*2, middleCHeight - j*noteStep, noteX+noteDrawWidth*2, middleCHeight - j*noteStep);
        }
      }
    }
  }
}

void drawSharp(int x, int y, int width, int height) {
  strokeWeight(3);
  int wPart = width/4;
  int hPart = height/4;
  line(x-wPart*2, y-hPart, x+wPart*2, y-hPart );
  line(x-wPart*2, y+hPart, x+wPart*2, y+hPart );
  line(x-wPart, y-hPart*2, x-wPart, y+hPart*2 );
  line(x+wPart, y-hPart*2, x+wPart, y+hPart*2 );
  strokeWeight(1);
}
