eps = 0.01;
$fn = 64;

wall = 1;

tan60 = tan( 60 );

module cup( r, h, b ) {
    difference() {
        cylinder( r=r, h=h );
        translate( [ 0, 0, b ] ) {
            cylinder( r=r-wall, h );
        }
    }
}

module tria( halfBase ) {
    l = 100;
    translate( [ 0, l/2, 0 ] )
    rotate( [ 90, 0, 0 ] )
    linear_extrude( l ) {
    polygon( [
        [ -halfBase, 0 ],
        [  halfBase, 0 ],
        [ 0, halfBase*tan60 ]] );
    }    
}

module lamp( r, h, dl, b ) {
    difference() {
        cup( r, h, b );
        
        for( layer=[0:5] ) {
            translate( [ 0, 0, layer*dl + 8 ] )
            for( alpha=[0:45:315] ) {
                rotate( a=[ 0, 0, alpha + ( layer % 2 ) * 22.5 ] )
                tria( 8 );
            }
        }

        for( layer=[0:5] ) {
            translate( [ 0, 0, layer*dl + 12 ] )
            for( alpha=[0:45:315] ) {
                rotate( a=[ 0, 0, alpha + ( ( layer + 1 )% 2 ) * 22.5 ] )
                tria( 4 );
            }
        }
    };
};


// lamp( 30, 100, 15, wall );

translate( [ 70, 0, 0 ] ) {
    difference() {
        lamp( 34, 100, 15, 2*wall );
        
        translate( [ 0, 0, wall ] ) {
            cylinder( r=30, h=2*wall );
        }
    }
    cylinder( r=30-wall, h=2*wall );
}
