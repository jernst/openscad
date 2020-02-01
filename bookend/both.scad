
use <bookend1.scad>
use <bookend2.scad>

$scale  = 0.25;
$length = 150 * $scale;
$width  = 150 * $scale;
$height = 150 * $scale;
$t1     = $width/4;
$t2     = 0.4 * $t1;
$eps    = 0.1;
$fa     = 5;

Bookend1( 
        $length,
        $width,
        $height,
        $t1,
        $t2 );

translate( [ $length * 1.2, $width, 0 ] )
rotate( 180, [ 0, 0, 1 ] )
{
    !Bookend2( 
            $length,
            $width,
            $height,
            $t1,
            $t2 );
};
