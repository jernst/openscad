// numeric constants
eps=0.01;
$fn=128;

// Units are inches
in=25.4;

// Measurements
dRollMax  = 5 * in;
wRoll     = 4 * in;
boltR     = 0.125 * in / 2;
boltHeadR = 3/8 * in / 2;

// Key design choices
dAxle     = 1     * in;
wRollPlay = 0.25  * in;
wInset    = 0.5   * in;
wAxlePlay = 0.125 * in;
dAxlePlay = wAxlePlay;
wWallMin  = 0.25  * in;
dWallMin  = wWallMin;
h         = 5     * in;
stressR   = 0.5   * in;

// consequences
wCutout = wRoll + 2 * wRollPlay;
w       = wCutout + 2 * wInset + 2 * wWallMin;
wAxle   = wCutout + 2 * wInset - 2 * wAxlePlay;
rRound  = dAxle/2 + wAxlePlay + dWallMin;
d       = wWallMin + dRollMax/2 + dAxle /2 + dAxlePlay + dWallMin; // the most protruding point if not rounded
alpha   = atan( h / ( 2 * ( d - wWallMin ) ));  // half angle at the protruding point
d2      = d - rRound / sin( alpha );
d3      = d2 + rRound * sin( alpha );
h31     = h/2 - rRound * cos( alpha );
h32     = h/2 + rRound * cos( alpha );

// part 1 -- axle

module axle () {
    cylinder( r=dAxle/2, h=wAxle );
}

// part 2 -- main

module outerShape() {
    rotate( [ 90, 0, 90 ] )
    union () {
        linear_extrude( w ) {
            polygon( [
                [ 0,   0 ],
                [ h,   0 ],
                [ h,   wWallMin ],
                [ h32, d3 ],
                [ h31, d3 ],
                [ 0,   wWallMin ]
            ]);
         };
         translate( [ h/2, d2, 0 ] ) {
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
        cube( [ wCutout - 2*stressR, d, h+2*eps ] );

        translate( [ wCutout - stressR, stressR, 0 ] )
        cylinder( r=stressR, h=h+2*eps );
        
        translate( [ 0, stressR, 0 ] )
        cube( [ wCutout, d-stressR, h+2*eps ] );
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
    cylinder( r=boltHeadR, h=d );
}

module all() {
    difference() {
        outerShape();
        
        mainCutout();

        translate( [ wWallMin, h/2, d2 ] )
        rotate( [ 0, 90, 0 ] )
        axleCutout();

        translate( [ w - wWallMin - wInset - eps, h/2, d2 ] )
        rotate( [ 0, 90, 0 ] )
        axleCutout();
        
        translate( [ wWallMin + wInset / 2, 90, -eps ] )
        boltHole();
        
        translate( [ w - ( wWallMin + wInset / 2 ), 90, -eps ] )
        boltHole();
        
    };
};

// translate( [ wWallMin + wAxlePlay, h/2, d2 ] )
// rotate( [ 0, 90, 0 ] )
axle();

// all();

