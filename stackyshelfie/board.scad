

include <constants.scad>

board( 10, 10 );

module board( xu, yu ) {
    difference() {
        cube( [ xu * $dx_unit, yu * $dy_unit, $dz_unit ] );
        for( ix = [ 0 : xu-1 ] ) {
            for( iy = [ 0 : yu-1 ] ) {
                // inner
                translate( [ ix * $dx_unit + $dx_unit/2, iy * $dy_unit + $dy_unit/2, -$eps ] ) {
                     cylinder( h = $dz_unit + 2 * $eps, r = $r_inner );
                }
                // outer
                translate( [ ix * $dx_unit + $dx_unit/2, iy * $dy_unit + $dy_unit/2, ( ix + iy ) % 2 == 0 ? -$eps : $dz_unit / 2 ] ) {
                     cylinder( h = $dz_unit/2 + $eps, r = $r_outer );
                }
            }
        }
    }
};

