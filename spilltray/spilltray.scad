$fn = 64;

in = 25.4;

h = 0.75 * in;
curve_r = 0.25*in;
t = 3; // 1.4;
eps = 0.01;

pipe_r_outside = 21.5/2;

maxd = 220;


module base1(d, r) {
    translate([r, r, r])
    minkowski() {
        sphere(r=r);
        linear_extrude(h=2*h) {
            polygon([
                [ 0, 0 ],
                [ 4*in, 0 ],
                [ 6*in, (d - 1*in)/2 - r],
                [ 6*in, (d + 1*in)/2 - r],
                [ 4*in, d - 2*r ],
                [ 0, d - 2*r ]
            ]);
        };
    };
}

intersection() {
    difference() {
        union() {
            base1(maxd, curve_r);

            translate([ 6.25*in -eps, (maxd-1*in)/2, 0])
            cube([ 0.75*in, 1*in, 0.5*in]);

            translate([6.5*in, maxd/2, pipe_r_outside])
            rotate([0, 90, 0])
            cylinder( r=pipe_r_outside, h=1.5*in );
        };

        translate([t, t, t])
        base1(maxd - 2*t, curve_r-t);

        translate([6*in, maxd/2, pipe_r_outside ])
        rotate([0, 90, 0])
        cylinder( r=pipe_r_outside - t, h=3*in);

        translate([6*in, maxd/2 - 5, 5 ]) 
        cube([ 3*in, 10, 1*in]);

    };
    translate([ -eps, -eps, -eps ])
    cube([ 10*in, 10*in, h+eps] );
};


