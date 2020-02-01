use <wedges.scad>

module Bookend2(
        length,
        width,
        height,
        t1,
        t2 )
{
    ratio  = height / (( width - t1 ) / 2 );
    ratio2 = height / length;

    intersection() {
        union() {
            difference() {
                union() {
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
                };
                
                // cut out hole in y direction
                myh = height - t2 - t2*ratio2 - t2*sqrt(1+ratio2*ratio2);
                myl = length - t2 - t2/ratio2 - t2*sqrt(1+1/(ratio2*ratio2));
                translate( [ t2, -$eps, t2 ] )
                translate( [ myl, 0, 0 ] )
                rotate( 180, [ 0, 0, 1 ] )
                rotate( 90,  [ 1, 0, 0 ] ) {
                    Wedge( myl, myh, width+2*$eps );
                }
            };

            // cut out biwedge (inner of V) in x direction
            translate( [ 0, t1, height ] )
            mirror( [ 0, 0, 1 ] )
            rotate( 90, [ 0, 0, 1 ] )
            rotate( 90, [ 1, 0, 0 ] ) {
                BiWedge( width-2*t1, ratio * ( width-2*t1)/2, length );
            };
        };

        translate( [ length-$eps, -$eps, -$eps ] )
        rotate( 180, [ 0, 0, 1 ] )
        rotate(  90, [ 1, 0, 0 ] ) {
            Wedge( length+2*$eps, height+2*$eps, width+2*$eps );
        }
    };

    translate( [ 0, width/2, height/2 ] )
    rotate( 90, [ 0, 1, 0 ] ) {
        difference() {
            cylinder( t2, width*.35, width*.35, false );
            translate( [ 0, 0, -$eps ] ) {
                cylinder( t2+2*$eps, width*.2, width*.2, false );
            }
        }
    }
};
