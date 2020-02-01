module Pegs( maxx, maxy, dx, dy, r, h ) {
    for( y = [0:dy:maxy] ) {
        for( x = [0:dx:maxx] ) {
            translate( [ x, y, 0 ] ) {
                cylinder( h=h, r=r );
            }
        }
    }
}
