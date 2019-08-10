//
//
//

$fn = 64;

difference() {
    union() {
        cube( [ 30, 6, 3 ] );

        for( i = [0:5] ) {
            r = 0.5 + 0.25*i;
            translate( [ 2 + i*5, 3, 0 ] ) {
                cylinder( r=r+0.8, h=12 );
            }
        }
    }
    for( i = [0:5] ) {
        r = 0.5 + 0.25*i;
        translate( [ 2 + i*5, 3, -1 ]) {
            cylinder( r=r, h=14 );
        }
    }
}
