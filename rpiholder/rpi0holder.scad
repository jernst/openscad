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

module Pin() {
    union() {
        cylinder( h = 15, r1 = 1.5, r2 = 1.25);
        cylinder( h = 12, r1 = 2.5, r2 = 2.5);
    }
}

module Holder() {
    translate( [ 0, ($w-$rpi_w)/2, 0 ] ) {
        Pin();
    }
    translate( [ $rpi_l, ($w-$rpi_w)/2, 0 ] ) {
        Pin();
    }
    translate( [ 0, ($w+$rpi_w)/2, 0 ] ) {
        Pin();
    }
    translate( [ $rpi_l, ($w+$rpi_w)/2, 0 ] ) {
        Pin();
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
