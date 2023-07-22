

include <constants.inc>

r = 33.75 / 2 ;
lock = 1;
clipWidth = 8;

clipPlateL = clipWidth;
clipPlateW = pegD + 2 * pegW + pegW;

union() {
    translate( [ clipWidth, 0, r + t ] )
    rotate( [ 0, -90, 0 ] )
    difference() {
        cylinder( r = r + t, h = clipWidth );
        translate( [ 0, 0, -eps ] ) {
            cylinder( r = r, h = clipWidth + 2 * eps );
        }

        // cut off to the right
        translate( [ 10, -2 * r, -eps ] ) {
            cube( [ 2 * r, 4 * r, clipWidth + 2 * eps ] );
        }

        // straighten inside edge
        translate( [ 0, -r + lock, -eps ] ) {
            cube( [ 2 * r, 2 * ( r - lock ), clipWidth + 2 * eps ] );
        }
    }

    difference () {
        translate( [ 0, -clipPlateW/2, -pegH + eps ] ) {
            cube( [ clipPlateL, clipPlateW, pegH + t ] );
        }
        translate( [ ( clipWidth - pegL ) / 2, ( pegD - pegW ) / 2, -pegH ] ) {
            cube( [ clipWidth, pegW, pegH ] );
        }
        translate( [ ( clipWidth - pegL ) / 2, ( -pegD - pegW ) / 2, -pegH ] ) {
            cube( [ clipWidth, pegW, pegH ] );
        }
    }
}
