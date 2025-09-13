h = 210;
w = 70;
d = 40;
eps = 0.01;

difference() {
    cube([ w, d, h ]);

    translate( [ 10, 17, -eps ] ) {
        cube([ w - 2*10, 6, h + 2*eps]);
    }
    
    translate( [ w/2, d+eps, 0 ] ) {
        rotate( a=90, v=[ 1, 0, 0] ) {
            scale([ 1, h/w*3, 1]) {
                cylinder( h = d+2*eps, r = w*0.3 );
            }
        }
    }

    translate( [ 0, d/2, 0 ] ) {
        rotate( a=90, v=[ 0, 0, 1] )
        rotate( a=90, v=[ 1, 0, 0] ) {
            scale([ 1, h/d*3, 1]) {
                cylinder( h = w+2*eps, r = d*0.3 );
            }
        }
   }
}
