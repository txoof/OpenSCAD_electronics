/*
  Through Hole Micro female Micro USB connector
  Based on WERI PART NO: 614 105 150 721
  http://www.mouser.com/ds/2/445/614105150721-469235.pdf

  Aaron Ciuffo
  23 December 2013
  GPL V3

*/

/*
      portTopLen
    -----------------
    |               | portSide
    |               |
    \               /
     \             /
      -------------
       portBottomLen
*/


module usbMicro(center = false) {
  portTopLen = 6.9;
  portSide = 1.8;
  portBottomLen = 5.4;
  portSideTotal = 3; 
  portDepth = 7;

  trans = center == false ? 0 : portSideTotal/2; 

  points = [[0, 0], // 0
            [portTopLen, 0], //1
            [portTopLen, -portSide], //2
            [portTopLen/2+portBottomLen/2, -portSideTotal], //3
            [portTopLen/2-portBottomLen/2, -portSideTotal], //4
            [0, - portSide]];

    color("silver")
    translate([-portTopLen/2, portDepth/2, portSideTotal-trans])
    rotate([90, 0, 0])
    linear_extrude(height = portDepth)
    polygon(points);
}

module usbMicroCutter(cutScale = 1.1) {
  scale([cutScale, cutScale])
    usbMicro();
}

//usbMicro();
usbMicroCutter();
