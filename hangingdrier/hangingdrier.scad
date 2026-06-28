postD  = 12;
bevelR = 5;
cylW   = 16;
cylR2  = 10;
cylR1  = 5;
postH  = 160;
footH  = 6;

eps    = 0.01;
$fn    = 64;

module post() {
    translate( [ -postD/2, -postD/2, footH-eps ] )
    cube( [ postD, postD, postH ] );
}

module hanger_holder() {
    difference() {
        cylinder( r=cylR2, h=cylW );

        translate( [ -eps, 0, -eps ] )
        cylinder( r=cylR1, h=cylW+2*eps );
    }
}

module collar_side( ) {
    translate( [ -postD/2-eps, 0, 0 ] )
    rotate( [ 0, 90, 0 ] )
    cylinder( r=bevelR, h=postD+2*eps );

    translate( [ postD/2, bevelR, 0 ] )
    rotate( [ 0, 0, -90 ] )
    rotate_extrude( angle = 90, convexity = 10 ) {
        translate( [ bevelR, 0, 0 ] )
        circle( r=bevelR );
    }
}

module collar() {
    translate( [ 0, -postD/2 - bevelR, bevelR ] )
    collar_side();
    
    translate( [ postD/2 + bevelR, 0, bevelR ] )
    rotate( [ 0, 0, 90 ] )
    collar_side();
    
    translate( [ 0, postD/2 + bevelR, bevelR ] )
    rotate( [ 0, 0, 180 ] )
    collar_side();

    translate( [ -postD/2 - bevelR, 0, bevelR ] )
    rotate( [ 0, 0, 270 ] )
    collar_side();
}

module foot_bevel() {
    difference() {
        union() {
            translate( [ -postD/2, -postD/2 -bevelR, 0 ] )
            cube( [ postD, postD + 2*bevelR, bevelR ] ); 

            translate( [ -postD/2 - bevelR, -postD/2, 0 ] )
            cube( [ postD + 2*bevelR, postD, bevelR ] ); 
        
            for( i = [ [ -1, -1 ], [ -1, 1 ], [ 1, 1 ], [ 1, -1 ]] ) {
                translate( [ i[0] * postD/2, i[1] * postD/2, 0 ] )
                cylinder( r=bevelR, h=bevelR );
            }
        };

        collar();
    }
}

module foot() {
    linear_extrude( height = footH ) {
        polygon( [
            [ -30, -20 ],
            [ 30,  -20 ],
            [ 40,  -10 ],
            [ 40,   10 ],
            [ 30,   20 ],
            [ -30,  20 ],
            [ -40,  10 ],
            [ -40, -10 ],
        ] );
    }
    
    translate( [ 0, 0, footH ] )
    foot_bevel();
}

// module hangingdrier() {
    post();
    foot();

    translate( [ -cylW/2, 0, postH + footH + cylR2 - cylR1 ] )
    rotate( [ 0, 90, 0 ] )
    hanger_holder();
// }

// hangingdrier();
