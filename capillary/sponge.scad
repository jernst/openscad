//
//
//

$fn = 32;

wall = 0.8;

step = 1.6;
maxX = 12;
maxY = 12;
eps = 0.01;

difference() {
    union() {
        cube( [ maxX, maxY, 5 ] );

        for( x = [0:step:maxX-wall] ) {
            translate( [ x, 0, 1 ] ) {
                cube( [ wall, maxY, 18 ] );
            }
        }
        for( y = [0:step:maxY-wall] ) {
            translate( [ 0, y, 1 ] ) {
                cube( [ maxX, wall, 18 ] );
            }
        }
    }
    for( x = [wall:step:maxX] ) {
        translate( [ x, -eps, 1 ] ) {
            cube( [ wall, maxY+2*eps, 6 ] );
        }
    }
    for( y = [wall:step:maxY] ) {
        translate( [ -eps, y, 1 ] ) {
            cube( [ maxX+2*eps, wall, 6 ] );
        }
    }
    #translate( [ maxX/2, maxY/2, 11+eps ] ) {
        cylinder( h = 8, r1 = 0, r2 = 6 );
    }
}
