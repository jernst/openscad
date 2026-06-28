//
// Plain circle-shaped cookie cutter
//

$r  = 32.5; // radius of the circle
$h  = 15; // total height of the cutter
$w  =  1; // wall thickness
$fw =  3; // foot wall thickness
$fh =  1; // foot height
eps = 0.01;

$fn=64;

module makeCookieCutter() {

    difference() {
        union() {
            linear_extrude( height=$h ) {
                minkowski() {
                    children();
                    circle( r=$w );
                }
            }
            linear_extrude( height=$fh ) {
                minkowski() {
                    children();
                    circle( r=$fw );
                }
            }
            // This makes the thing easier to clean
            translate( [0, 0, $fh ] ) {
                linear_extrude( height=$fh*3, scale=0.9 ) {
                    minkowski() {
                        children();
                        circle( r=$fw );
                    }
                }
            }
        }
        translate([0, 0, -eps])
        linear_extrude( height=$h+2*eps ) {
            children();
        }
    }
}

makeCookieCutter() {
    circle( r=$r );
}
