//
//
//

$l = 60;
$w = 30;
$t =  1.4;
$eps = 0.01;
$play = 0.05;

$fn = 36;

$rpi_w = 23;
$rpi_l = 58.5;

module Pin1() {
    union() {
        cylinder( h = 15, r1 = 1.5, r2 = 1.25);
        cylinder( h = 12, r1 = 2.5, r2 = 2.5);
    }
}
module Pin2() {
    difference() {
        cylinder( h = 12, r1 = 2.5, r2 = 2.5);
        translate( [ 0, 0, 5 ] ) {
            cylinder( h = 8, r1 = 0.9, r2 = 0.9);
        }
    }
}


module Holder() {
    translate( [ 0, ($w-$rpi_w)/2, 0 ] ) {
        Pin1();
    }
    translate( [ $rpi_l, ($w-$rpi_w)/2, 0 ] ) {
        Pin2();
    }
    translate( [ 0, ($w+$rpi_w)/2, 0 ] ) {
        Pin2();
    }
    translate( [ $rpi_l, ($w+$rpi_w)/2, 0 ] ) {
        Pin1();
    }
}

union() {
    difference() {
        translate( [ $play, $play, 0 ] ) {
            cube( [ $l-$play, $w-$play, $t ]);
        }
        for( ix = [ 5:10:55 ] ) {
            for( iy = [ 5:10:25 ] ) {
                translate( [ ix, iy, -$eps ] ) {
                    cylinder( h = $t + 2*$eps, r = 3 );
                }
            }
        }
    }
    Holder();
}
