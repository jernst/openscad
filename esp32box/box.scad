$fn = 64;
wall = 2;
eps  = 0.01;
play = 0.1;

module boxBottom( w, d, h ) {
    cube( [ w, d, wall ] );

    cube( [ wall, d, h ] );

    cube( [ w, wall, h ] );

    translate( [ w-wall, 0, 0 ] )
    cube( [ wall, d, h ] );

    translate( [ 0, d-wall, 0 ] )
    cube( [ w, wall, h ] );
    
}

module boxTop( w, d, h ) {
    bump = 2;
    cornerR = 2;
    cornerOff = cornerR + wall + play;

    cube( [ w, d, wall ] );

    translate( [ cornerOff, cornerOff, wall - eps ] )
    cylinder( r=cornerR, h=bump+eps );

    translate( [ w - cornerOff, cornerOff, wall - eps ] )
    cylinder( r=cornerR, h=bump+eps );

    translate( [ cornerOff, d - cornerOff, wall - eps ] )
    cylinder( r=cornerR, h=bump+eps );

    translate( [ w - cornerOff, d - cornerOff, wall - eps ] )
    cylinder( r=cornerR, h=bump+eps );

    translate( [ 0, 0, wall - eps ] )
    difference() {
        linear_extrude( bump+eps )
        polygon( [
            [ cornerOff, cornerOff - cornerR ],
            [ w - cornerOff, cornerOff - cornerR ],
            [ w - cornerOff, cornerOff ],
            [ w - cornerOff + cornerR, cornerOff ],
            [ w - cornerOff + cornerR, d - cornerOff ],
            [ w - cornerOff,           d - cornerOff ],
            [ w - cornerOff,           d - cornerOff + cornerR ],
            [ cornerOff,               d - cornerOff + cornerR ],
            [ cornerOff,               d - cornerOff ],
            [ cornerOff - cornerR,     d - cornerOff ],
            [ cornerOff - cornerR,     cornerOff ],
            [ cornerOff,               cornerOff ],
        ] );
        
        translate( [ cornerOff, cornerOff, 0 ] )
        cube( [ w - 2*cornerOff, d - 2*cornerOff, bump *2 ] ); 
    }
}


// boxBottom( 80, 80, 32 );

// translate( [ 0, 80, 40 ] )
// rotate( [ 180, 0, 0 ] )

boxTop( 80, 80, 20 );

