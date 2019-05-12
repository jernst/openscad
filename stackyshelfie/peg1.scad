include <constants.scad>

peg( 20 );

module peg( height ) {
    translate( [ $dx_unit/2, $dy_unit/2, $play ] ) {
        cylinder( h = $dz_unit + $eps, r1 = $r_inner-$play, r2 = $r_inner-$play/2 );
    };
    translate( [ $dx_unit/2, $dy_unit/2, $dz_unit/2 + $play ] ) {
        cylinder( h = $dz_unit/2 + $eps, r1 = $r_outer-$play, r2 = $r_outer-$play/2 );
    };
    translate( [ 0, 0, $dz_unit + $play ] ) {
        cube( [ $dx_unit-2*$play, $dy_unit-2*$play, height ] );
    };
};
