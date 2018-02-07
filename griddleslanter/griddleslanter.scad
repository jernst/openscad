//
//
//

$foot_w = 30;
$foot_d = 40;
$top_d  = 10;

$h        = 30;
$saddle_h = 25;
$saddle_w = 18;

difference() {
    rotate( 90, [ 0, 0, 1 ] )
    rotate( 90, [ 1, 0, 0 ] )
    linear_extrude( height = $foot_w ) {
        polygon( [
            [ 0, 0 ],
            [ $foot_d, 0 ],
            [ ( $foot_d + $top_d ) / 2, $h ],
            [ ( $foot_d - $top_d ) / 2, $h ]
        ] );
    };

    translate( [ ($foot_w - $saddle_w )/2, 0, $saddle_h ]) {
        cube( [ $saddle_w, $foot_d, $h ] );
    }
}
