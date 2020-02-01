

difference() {
    union() {
        translate( [ -5, -5, 5 ] )
        cube( [ 10, 10, 160 ] );

        translate( [ -30, -20, 0 ] )
        cube( [ 60, 40, 6 ] );

        translate( [ -8, 0, 165 ] )
        rotate( [ 0, 90, 0 ] )
        cylinder( r=10, h=16 );
    }

    translate( [ -9, 0, 165 ] )
    rotate( [ 0, 90, 0 ] )
    cylinder( r=5, h=18 );
}
