// Neeraj Verma Aug, 3, 2018
// http://www.noami.us

// GPL V3 (https://www.gnu.org/licenses/gpl.txt)

use <step_stick.scad>
use <../headers/header_pins_female.scad>
use <../terminals/screw_terminal_block.scad>

width=143;
depth=84.23;
height=1.6;
holesFromEdge=4;
headerDistance=-21.67;

module mountingHoles() {
    translate([holesFromEdge,holesFromEdge,-1]) cylinder(d=4, h=10, $fn=20);
    translate([width-holesFromEdge,holesFromEdge,-1]) cylinder(d=4, h=10, $fn=20);
    translate([holesFromEdge,depth-holesFromEdge,-1]) cylinder(d=4, h=10, $fn=20);
    translate([width-holesFromEdge,depth-holesFromEdge,-1]) cylinder(d=4, h=10, $fn=20);
}

module board() {
    cube([width, depth, height]);
    translate([21.71,0,0]) color("silver") cube([12,16.5,12.45-height]);
}

module cutout() {
    mountingHoles();
}

module mksGen14() {  
    difference() {
        board();
        cutout();
    }
// stepper driver header pins
for(i=[0:4]) {
    translate([headerDistance*i, 0, 0]) header();        
    translate([headerDistance*i, 0, 0]) stepperDriver();        
}
// main power screw terminals
translate([1.5,10,0]) screw_terminal_block();
// heat bed screw terminals
translate([1.5,35.5,0]) screw_terminal_block();

}

module stepperDriver() {
    translate ([width-4,75.35,0]) rotate([0,0,180]) step_stick(sinkHeight=5);    
}

module header() {
translate ([width-14.16,74.08,0]) headerPinsFemale(8, 1);
translate ([width-14.16,61.08,0]) headerPinsFemale(8, 1);
}    

mksGen14();

