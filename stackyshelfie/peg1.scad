include <constants.scad>

peg( 20 );

module peg( height ) {
    translate( [ $dx_unit/2, $dy_unit/2, $play ] ) {
        cylinder( h = $dz_unit + $eps, r = $r_inner-$play );
    };
    translate( [ $dx_unit/2, $dy_unit/2, $dz_unit/2 + $play ] ) {
        cylinder( h = $dz_unit/2 + $eps, r = $r_outer-$play );
    };
    translate( [ 0, 0, $dz_unit + $play ] ) {
        cube( [ $dx_unit-2*$play, $dy_unit-2*$play, height ] );
    };
};
