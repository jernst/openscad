//
//
//

$foot_w = 150;
$foot_d = 150;
$foot_h1 =  4;
$foot_r  =  3;
$foot_h2 = $foot_h1 + 2*$foot_r;
$rim_w   = 10;

$rib_w = 120;
$rib_d =  10;
$rib_h = 150;
$rib_gap_d = 25;

$board_l = 350;
$board_w = 275;
$board_above_ground = 10;

$alpha = atan( $board_l / $board_w );

$standoff_h = 3*$rib_gap_d + 3*$rib_d;
$standoff_r = 4;


$standoffPoints_x = [
    $standoff_r,
    $standoff_r +   ( $rib_w - 2*$standoff_r )/3,
    $standoff_r + 2*( $rib_w - 2*$standoff_r )/3,
    $rib_w - $standoff_r
];
$standoffPoints_y = [
    ( $foot_w/2 - $standoffPoints_x[0] ) * tan( $alpha ),
    ( $foot_w/2 - $standoffPoints_x[1] ) * tan( $alpha ),
    ( $standoffPoints_x[2] - $foot_w/2 ) / tan( $alpha ),
    ( $standoffPoints_x[3] - $foot_w/2 ) / tan( $alpha )
];

$fn = 64;

module Rib() {
    #cube( [ $rib_w, $rib_d, $rib_h ] );
}

module Standoff() {
    cylinder( $standoff_h, $standoff_r, $standoff_r );
}

union() {
    // foot
    difference() {
        intersection() {
            cube( [ $foot_w, $foot_d, $foot_h2 ]);

            translate( [ $foot_r, $foot_r, - $foot_r ] )
            minkowski() {
                cube( [ $foot_w - 2*$foot_r, $foot_d - 2*$foot_r, $foot_h2 ]);
                sphere( r=$foot_r );
            }
        }
        translate( [ $rim_w + $foot_r, ( $foot_d - 3*$rib_gap_d - 2*$rib_d ) / 2 + $foot_r, $foot_h1+$foot_r ] )
        minkowski() {
            cube( [ $foot_w - 2*$rim_w - 2*$foot_r, 3*$rib_gap_d + 2*$rib_d - 2*$foot_r, $foot_h2 ]); // higher than necessary
            sphere( r=$foot_r );
        }
    }

    // ribs
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

    // standoffs
    for( i=[0:3] ) {
        translate( [ ( $foot_w - $rib_w ) / 2 + $standoffPoints_x[i], $standoff_h + ( $foot_d - $standoff_h ) / 2, $standoffPoints_y[i] + $foot_h2 + $board_above_ground ] )
        rotate( 90, [1, 0, 0 ]) {
            Standoff();
        }
    }
}
