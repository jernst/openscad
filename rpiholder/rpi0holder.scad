//
//
//

use <../lib/Standoff.scad>

$l = 200;
$w = 120;
$t =   2;

$rpi_w = 23;
$rpi_l = 58.5;

$holder_l    = 10;
$holder_w    = 10;
$standoff_h  =  8;
$standoff_r  =  3;
$m3CutHole_r =  2.7/2;    // radius of hole into which self-cutting M3 scews cut into --empirically

module Holder() {
    union() {
        translate( [ 0, 0, $t/2 ] ) {
            Standoff(
                    height     = $standoff_h,
                    radius     = $standoff_r,
                    holeDepth  = $standoff_h,
                    holeRadius = $m3CutHole_r );
        }
        translate( [ $rpi_w, 0, $t/2 ] ) {
            Standoff(
                    height     = $standoff_h,
                    radius     = $standoff_r,
                    holeDepth  = $standoff_h,
                    holeRadius = $m3CutHole_r );
        }
        translate( [ 0, $rpi_l, $t/2 ] ) {
            Standoff(
                    height     = $standoff_h,
                    radius     = $standoff_r,
                    holeDepth  = $standoff_h,
                    holeRadius = $m3CutHole_r );
        }
        translate( [ $rpi_w, $rpi_l, $t/2 ] ) {
            Standoff(
                    height     = $standoff_h,
                    radius     = $standoff_r,
                    holeDepth  = $standoff_h,
                    holeRadius = $m3CutHole_r );
        }
    }
}

union() {
    cube( [ $l, $w, $t ]);

    // off-center, so ports are accessible
    translate( [ 25, ( $w - $rpi_l ) / 2, $t ] ) {
        Holder();
    };

    translate( [ $l/2 + 25, ( $w - $rpi_l ) / 2, $t ] ) {
        Holder();
    };
}
