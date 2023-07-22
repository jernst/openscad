w = 25;
d = 2;
eps = 0.01;

difference() {
    cube( [ w, w + 2*d, w + d ] );

    translate( [ -eps, d, d ] ) {
        cube( [ w + 2*eps, w, w + eps ] );
    }
}
