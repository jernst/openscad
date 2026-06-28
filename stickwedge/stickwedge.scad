in = 25.4;
eps = 0.1;

$fn = 64;

r = 3/8*in/2;
w = 2*in;
l = 1*in;

module stick() {
    translate([0, -eps, 0])
    rotate([ -90, 0, 0])
    cylinder(r=r, h=w+2*eps);
};

module wedge() {
    xt = r*r/l;
    yt = sqrt(r*r-xt*xt);

    translate([0, w, 0 ])
    rotate([90, 0, 0])
    linear_extrude(w)
    polygon([
        [ l, 0 ],
        [ xt, yt ],
        [ 0, 0 ],
        [ xt, -yt ]
    ]);
};

difference() {
    wedge();
    stick();
};
