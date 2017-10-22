wall=.3;

difference() {
    cube( [ 10, 10, 6 ]);
    translate( [ wall, -1, wall ] ) {
        cube( [ 10-2*wall, 12, 8 ] );
    }
}
