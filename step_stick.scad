/* Pololu stepper driver board
  Neeraj Verma
  July 23 2018
  GPL V3
  
  use </path/to/libraries/step_stick.scad>
  //full
  step_stick(sinkHeight=5);
  //simple
  step_stick();
*/

use <header_pins.scad>

sinkHeight=5;
heightAbovePCBSurface = 8.9;

module board(sinkHeight=5) {
// pcb
translate([15.25,0,-1]) rotate(90) color("red") cube([15.3,20.5,1.66]);   
// chip
translate([1,3.54,0.66]) cube([7,7,1]);    
// heat sink    
color("silver") difference() {
    translate([0,2.54,1.66]) cube([9,9,sinkHeight]);
    union() {
        translate([-.1,3.54,3.4]) cube([10,1,sinkHeight+1]);
        translate([-.1,5.54,3.4]) cube([10,1,sinkHeight+1]);
        translate([-.1,7.54,3.4]) cube([10,1,sinkHeight+1]);
        translate([-.1,9.54,3.4]) cube([10,1,sinkHeight+1]);
    }    
}    
// pot
translate([13,6.54,0.5]) color("silver") cylinder(h=0.5,d=3.37, $fn=20);   
} 

module step_stick(sinkHeight=5, heightAbovePCBSurface=8.9) {
    translate([10.2,1.2,heightAbovePCBSurface]) union() {
        headerPins(8, 1, pinAboveNylon=3, pinHeight=11.25);
        translate ([0,13,0]) headerPins(8, 1, pinAboveNylon=3, pinHeight=11.25);
        translate([-5,-1.2, 3.4]) board(sinkHeight=sinkHeight);
    }
}

step_stick(sinkHeight=sinkHeight, heightAbovePCBSurface=heightAbovePCBSurface);