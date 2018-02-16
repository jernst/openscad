//
//
//

$l = 200;
$w = 120;
$t =   1.4;

$rpi_w = 23;
$rpi_l = 58.5;

module Pin() {
    union() {
        translate( [ 0, 0, 5 ] ) {
            cylinder( $fn = 36, h = 10, r1 = 1.5, r2 = 1.25, center = true);
        }
        translate( [ 0, 0, 3 ] ) {
            cylinder( $fn = 36, h = 6,  r1 = 2.5, r2 = 2.5, center = true);
        }
    }
}

module Holder() {
    translate( [ 0, 0, 0 ] ) {
        Pin();
    }
    translate( [ $rpi_w, 0, 0 ] ) {
        Pin();
    }
    translate( [ 0, $rpi_l, 0 ] ) {
        Pin();
    }
    translate( [ $rpi_w, $rpi_l, 0 ] ) {
        Pin();
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
