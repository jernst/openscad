//
//
//

$length = 140;
$width  =  80;
$height =  20;
$t      =   3;
$t2     =   5;
$hole   =   6;

difference() {
    union() {
        // the cross
        translate( [ -$length/2 , -$hole/2-$t, 0 ] ) {
            cube( [ $length, $hole + 2*$t, $t2 ] );
        };
        translate( [ -$hole/2-$t, -$width/2, 0 ] ) {
            cube( [ $hole + 2*$t, $width, $t2 ] );
        };

        // the cubes
        translate( [ -$length/2, -$hole/2-$t, 0 ] ) {
            cube( [ $hole + 2*$t, $hole + 2*$t, $height ] );
        };
        translate( [ $length/2-$hole - 2*$t, -$hole/2-$t, 0 ] ) {
            cube( [ $hole + 2*$t, $hole + 2*$t, $height ] );
        };
        translate( [ -$hole/2-$t, -$width/2, 0 ] ) {
            cube( [ $hole + 2*$t, $hole + 2*$t, $height ] );
        };
        translate( [ -$hole/2-$t, $width/2-$hole-2*$t, 0 ] ) {
            cube( [ $hole + 2*$t, $hole + 2*$t, $height ] );
        };
    };

    translate( [ -$length/2+$t, -$hole/2, -1 ] ) {
        cube( [ $hole, $hole, $height+2 ] );
    };
    translate( [ $length/2-$hole-$t, -$hole/2, -1 ] ) {
        cube( [ $hole, $hole, $height+2 ] );
    };
    translate( [ -$hole/2, -$width/2+$t, -1 ] ) {
        cube( [ $hole, $hole, $height+2 ] );
    };
    translate( [ -$hole/2, $width/2-$hole-$t, -1 ] ) {
        cube( [ $hole, $hole, $height+2 ] );
    };
};
