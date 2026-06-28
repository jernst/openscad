eps = 0.01;
$fn = 128;

r    = 10;
wall =  1;

module wizardPin( r, h ) {

    py = r*r/h;
    px = sqrt( r*r - py*py );

    sphere( r=r );

    intersection() {
        translate( [ 0, 0, py ])
        cylinder( h=h-py, r1=px, r2=0 );
    }
}

module trimmedHollowWizardPin( r, h, rtip, wall ) {
    py = r*r/h;
    px = sqrt( r*r - py*py );

    zcut = h - px/py*rtip;

    difference() {
       intersection() {
            wizardPin( r, h );

            translate( [ -r, 0, -r-eps ] )
            cube( [ 2*(r+eps), r+eps, r+eps + zcut ] );
        }
        wizardPin( r-wall, h - wall * px/py );
    }
}

trimmedHollowWizardPin( r, 36, 3, wall );

translate( [ -r/2, -eps, -r+wall ] )
mirror( [ 0, 0, 1 ] )
rotate( [ 180,  0, 0 ] )
rotate( [   0, 90, 0 ] )
linear_extrude( r ) {
    handleH = 15;

    polygon( [
        [ 0,    0 ],
        [ wall, 0 ],
        [ handleH/2+ wall, handleH ],
        [ handleH/2, handleH ]
    ] );
}