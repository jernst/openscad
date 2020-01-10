//
// holder for the Bluelab pH probe cap while probe is in use
//

eps = 0.01;
$fn = 64;

difference() {
    union() {
        cylinder( r = 11, h = 32 );

        translate( [ 0, -11, 0 ] ) {
            cube( [ 19, 22, 32 ] );
        }

        translate( [ 15, -11, 32-eps ] ) {
            cube( [ 4, 22, 10+eps ] );
        }

        translate( [ 15, 0, 32 + 10 -eps ] )
        rotate( [ 0, 90, 0 ] ) {
            cylinder( r = 11, h = 4 );
        }
    }

// hole for screw

    translate( [ 15-eps, 0, 32 + 10 -eps ] )
    rotate( [ 0, 90, 0 ] ) {
        cylinder( r = 2, h = 4 + 2*eps );
    }

// through-hole for the cap, and outlet for liquid

    translate( [ 0, 0, 7-eps ] ) {
        cylinder( r = 9, h = 25 + 2*eps );
    }

    translate( [ 0, 0, 4 ] ) {
        cylinder( r1 = 6, r2 = 9, h=3 );
    }

    translate( [ 0, 0, -eps ] ) {
        cylinder( r = 6, h = 4 + 2*eps );
    }
}
