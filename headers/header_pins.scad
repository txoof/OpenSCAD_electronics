/*
  Breakaway Header Pins: pitch 2.54, adjustable
  Aaron Ciuffo
  23 June 2019
  GPL V3

  derived from Molex KK 100 break-away header:
  http://www.molex.com/pdm_docs/sd/022032041_sd.pdf

  Changes:
  * Add female version
  * remove centerV parameter

  Usage (default values shown): 
  ```
  use </path/to/libraries/header_pins.scad>
  //full
  headerPins(columns=3, rows=2, center=true, pitch=2.52, female=false);
  //simple
  headerPins(3, 2);
  ```
  columns = integer number of columns (X axis)
  rows = integer number of rows (Y axis)
  center = center the array at the origin
  pitch = distance between center of each pin
  female = boolean - true create a female version

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

module singlePin(center=false, locate=false, v=false, female=false) {
  femalePin = [.67, .67, 3.5];
  malePin = [.67, .67, 14.22];

  pinDimensions = female == false ? malePin : femalePin;
  maleNylon = [2.36, 2.36, 3.3];
  femaleNylon = [2.36, 2.36, 8.5];

  nylonDimensions = female == false ? maleNylon : femaleNylon;
  pinAboveNylon = 7.49;

  trans = center == false ? [0, 0, nylonDimensions[2]/2] : [0, 0, 0];

  translate(trans)
  union() {
   // translate([0, 0, (-pinDimensions[2]/2+nylonDimensions[2]/2)+pinAboveNylon])

    color("gold")
    if (female) {
      translate([0, 0, -nylonDimensions[2]/2-pinDimensions[2]/2])
      cube(pinDimensions, center = true);
    } else {
      translate([0, 0, (-pinDimensions[2]/2+nylonDimensions[2]/2)+pinAboveNylon])
      cube(pinDimensions, center=true);
    }

    color("darkgray")
      difference() {
        cube(nylonDimensions, center = true);
        if (female) {
          cube(malePin, center=true);
        }
      }
    if (locate) {
      color("red")
        cylinder(r = 0.1, h = pinDimensions[2]*5, center = true);
    }
  }

  if (v) {
    echo("single pin dimension:", pinDimensions);
    echo("pin above nylon:", pinAboveNylon);
  }


}


module XsinglePin(center = false, locate = false, v = false) {
  pinDimensions = [.67, .67, 14.22];
  nylonDimensions = [2.36, 2.36, 3.3];
  pinAboveNylon = 7.49;

  trans = center == false ? [0, 0, nylonDimensions[2]/2] : [0, 0, 0];

  translate(trans)
  union() {
    translate([0, 0, (-pinDimensions[2]/2+nylonDimensions[2]/2)+pinAboveNylon])
      color("gold")
      cube(pinDimensions, center = true);    
    color("darkgray")
      cube(nylonDimensions, center =true);
    if (locate) {
      color("red")
        cylinder(r = 0.1, h = pinDimensions[2]*5, center = true);
    }
  }

  if (v) {
    echo("single pin dimension:", pinDimensions);
    echo("pin above nylon:", pinAboveNylon);
  }

}

module headerPins(columns = 3, rows = 2, center = true, 
                  pitch = 2.54, locate = false, v = false, female=false) {
  //transV = centerV == true ? /2 : 0; // vertical center

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
          singlePin(locate = locate, v = v, female=female);
      }
    }
    //union together the breakaway elements
      color("black")
      cube([pitch*(columns-1), pitch*(rows-1), 2]);
  }
}

//singlePin();
//headerPins(columns = columns , rows = rows, pitch = pitch, female=false);

