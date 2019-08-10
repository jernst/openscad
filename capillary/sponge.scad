//
//
//

wall = 0.8;

step = 1.6;
maxX = 11.2;
maxY = 11.2;

union() {
    cube( [ maxX+wall, maxY+wall, 3 ] );

    for( x = [0:step:maxX] ) {
        for( y = [0:step:maxY] ) {
            translate( [ x, y, 1 ] ) {
                cube( [ wall, wall, 18 ] );
            }
        }
        for( z = [6:3:18] ) {
            translate( [ x, 0, z ] ) {
                cube( [ wall, maxY+wall, wall ] );
            }
        }        
    }
    for( y = [0:5:maxY] ) {
        for( z = [6:6:18] ) {
            translate( [ 0, y, z ] ) {
                cube( [ maxX+wall, wall, wall ] );
            }
        }
    }
}
