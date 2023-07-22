use <threadlib/threadlib.scad>

$fn = 120;

in = 25.4;

intersection() {
    nut("G1/2", turns=10, Douter = 2 * in );

    bolt( "G1", turns=7.8 );
}
