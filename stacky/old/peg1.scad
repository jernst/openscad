include <constants.scad>

peg( 20 );

$r = 3;

module peg( height ) {
    translate( [ $dx_unit/2, $dy_unit/2, $play ] ) {
        cylinder( h = $dz_unit/2 + $eps, r1 = $r, r2 = $r + $play );
    };
    translate( [ 0, 0, $dz_unit/2 + $play ] ) {
        cube( [ $dx_unit-2*$play, $dy_unit-2*$play, height ] );
    };
};
