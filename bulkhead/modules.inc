module toolCube() {
    chamfer = 1;
    translate( [ -toolCubeD/2 + chamfer, -toolCubeD/2 + chamfer, 0 ] ) {
        minkowski() {
            cube( [ toolCubeD - 2 * chamfer, toolCubeD - 2 * chamfer, toolCubeH ] );
            sphere( r=chamfer );
        }
    }
}

module disk() {
    translate( [ 0, 0, 8 - eps ] ) {
        toolCube();
    }

    difference() {
        cylinder( r = 30, h = 8 );

        // o-ring groove
        rotate_extrude(convexity = 10)
        translate( [ oRingD/2, 0, 0] )
        circle( d = oRingT );
    }
}
