

difference() {
    union() {
        cylinder( r=5, h=50 );

        translate( [ 0, -5, 0 ] )
        cube( [ 15, 10, 6 ] );
    }

    translate( [ 6, 6, 21 ] )
    rotate( [ 0, -90, 0 ] )
    rotate( [ 90, 0, 0 ] )
    linear_extrude( 12 ) {
        polygon( [[ 0, 0 ], [ 30, 0 ], [ 30, 12 ]] );
    }
}

