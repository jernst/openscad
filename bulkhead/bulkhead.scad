use <threadlib/threadlib.scad>
include <consts.inc>
include <modules.inc>


intersection() {
    nut("G1/2", turns=19, Douter = 2 * in );

    union() {
        bolt( "G1", turns=9 );
        translate( [ 0, 0, 20 ] ) {
            disk();
        }
    }
}

