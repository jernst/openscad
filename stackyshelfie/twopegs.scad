include <peg1.scad>


union() {
    peg( 20 );
    translate( [ 20, 0, 0 ] ) {
        peg( 20 );
    }
    translate( [ 0, 0, 20 ] ) {
        cube( [ 30-2*$play, 10-2*$play, 5 ] );
    }
}
