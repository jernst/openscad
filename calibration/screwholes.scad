// Prints out screw holes, so we can test which are the best size(s)
// for a given self-cutting, or machine screw.
// This goes from r=1mm (M2) to r=4mm (M8) in r=0.1mm (d=0.2mm)
// increments

$grid      = 10;
$height    =  4;
$fn=64;

difference() {
    union() {
        translate( [ -$grid*2/3, -$grid*2/3, 0 ] ) {
            cube( [ 10.5 * $grid, 3.5*$grid, $height/2 ] );
        }
        for( rowi = [0:2] ) {
            for( coli = [0:9] ) {
                radius    = 1 + rowi + coli/10;
                translate = [ coli * $grid , rowi * $grid, 0 ];

                translate( translate ) {
                    cylinder( $height, radius+2, radius+2 );
                }
            }
        }
    }
    union() {
        for( rowi = [0:2] ) {
            for( coli = [0:9] ) {
                radius    = 1 + rowi + coli/10;
                translate = [ coli * $grid , rowi * $grid, -1 ];

                translate( translate ) {
                    cylinder( $height+2, radius, radius );
                }
            }
        }
    }
}

