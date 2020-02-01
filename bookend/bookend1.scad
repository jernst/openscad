//
//
//

use <wedges.scad>

module Bookend1(
        length,
        width,
        height,
        t1,
        t2 )
{
    ratio  = height / (( width - t1 ) / 2 );
    ratio2 = height / length;

    difference() {
        // cut out from a cube
        translate( [ $eps, $eps, $eps ] ) {
            cube( [ length-2*$eps, width-2*$eps, height-2*$eps ]);
        }

        // cut out left wedge in x direction
        translate( [ 0, (width-t1)/2, 0 ] )
        mirror( [ 0, 1, 0 ] )
        rotate( 90, [ 0, 0, 1 ] )
        rotate( 90, [ 1, 0, 0 ] ) {
            Wedge( (width-t1)/2, height, length );
        };

        // cut out right wedge in x direction
        translate( [ 0, (width+t1)/2, 0 ] )
        rotate( 90, [ 0, 0, 1 ] )
        rotate( 90, [ 1, 0, 0 ] ) {
            Wedge( (width-t1)/2, height, length );
        };

        // cut out biwedge (inner of V) in x direction
        translate( [ 0, t1, height ] )
        mirror( [ 0, 0, 1 ] )
        rotate( 90, [ 0, 0, 1 ] )
        rotate( 90, [ 1, 0, 0 ] ) {
            BiWedge( width-2*t1, ratio * ( width-2*t1)/2, length );
        };

        // flatten to the right
        translate( [ 0, 0, height ] )
        rotate( -90, [ 1, 0, 0 ]) {
            Wedge( length, height, width );
        };

        // cut out hole in y direction
        myh = height - t2 - t2*ratio2 - t2*sqrt(1+ratio2*ratio2);
        myl = length - t2 - t2/ratio2 - t2*sqrt(1+1/(ratio2*ratio2));
        translate( [ t2, 0, t2 ] )
        translate( [ myl, 0, 0 ] )
        rotate( 180, [ 0, 0, 1 ] )
        rotate( 90,  [ 1, 0, 0 ] ) {
            Wedge( myl, myh, width );
        }
    };
};

