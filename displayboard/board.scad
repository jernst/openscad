include <constants.scad>

use <pegs.scad>

difference() {
    cube( [ $length, $width, 4 ] );
    translate( [ $gridX/2, $gridY/2, 2 ] ) {
        Pegs( $length, $width, $gridX, $gridY, $pegsR, 20 );
    }
}

