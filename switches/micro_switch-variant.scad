/*
  Micro switch with roller - variant design

*/
/*[configuration]*/
$fn=36; //curve refinement

/*[body]*/
bX=28.5;  
bY=10.3;
bZ=16.2;
hD=3.5; //hole diameter
holeFromBottom=1.4; //absolute distance of mounting hole from bottom of switch
holeFromEdge=1.4; //absolute distance of mounting hole from edge

/*[terminals]*/
tX=9.8;
tXb=8.8;
tY=3.3;
tZ=.5;
termFromEdge=4;
termFromBottom=4;
termFromTop=6;
termBFromEdge=15.8;
termBOverBody=2.6;

/*[switch arm]*/
aX=27.9;
aY=4.4;
aZ=.6;
armFromEdge=11; //absolute distance of arm from edge
rollerOverArm=1; //absolute distance of roller over the arm
armOverBody=2.3; //distace of arm over body 
addRoller=1;
rollerD=4.8;

/*[Hidden]*/
hR=hD/2; 
echo(hR);
hZ=bZ/2-hR-holeFromBottom; //place the hole
hX=bX/2-hR-holeFromEdge;
//hY=bX/2-hR-holeFromEdge;
rollerR=rollerD/2;
armAngle=asin(armOverBody/aX/2);

module body() {
  difference() {
    color("gray")
      cube([bX, bY, bZ], center=true);
    rotate([90, 0, 0])
      translate([hX, -hZ, 0])
      cylinder(r=hR, h=bY*1.5, center=true);
    rotate([90, 0, 0])
      translate([-hX, hZ, 0])
        cylinder(r=hR, h=bY*1.5, center=true);
  }
}

module angle_arm() {
  color("silver")
  union() {
    rotate([])
      cube([aX, aY, aZ], center=true);
    if (addRoller==1) {
      translate([aX/2-rollerR, 0, rollerR+rollerOverArm])
        rotate([90, 0, 0])
        cylinder(h=aY, r=rollerR, center=true);
      translate([aX/2-rollerR, 0, rollerR/2])
        cube([rollerD, rollerD, rollerR], center=true);
    }
  
  }
}

module straight_arm() {
  color("silver")
  union() {
    cube([aX, aY, aZ], center=true);
    translate([-aX/2+aZ/2, 0, -armOverBody/2])
      cube([aZ, aY, armOverBody ], center=true);
    if (addRoller==1) {
     translate([aX/2-rollerR, 0, rollerR+rollerOverArm])
        rotate([90, 0, 0])
        cylinder(h=aY, r=rollerR, center=true);
      translate([aX/2-rollerR, 0, rollerR/2])
        cube([rollerD, rollerD, rollerR], center=true);
    }
  }
}

module terminals() {

  translate([-bX/2-tX/2, 0, -bZ/2+tZ/2+termFromBottom])
    cube([tX, tY, tZ], center=true);
  translate([-bX/2-tX/2, 0, bZ/2-tZ/2-termFromTop])
    cube([tX, tY, tZ], center=true);

  translate([bX/2-tXb/2-termBFromEdge, 0, -bZ/2-termBOverBody])
    union() {
      cube([tXb, tY, tZ], center=true);
      translate([tXb/2-tZ/2, 0, termBOverBody/2])
        cube([tZ, tY, termBOverBody], center=true);
    }
   /*
  translate([0, 0, -bZ/2-tZ/2])
    cube([tX, tY, tZ], center=true);
  translate([bX/2-tX/2-termFromEdge, 0, -bZ/2-tZ/2])
    cube([tX, tY, tZ], center=true);
  translate([-1*(bX/2-tX/2-termFromEdge), 0, -bZ/2])
    cube([tX, tY, tZ], center=true);

  */
}


module micro_switch_var() {
  //center on holes
  translate([0, 0, hZ])
  union() {
    body();
    translate([armFromEdge, 0, bZ/2+armOverBody])
      rotate([0, 0, 0])
      straight_arm();
    color("silver")
      terminals();
  }  
}

micro_switch();
