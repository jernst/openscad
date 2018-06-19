//
// A grid insert for a plastic bowl
//

$w   = 140;  // width
$t_w =   2;  // thickness in width direction
$t_h =   5;  // thickness in height direction

$w_n = 4;    // number of segments in width direction
$d_n = 3;    // number of segments in depth direction

$d   = $w;   // depth
$t_d = $t_w; // thickness in depth direction

union() {
    // outside ring
	difference() {
		cylinder( h=$t_h, d1=$w,        d2=$d );
		translate( [ 0, 0, -1 ] ) {
			cylinder( h=$t_h+2, d1=$w-2*$t_w, d2=$d-2*$t_d );
		}
	}
	
	// inside griddle limited by ring
	intersection() {
		translate( [ 0, 0, -1 ] ) {
			cylinder( h=$t_h+2, d1=$w-$t_w, d2=$d-$t_d );
		}
	
		// griddle
		union() {
			for( i = [1 : $w_n-1 ] ) {
				translate( [ -$w/2 + i*(( $w - $t_w )/$w_n ), -$d/2, 0 ] ) {
					cube( [ $t_w, $d, $t_h ] );
				}
			}
			for( i = [1 : $d_n-1 ] ) {
				translate( [ -$w/2, -$d/2 + i*(( $d - $t_d )/$d_n ), 0 ] ) {
					cube( [ $w, $t_d, $t_h ] );
				}
			}
		}
	}
}
