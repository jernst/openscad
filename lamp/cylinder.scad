$fn = 64;
wall = 1;


difference() {
    cylinder( r=8, h=80 );

    translate( [ 0, 0, wall ] )
    cylinder( r=8-wall, h=80 );
};
