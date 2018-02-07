//
//
//

$l = 200;
$w = 120;
$t =   2;

$rpi_w = 70;
$rpi_l = 95;

$holder_l = 10;
$holder_w = 10;
$holder_h = 20;

module Holder() {
    difference() {
        union() {
            translate( [ -$t, -$t, -1 ] ) {
                cube( [ $holder_w, $holder_l, $holder_h+1 ]);
            }
            translate( [ -$t, $rpi_l - $holder_l + $t, -1 ] ) {
                cube( [ $holder_w, $holder_l, $holder_h+1 ]);
            }
            translate( [ $rpi_w - $holder_w + $t, -$t, -1 ] ) {
                cube( [ $holder_w, $holder_l, $holder_h+1 ]);
            }
            translate( [ $rpi_w - $holder_w + $t, $rpi_l - $holder_l + $t, -1 ] ) {
                cube( [ $holder_w, $holder_l, $holder_h+1 ]);
            }
        };
        cube( [ $rpi_w, $rpi_l, $holder_h+1 ]);
    }
}

union() {
    cube( [ $l, $w, $t ]);

    translate( [ ( $l - 2*$rpi_w ) / 3, ( $w - $rpi_l ) / 2, $t ] ) {
        Holder();
    };

    translate( [ 2 * ( $l - 2*$rpi_w ) / 3 + $rpi_w, ( $w - $rpi_l ) / 2, $t ] ) {
        Holder();
    };
}
