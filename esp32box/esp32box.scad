$fn=64;
eps = 0.01;
w   = 2;


module esp32post() {
    cylinder( r=1.35, h=23 );
    
    intersection() {
        cylinder( r=4, h=20 );
        
        translate( [ -1.35, 0, -eps ] ) {
            cube( [ 2.5, 4, 21 ] );
        }
    }
};

module esp32posts() {
    esp32post();

    translate( [ 47, 0, 0 ] )
    esp32post();

    translate( [ 0, 24, 0 ] )
    rotate( [ 0, 0, 180 ] )
    esp32post();

    translate( [ 47, 24, 0 ] )
    rotate( [ 0, 0, 180 ] )
    esp32post();
};

module plugholderWall() {
    linear_extrude( 12 ) {
        polygon( [
             [  0,       -10.5/2 ],
             [  6,       -10.5/2 ],
             [ 19,       -15/2 ],
             [ 30.5,     -15/2 ],
             [ 30.5,     -10.5/2 ],
             [ 30.5 + w, -10.5/2 ],
             [ 30.5 + w, -15/2 - w ],
             [ 0,        -15/2 - w ],
        
         
        ] );
    }
};

module plugholder() {
    translate( [ 0, - ( 10.5 + 2*w ) / 2, 0 ] )
    cube( [ 5, 10.5 + 2*w, 1.5 ] );

    plugholderWall();
    
    
    translate( [ 0, 0, 12 ] )
    rotate( [180, 0, 0] )
    plugholderWall();    
}

// -- temp

module esp32 () {
    cube( [ 50, 27, w ] );

    translate( [ 1.5, 1.5, w-eps ] )
    esp32posts();
};

module ph() {
    difference() {
        cube( [ 30.5+w, 19, w ] );
        translate( [ 24, 19/2, -eps ] )
        cylinder( r=3, h=w+2*eps );
    };

    translate( [ 0, 19/2, w-eps ] )
    plugholder();
};

esp32();

translate( [ 0, 35, 0 ] )
ph();
