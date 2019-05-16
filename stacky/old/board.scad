

include <constants.scad>
$version = "V1";

board( 4, 5 );

module board( xu, yu ) {
    difference() {
        cube( [ xu * $dx_unit, yu * $dy_unit, $dz_unit/2 ] );
        for( ix = [ 0 : xu-1 ] ) {
            for( iy = [ 0 : yu-1 ] ) {
                translate( [ ix * $dx_unit + $dx_unit/2, iy * $dy_unit + $dy_unit/2, -$eps ] ) {
                     cylinder( h = $dz_unit/2 + 2 * $eps, r = 2+iy*0.5 );
                }
            }
        }
        translate( [5, 10, 4] ) {
            linear_extrude( h=2 ) {
                text( $version, font = "Liberation Sans", valign="center", size=4);
            }
        }
    }
};

