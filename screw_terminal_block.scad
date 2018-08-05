// Neeraj Verma Aug, 3, 2018
// GPL V3 (https://www.gnu.org/licenses/gpl.txt)

// This is a mock of the real component
// Do not use on your real device.
/*
  use </path/to/libraries/screw_terminal_block.scad>
  //full
  screw_terminal_block(width=5.05, count=2)
  //simple
  screw_terminal_block();
  */
boxHeight=9;
width=5.05;
count=2;

module body(width=width) {
    difference() {
    union() {
        cube ([10.4,width,boxHeight]);
        translate([0,0,boxHeight]) cube ([8.6,width,boxHeight]);
    }
    translate([0,-0.1,boxHeight*2-6]) rotate([0,-60,0]) cube ([10.4,width+0.2,boxHeight]);    
    }
}

module cutout() {
    // cutout
    translate([6,width/2,boxHeight-7.5]) cylinder(d=3.7,17, $fn=20);    
    translate([-0.1,1,2.54]) cube([5,3,4.8]);
}

module screw_terminal_block(width=width, count=count) {
    for(i=[1:count]) {
        translate([0,width*i-width,0]) difference() {    
            body(width);
            cutout();
        }
    }
}

screw_terminal_block();