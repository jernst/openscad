$fn=64;

l = 25;
r = 18;
eps = 0.01;


difference() {
    cylinder( r=r, h=l );
    
    translate( [ -l/2, -r, -eps ] )
    cube( [ l, l, l + 2*eps ] );
}
