$fn=64;

intersection() {
    sphere( r=10 );
    translate( [ -10, -10, 0 ]) {
        cube( [ 20, 20, 12 ] );
    }
}
