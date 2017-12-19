//
//
//

$foot_w     = 150;
$foot_d     = 150;
$foot_h1    =   4;
$foot_r     =   3;
$foot_h2    = $foot_h1 + 2*$foot_r;

$rib_w = 120;
$rib_d =  10;
$rib_h = 135;
$rib_gap_d = 25;

$rim_w      = ( $foot_w - $rib_w )/2;
$rim_ramp_w =  20;

$board_l = 350;
$board_w = 275;
$board_above_ground = 10;

$alpha = atan( $board_l / $board_w );

$standoff_h = 3*$rib_gap_d + 3*$rib_d;
$standoff_r = 6;
$standoff_support_h = $rib_gap_d * 0.88; // a bit more than 30 deg

$standoffPoints_x = [
    $standoff_r+3,
    $standoff_r+1 +   ( $rib_w - 2*$standoff_r )/3,
    $standoff_r-1 + 2*( $rib_w - 2*$standoff_r )/3,
    $rib_w-3 - $standoff_r
];
$standoffPoints_y = [
    ( $rib_w/2 - $standoffPoints_x[0] ) * tan( $alpha ) + $board_above_ground,
    ( $rib_w/2 - $standoffPoints_x[1] ) * tan( $alpha ) + $board_above_ground,
    ( $standoffPoints_x[2] - $rib_w/2 ) / tan( $alpha ) + $board_above_ground,
    ( $standoffPoints_x[3] - $rib_w/2 ) / tan( $alpha ) + $board_above_ground
];

$fn = 64;

module Rib() {
    // cube( [ $rib_w, $rib_d, $rib_h ] );
    translate( [ 0, $rib_d, 0 ] )
    rotate( 90, [ 1, 0, 0 ] ) {
        linear_extrude(height = $rib_d) import("rib-outline.dxf");
    }
    for( h=[0:($rib_h-$foot_h2-$rib_d)/18:$rib_h-$foot_h2-$rib_d] ) {
        l = $rib_w/2-h*.2;
        translate( [ $rib_w - l, $rib_d/2, $foot_h2 + h ] )
        rotate( 90, [0, 1, 0 ] ) {
            cylinder( l, $rib_d/2, $rib_d/2 );
        }
    }
}

module Standoff() {
    union() {
        cylinder( $standoff_h, $standoff_r, $standoff_r );

        translate( [ -$standoff_r, -$standoff_support_h, 0 ]) {
            difference() {
                cube( [ 2*$standoff_r, $standoff_support_h, $standoff_h ] );

                for( i=[0:2] ) {
                    translate( [ 2*$standoff_r, 0, i * ($rib_gap_d + $rib_d ) + $rib_d/2 ] )
                    rotate( -90, [0, 1, 0 ] ) {
                        linear_extrude( height=2*$standoff_r ) {
                            polygon( [ [ 0, 0 ], [ $rib_gap_d, 0 ], [ $rib_gap_d/2, $standoff_support_h ]] );
                        }
                    }
                }
            }
        }
    }
}

union() {
    // foot
if( true ) {
    difference() {
        // the main foot with an rounded corner at the top
        intersection() {
            cube( [ $foot_w, $foot_d, $foot_h2 ]);

            translate( [ $foot_r, $foot_r, - $foot_r ] )
            minkowski() {
                cube( [ $foot_w - 2*$foot_r, $foot_d - 2*$foot_r, $foot_h2 ]);
                sphere( r=$foot_r );
            }
        }

        // the pan -- main part
        translate( [ $rim_w + $rim_ramp_w, ( $foot_d - 3*$rib_gap_d - 2*$rib_d )/2, $foot_h1 ] ) {
            cube( [ $foot_w - 2*$rim_w - 2*$rim_ramp_w, 3*$rib_gap_d + 2*$rib_d, $foot_h2 ]); // higher than necessary
        }

        // the pan -- ramps
        translate( [ $rim_w , ( $foot_d + 3*$rib_gap_d + 2*$rib_d )/2, $foot_h2 ] ) {
            rotate( 90, [ 1, 0, 0] )
            linear_extrude( height = 3*$rib_gap_d + 2*$rib_d ) {
                polygon( [[0, 0], [ $rim_ramp_w, $foot_h1 - $foot_h2 ], [ $rim_ramp_w, 0 ]] );
            }
        }
        translate( [ $foot_w - $rim_w , ( $foot_d + 3*$rib_gap_d + 2*$rib_d )/2, $foot_h2 ] ) {
            rotate( 90, [ 1, 0, 0] )
            linear_extrude( height = 3*$rib_gap_d + 2*$rib_d ) {
                polygon( [[0, 0], [ -$rim_ramp_w, $foot_h1 - $foot_h2 ], [ -$rim_ramp_w, 0 ]] );
            }
        }
    }
}

    // ribs
if( true ) {
    translate( [ ( $foot_w - $rib_w ) / 2, ( $foot_d - $rib_d ) / 2 - ( $rib_gap_d + $rib_d ) * 1.5, 0 ] ) {
        Rib();
    }
    translate( [ ( $foot_w - $rib_w ) / 2, ( $foot_d - $rib_d ) / 2 - ( $rib_gap_d + $rib_d ) * 0.5, 0 ] ) {
        Rib();
    }
    translate( [ ( $foot_w - $rib_w ) / 2, ( $foot_d - $rib_d ) / 2 + ( $rib_gap_d + $rib_d ) * 0.5, 0 ] ) {
        Rib();
    }
    translate( [ ( $foot_w - $rib_w ) / 2, ( $foot_d - $rib_d ) / 2 + ( $rib_gap_d + $rib_d ) * 1.5, 0 ] ) {
        Rib();
    }
}
    // standoffs
if( true ) {
    for( i=[0:3] ) {
        translate( [ ( $foot_w - $rib_w ) / 2 + $standoffPoints_x[i], $standoff_h + ( $foot_d - $standoff_h ) / 2, $standoffPoints_y[i] + $foot_h2 ] )
        rotate( 90, [1, 0, 0 ]) {
            Standoff();
        }
    }
}
}

