r = 17.5;
h1 = 12;
w = 2;
eps = 0.1;

$fn = 64;


module Spacer(h) {
    difference() {
        cylinder(h, r=r);
        translate( [ 0, 0, -eps ] ) {
            cylinder( h+2*eps, r=r-w );
        }
    }

    difference() {
        cylinder(h, r=r/2+w/2);
        translate( [ 0, 0, -eps ] ) {
            cylinder( h+2*eps, r=r/2-w/2 );
        }
    }
    
    translate( [ -w/2, -r+w/2, 0 ]) {
        cube([w, 2*r-w, h ]);
    }

    translate( [ -r+w/2, -w/2, 0 ]) {
        cube([2*r-w, w, h ]);
    }
}

Spacer(h1);

// translate([r*3, 0, 0]) {
//     Spacer(h2);
// }