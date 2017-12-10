//
// Star-formed cookie cutter
//

$r  = 25; // radius of the circle on which the outer points of the star lie
$h  = 15; // total height of the cutter
$n  =  6; // number of rays
$w  =  1; // wall thickness
$fw =  3; // foot wall thickness
$fh =  1; // foot height

$fn=64;

alpha = 360 / $n;

P = [ for( i=[ 0 : 1 : $n-1 ] ) [ $r * cos( i * alpha ), $r * sin( i * alpha ) ]];

difference() {
    union() {
        linear_extrude( height=$h ) {
            for( i=[ 0 : 1 : $n-1 ] ) {
                minkowski() {
                    polygon( [ [ 0, 0 ], P[i], P[(i+2) % $n ]]);
                    circle( r=$w );
                }
            }
        }
        linear_extrude( height=$fh ) {
            for( i=[ 0 : 1 : $n-1 ] ) {
                minkowski() {
                    polygon( [ [ 0, 0 ], P[i], P[(i+2) % $n ]]);
                    circle( r=$fw/2 );
                }
            }
        }
        // This makes the thing easier to clean
        translate( [0, 0, $fh ] ) {
            linear_extrude( height=$fh*3, scale=0.9 ) {
                for( i=[ 0 : 1 : $n-1 ] ) {
                    minkowski() {
                        polygon( [ [ 0, 0 ], P[i], P[(i+2) % $n ]]);
                        circle( r=$fw );
                    }
                }
            }
        }
    }
    linear_extrude( height=$h ) {
        for( i=[ 0 : 1 : $n-1 ] ) {
            polygon( [ [ 0, 0 ], P[i], P[(i+2) % $n ]]);
        }
    }
}
