$fn=64;


module wall()
{
    intersection() {
        $fn=256;

        translate([ 0, -190, -10])
        sphere(r=200);

        translate([ 0, 190, -10])
        sphere(r=200);

        translate([ 0, -50, 0])
        cube([ 100, 100, 100]);
    }
}

module footer() {
    intersection() {
        translate([20, 0, -196])
        scale([1.2, 0.6, 1])
        sphere(r=200);

        translate([ 0, -50, 0])
        cube([ 100, 100, 100]);
    }
}

module hole() {
    translate([ 0, 50, 0])
    rotate([90, 0, 0])
    cylinder(r=4, h = 100);
}

module chopstickdrier() {
    difference() {
        union() {
            wall();
            footer();
        }

        translate([ 5, 0, 52])
        hole();

        translate([ 18, 0, 49])
        hole();

        translate([ 31, 0, 44])
        hole();

        translate([ 39, 0, 30])
        hole();

        translate([ 14, 0, 34])
        hole();

        translate([ 24, 0, 20])
        hole();
    }
}
chopstickdrier();
