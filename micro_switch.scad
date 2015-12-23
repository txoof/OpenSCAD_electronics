/*
  Micro switch with roller

*/
/*[configuration]*/
$fn=36; //curve refinement

/*[body]*/
bX=20;  
bY=6.1;
bZ=10;
hD=2.5; //hole diameter
holeFromBottom=1.8; //absolute distance of mounting hole from bottom of switch
holeFromEdge=4.3; //absolute distance of mounting hole from edge

/*[terminals]*/
tX=.6;
tY=3.3;
tZ=4;
termFromEdge=1.5;


/*[switch arm]*/
aX=18.5;
aY=4;
aZ=.3;
armFromEdge=3; //absolute distance of arm from edge
rollerOverArm=1; //absolute distance of roller over the arm
armOverBody=4; //distace of arm over body 
addRoller=1;
rollerD=4;

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
      translate([-hX, -hZ, 0])
        cylinder(r=hR, h=bY*1.5, center=true);
  }
}

module arm() {
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

module terminals() {
  translate([0, 0, -bZ/2-tZ/2])
    cube([tX, tY, tZ], center=true);
  translate([bX/2-tX/2-termFromEdge, 0, -bZ/2-tZ/2])
    cube([tX, tY, tZ], center=true);
  translate([-1*(bX/2-tX/2-termFromEdge), 0, -bZ/2-tZ/2])
    cube([tX, tY, tZ], center=true);
}

module micro_switch() {
  //center on holes
  translate([0, 0, hZ])
  union() {
    body();
    translate([armFromEdge/2, 0, bZ/2+armOverBody/4])
      rotate([0, -armAngle, 0])
      arm();
    color("silver")
      terminals();
  }  
}

micro_switch();
