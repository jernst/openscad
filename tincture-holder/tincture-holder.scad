$fn = 64;
eps = 0.01;

difference() {
    cylinder(r1=23, r2=0, h=46);
    
    translate([0, 0, -eps]) {
        cylinder(r=9, h=46);
    }
}