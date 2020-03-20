bZ=10.1;
bX=20.13;

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
armOverBody=20;  
// add a roller
addRoller=0; //[0:1]
// roller diameter
rollerD=4;


module body() {
    difference() {
        cube([bX,bY,bZ]);

        rotate([90,0,0]) {    
            translate([5.25,3.04,-8]) {
                cylinder(h=10, r=1.25);
            }
        }
        rotate([90,0,0]) {    
            translate([14.75,3.04,-8]) {
                cylinder(h=10, r=1.25);
            }
        }    
        translate([bX-10,-.1,bZ-0.64]) cube([11,11,2]);
        translate([bX-10,-.1,bZ-0.64]) rotate([0,-45,0]) 
            cube([1,11,2]);

    }    
}


module terminals() {
  translate([bX/2, termFromEdge, -tZ/2])
    cube([tX, tY, tZ]);
  translate([termFromEdge, termFromEdge, -tZ/2])
    cube([tX, tY, tZ]);
  translate([(bX-termFromEdge), termFromEdge, -tZ/2])
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
    translate([3, 1.2, bZ/2+armOverBody/4])
      rotate([0, -armAngle, 0])
      arm();
    color("silver")
      terminals();
  }  
}

micro_switch();