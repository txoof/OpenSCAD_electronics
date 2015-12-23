/*
  Aaron Ciuffo
  23 December 2015 
  GPL V3

  A work very much in progress
*/
trimPotDim = [6.8, 8.1, 7.6];

module trimPot(locate = false, center = false) {
  $fn = 36;
  trans = center == false ? [0, 0, trimPotDim[2]/2] : [0, 0, 0];

  translate(trans)
  union() {
    color("orange")
      cube(trimPotDim, center=true);
    if (locate) {
      color("red")
        cylinder(h = trimPotDim[2]*20, r = .1, center=true);
    }
  }
}
trimPot(locate = false);
