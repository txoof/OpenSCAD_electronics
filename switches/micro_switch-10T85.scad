/*
This is the 10T85 microswitch
*/

bZ=10.6;
bX=20.2;

$fn=36;

bY=6.46;

/*[terminals]*/
// terminal X dimension
tX=.6;
// terminal Y dimension
tY=3.3;
// terminal Z dimension
tZ=5;
// position from edge
termFromEdge=1.5;

/*[switch arm]*/
//arm X
aX=16;
// arm Y
aY=4;
// arm Z
aZ=.3;
 //absolute distance of arm from edge
armFromEdge=20;
//absolute distance of roller over the arm
rollerOverArm=0;
//distance of arm over body
armOverBody=21;  
// add a roller
addRoller=0; //[0:1]
// roller diameter
rollerD=4;


module body() {
    difference() {
        cube([bX,bY,bZ]);

        rotate([90,0,0]) {    
            translate([5.25,3.04,-8]) {
                cylinder(h=10, r=1.5);
            }
        }
        rotate([90,0,0]) {    
            translate([14.75,3.04,-8]) {
                cylinder(h=10, r=1.5);
            }
        }    
        translate([bX-10,-.1,bZ-0.64]) cube([11,11,2]);
        translate([bX-10,-.1,bZ-0.64]) rotate([0,-45,0]) 
            cube([1,11,2]);
        translate([bX-3.9,-1,-0.1]) rotate([0,45,0]) cube([4,10,1]);
        translate([bX-3.2,-1,-0.4]) cube([4,10,1]);
        translate([3.2, 9, -0.4]) rotate([0,0,180]) cube([4,10,1]);
        translate([3.85, 9, -0.1]) rotate([0,45,180]) cube([4,10,1]);
        translate([7.5,-1,-1]) cube([5,10,1.6]);
        translate([13.2, 9, -0.1]) rotate([0,45,180]) cube([4,10,1]);
   translate([bX-13.4,-1,-0.1]) rotate([0,45,0]) cube([4,10,1]); 

    }   
}


module terminals() {
  translate([bX/2+0.4, termFromEdge, -tZ/2-1])
    cube([tX, tY, tZ]);
  translate([termFromEdge, termFromEdge, -tZ/2-1])
    cube([tX, tY, tZ]);
  translate([(bX-termFromEdge)-0.4, termFromEdge, -tZ/2-1])
    cube([tX, tY, tZ]);
}

module arm() {
  color("silver")
  union() {
    rotate([0,-10,0])
      cube([aX, aY, aZ]);  
  }
}

module micro_switch() {
  //center on holes
  translate([0, 0, hZ])
  union() {
    body();
    translate([3, 1.2, bZ/2+armOverBody/4]) rotate([0, -armAngle, 0]) arm();
    color("silver")
      terminals();
  }  
}

micro_switch();