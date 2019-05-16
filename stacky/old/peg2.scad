
include <constants.scad>


peg( 30 );

module peg( h ) {
    difference() {
        cube( [ $dx_unit, $dy_unit, h ] );

        translate( [ $dx_unit/2, $dy_unit/2, 0 ] )
        rotate_extrude( angle=360 ) {

            translate( [ $r1, -$eps, 0 ] ) {
                union() {
                    square( [ $dx_unit, 5+3 ] );
                    translate( [ $r2 - $r1, 5+3, 0 ] ) {
                        circle( r = $r2 - $r1 );
                    }
                    translate( [ $r2 - $r1, 0, 0 ] ) {
                        square( [ $dx_unit - ( $r2 - $r1 ), 5 + 3 + ( $r2 - $r1 )] );
                    }
                }
            }
        };

        translate( [ $dx_unit/2, $dy_unit/2, h - 5 ] ) {
            cylinder( r = $r1, h = 5 );
        };
    }
};
