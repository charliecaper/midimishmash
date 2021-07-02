// chord structure, name, basenote, action
String[][] chords = {
  {"0,0", "Major 1st Unison", "-1", "Interval"},
  {"0,1", "Minor 2nd", "-1", "Interval"},
  {"0,2", "Major 2nd", "-1", "Interval"},
  {"0,3", "Minor 3rd", "-1", "Interval"},
  {"0,4", "Major 3rd", "-1", "Interval"},
  {"0,5", "Perfect 4th", "-1", "Interval"},
  {"0,6", "Tritone", "-1", "Interval"},
  {"0,7", "Perfect 5th", "-1", "Interval"},
  {"0,8", "Minor 6th", "-1", "Interval"},
  {"0,9", "Major 6th", "-1", "Interval"},
  {"0,10", "Minor 7th", "-1", "Interval"},
  {"0,11", "Major 7th", "-1", "Interval"},
  {"0,12", "Perfect 8ve", "-1", "Interval"},
  
  {"0,4,7", "MAJOR", "0", "KMUndo"},
  {"0,4,7", "MAJOR", "12", "KMCopyToMidiClipboard"},
  {"0,4,7", "MAJOR", "5", "KMLaunchFurhat"},
  {"0,4,7", "MAJOR", "17", "KMLaunchFinder"},
  
  {"0,3,7", "MINOR", "2", "KMRedo"},
  {"0,3,7", "MINOR", "14", "KMPasteFromMidiClipboard"},
  {"0,3,7", "MINOR", "16", "KMPasteFromMidiClipboardPast"},
  {"0,3,7", "MINOR", "9", "KMLaunchIntelliJ"},
  
  {"0,3,6", "DIMINISHED", "-1", ""},
  {"0,4,8", "AUGMENTED", "-1", ""},
  {"0,4,7,11", "MAJOR 7th", "-1", ""},
  {"0,3,7,11", "MINOR MAJOR", "-1", ""},
  {"0,3,7,10", "MINOR 7th", "-1", ""},
  {"0,4,7,10", "DOMINANT 7th", "-1", ""},
  {"0,3,7,10", "MINOR 7th", "-1", ""},
  {"0,3,6,10", "MINOR 7th (FLAT 5), half diminished", "-1", ""},
  {"0,4,8,10", "AUGMENTED 7th CHORD", "-1", ""},
  {"0,4,7,9", "MAJOR TRIAD (6)", "-1", ""},
  {"0,3,6,9", "DIMINSHED 7th", "-1", ""}
};

String[] notes = { "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};

String[] noteNames = { 
  "Red",
  "Brown",
  "Orange",
  "Mustard",
  "Yellow",
  "Green",
  "Aquamarine",
  "Cyan",
  "Cerulean",
  "Blue",
  "Purple",
  "Magenta"
};

color[] noteColors = { 
#ff0000,
#cc6633,
#ff9900,
#cccc33,
#ffff00,
#33ff00,
#66ffcc,
#00ffff,
#3399cc,
#0000ff,
#9900ff,
#ff00ff
};
