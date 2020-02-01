//
//
//

$mmPerInch = 25.4;
$fn=50;

$width  = 12 * $mmPerInch;
$height =  6 * $mmPerInch;
$depth  =  3;
$outerR =  3;
$holeR  =  2;
$holeDW =  7 * $mmPerInch;
$holeDH = ( 4 + 11/16 ) * $mmPerInch;
$holeMargin = 6;

$bW     = 10;
$bH     = $bW;

module PlateHolder() {
    // main frame
    difference() {
        translate( [ $outerR, $outerR, 0 ] ) 
        minkowski() {
            cube( [ $width-$outerR*2, $height-$outerR*2, $depth-1 ] );
            cylinder( r=$outerR, h=1 );
        };

        // inner main cutout
        translate( [ $bW, $bH, -1 ] ) {
            cube( [ $width - 2*$bW, $height - 2*$bH, $depth+2 ] );
        };
    };

    // holders of the screw holes
    difference() {

        union() {
            translate( [ ( $width - $holeDW )/2 - $holeR - $holeMargin, $height - ( $height - $holeDH )/2 - $holeR - $holeMargin, 0 ] ) {
                cube( [ $holeDW + 2 * ( $holeR + $holeMargin ), ( $height - $holeDH )/2 + $holeR + $holeMargin, $depth ] );
            };
            translate( [ ( $width - $holeDW )/2 - $holeR - $holeMargin, 0, 0 ] ) {
                cube( [ $holeDW + 2 * ( $holeR + $holeMargin ), ( $height - $holeDH )/2 + $holeR + $holeMargin, $depth ] );
            };
        }


        // screw holes

        translate( [ ( $width - $holeDW )/2, ( $height - $holeDH )/2, -1 ] ) {
            cylinder( r=$holeR, h=$depth+2 );
        };
        translate( [ ( $width + $holeDW )/2, ( $height - $holeDH )/2, -1 ] ) {
            cylinder( r=$holeR, h=$depth+2 );
        };
        translate( [ ( $width - $holeDW )/2, ( $height + $holeDH )/2, -1 ] ) {
            cylinder( r=$holeR, h=$depth+2 );
        };
        translate( [ ( $width + $holeDW )/2, ( $height + $holeDH )/2, -1 ] ) {
            cylinder( r=$holeR, h=$depth+2 );
        };
    };
};


