// numeric constants
eps=0.01;
$fn=128;

// Units are inches
in=25.4;

// Measurements
dRollMax  = 5.5  * in;
wRoll     = 4    * in;
boltR     = 0.15 * in / 2;
boltHeadR = 3/8  * in / 2;

// Key design choices
dAxle     = 1     * in;
wRollPlay = 1/8   * in;
wInset    = 1/2   * in;
wAxlePlay = 1/16  * in;
dAxlePlay = wAxlePlay;
wWallMin  = 1/4   * in;
dWallMin  = wWallMin;
dRollPlay = 1/8   * in;
h         = 5     * in;
stressR   = 1/2   * in;

// consequences
wCutout = wRoll + 2 * wRollPlay;
w       = wCutout + 2 * wInset + 2 * wWallMin;
wAxle   = wCutout + 2 * wInset - 2 * wAxlePlay;
rRound  = dAxle/2 + wAxlePlay + dWallMin;

dd = dWallMin + dRollMax/2 + dRollPlay; // center of the axle


// part 1 -- axle

module axle () {
    cylinder( r=dAxle/2, h=wAxle );
}

// part 2 -- main

module outerShape() {
    // using the variable names from https://en.wikipedia.org/wiki/Tangent_lines_to_circles#With_analytic_geometry
    x0 = -h/2;
    y0 = -dd;
    d0 = sqrt( x0*x0 + y0*y0);
    x1 = rRound * rRound / ( d0*d0 ) * x0 - rRound / ( d0*d0 ) * sqrt( d0*d0 - rRound*rRound ) * (-y0);
    y1 = rRound * rRound / ( d0*d0 ) * y0 - rRound / ( d0*d0 ) * sqrt( d0*d0 - rRound*rRound ) * x0;
    
    rotate( [ 90, 0, 90 ] )
    union () {
        linear_extrude( w ) {
            polygon( [
                [ 0,   0 ],
                [ h,   0 ],
                [ h,   wWallMin ],
                [ h/2 - x1, y1 + dd ],
                [ h/2 + x1, y1 + dd ],
                [ 0,   wWallMin ]
            ]);
         };
         translate( [ h/2, dd, 0 ] ) {
             cylinder( h=w, r=rRound );
         };
    };
}

module mainCutout() {
    translate( [ wInset + wWallMin, h, wWallMin ] )
    rotate( [ 90, 0, 0 ] ) {
        translate( [ stressR, stressR, 0 ] )
        cylinder( r=stressR, h=h+2*eps );
     
        translate( [ stressR, 0, 0 ] )
        cube( [ wCutout - 2*stressR, 2*dd, h+2*eps ] );
        
        translate( [ wCutout - stressR, stressR, 0 ] )
        cylinder( r=stressR, h=h+2*eps );
        
        translate( [ 0, stressR, 0 ] )
        cube( [ wCutout, 2*dd, h+2*eps ] );
    }
};

module axleCutout() {
    cylinder( r = dAxle/2 + wAxlePlay, h = wInset+eps );
    
    translate( [ -dAxle/2 - wAxlePlay, 0, 0 ] ) {
        cube( [ dAxle + 2*wAxlePlay, h, wInset+eps ] );
    };
};

module boltHole() {
    cylinder( r=boltR, h=2*dWallMin );
    translate( [ 0, 0, dWallMin ] )
    cylinder( r=boltHeadR, h=dd );
}

module all() {
    difference() {
        outerShape();
        
        mainCutout();

        translate( [ wWallMin, h/2, dd ] )
        rotate( [ 0, 90, 0 ] )
        axleCutout();

        translate( [ w - wWallMin - wInset - eps, h/2, dd ] )
        rotate( [ 0, 90, 0 ] )
        axleCutout();
        
        translate( [ wWallMin + wInset / 2, 88, -eps ] )
        boltHole();
        
        translate( [ w - ( wWallMin + wInset / 2 ), 88, -eps ] )
        boltHole();
        
    };
};

// translate( [ wWallMin + wAxlePlay, h/2, d2 ] )
// rotate( [ 0, 90, 0 ] )
// axle();

all();

