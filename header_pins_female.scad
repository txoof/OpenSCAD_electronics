/*
  Breakaway Female Header Pins: pitch 2.54, adjustable
  Neeraj Verma
  July 31 2018
  GPL V3

  derived from Molex KK 100 break-away header:
  http://www.molex.com/pdm_docs/sd/022032041_sd.pdf

  Usage (default values shown): 
  ```
  use </path/to/libraries/header_pins.scad>
  //full
  headerPinsFemale(columns = 3, rows = 2, centerV = false, center = true, pitch = 2.52);
  //simple
  headerPinsFemale(3, 2);
  ```
  columns = integer number of columns (X axis)
  rows = integer number of rows (Y axis)
  centerV = vertically center around base - fale places bottom at origin
  center = center the array at the origin
  pitch = distance between center of each pin

  Note: 
  * the breakaway connector is a bit of a fudge and does not appear at the same
    Z height for centered/versus non centered; this should be largely irrelevant 

  updates can be found at GitHub:
  https://github.com/txoof/OpenSCAD_electronics

*/

/*[Dimensions]*/
//Columns
columns = 3; //[1:30]
//Rows
rows = 2; //[1:5]
//Pitch
pitch = 2.54; //[1.25, 1.27, 2, 2.54, 3.5, 3.96]

pinHeight=8.4;

pinAboveNylon=1;

module singlePinFemale(center = false, locate = false, v = false, pinHeight=14.22, pinAboveNylon = 7.49) {
  pinDimensions = [.67, .67, pinHeight];
  nylonDimensions = [2.36, 2.36, pinHeight];

  trans = center == false ? [0, 0, nylonDimensions[2]/2] : [0, 0, 0];

  translate(trans)
  difference() {
    color("darkgray")
      cube(nylonDimensions, center =true);
    translate([0, 0, (-pinDimensions[2]/2+nylonDimensions[2]/2)+pinAboveNylon])
      color("gold")
      cube(pinDimensions, center = true);    
  }

  if (v) {
    echo("single pin dimension:", pinDimensions);
    echo("pin above nylon:", pinAboveNylon);
  }

}

module headerPinsFemale(columns = 3, rows = 2, centerV = false, center = true, 
                  pitch = 2.54, locate = false, v = false, pinHeight=14.22, pinAboveNylon=7.49) {
  transV = centerV == false ? pitch/2 : 0; // vertical center

  trans = center == false ? [0, 0, 0] : [-(columns-1)*pitch/2, -(rows-1)*pitch/2, 0];
  if (v) {
    echo("header pin array");
    echo("usage: columns, rows, centerV, center, pitch, locate, v(erbose)");
  }

  translate(trans) 
  union() {
    for (i = [0:columns-1]) {
      for (j = [0:rows-1]) {
        translate([pitch*i, pitch*j, 0])
          singlePinFemale(locate = locate, v = v, pinHeight=pinHeight, pinAboveNylon=pinAboveNylon);
      }
    }
    translate([0, 0, -pitch/2+transV])
      color("black")
      cube([pitch*(columns-1), pitch*(rows-1), 2]);
  }
}

//singlePinFemale();
headerPinsFemale(columns = columns , rows = rows, pitch = pitch, pinHeight = pinHeight, pinAboveNylon=pinAboveNylon);
