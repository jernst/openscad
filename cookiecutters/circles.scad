//
// Circle-shaped cookie cutter with small circles around it
//

$r  = 20; // radius of the circle on whose perimeter the centers of the smaller circles are
$h  = 15; // total height of the cutter
$n  =  8; // number of the smaller circles around the perimeter
$w  =  1; // wall thickness
$fw =  3; // foot wall thickness
$fh =  1; // foot height

$fn=64;

alpha = 360/$n;

r_small = $r * tan( alpha/2 );

difference() {
    union() {
        linear_extrude( height=$h ) {
            union() {
                circle( r=$r );
                for( i=[0:$n-1] ) {
                    minkowski() {
                        translate( [ $r * cos( i*alpha ), $r * sin( i*alpha ) ] ) {
                            circle( r=r_small );
                        }
                        circle( r=$w );
                    }
                }
            }
        }
        linear_extrude( height=$fh ) {
            union() {
                circle( r=$r );
                for( i=[0:$n-1] ) {
                    minkowski() {
                        translate( [ $r * cos( i*alpha ), $r * sin( i*alpha ) ] ) {
                            circle( r=r_small );
                        }
                        circle( r=$fw );
                    }
                }
            }
        }
        // This makes the thing easier to clean
        translate( [0, 0, $fh ] ) {
            linear_extrude( height=$fh*3, scale=0.9 ) {
                union() {
                    circle( r=$r );
                    for( i=[0:$n-1] ) {
                        minkowski() {
                            translate( [ $r * cos( i*alpha ), $r * sin( i*alpha ) ] ) {
                                circle( r=r_small );
                            }
                            circle( r=$fw );
                        }
                    }
                }
            }
        }
    }
    union() {
        linear_extrude( height=$h ) {
            union() {
                circle( r=$r );
                for( i=[0:$n-1] ) {
                    translate( [ $r * cos( i*alpha ), $r * sin( i*alpha ) ] ) {
                        circle( r=r_small );
                    }
                }
            }
        }
    }
}
