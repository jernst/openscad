include <BOSL2/std.scad>
include <BOSL2/nurbs.scad>

w1 = 140;
h = 150;
d1 = 5;
d2 = 10;
eps = 0.01;

footd = 40;

module bagdrier3() {
    // foot

    cuboid(
        [ w1+3*d1, d2, footd ],
        rounding=d1/2,
        edges=[ TOP+BACK, TOP+RIGHT, TOP+LEFT,
                BACK+RIGHT, BACK+LEFT,
                BOTTOM+BACK, BOTTOM+RIGHT, BOTTOM+LEFT],
        $fn=24
    );

    // arch
 
    points = [
        [-w1/2+d1,   0, 0],
        [-w1/2+d1, h/2, 0],
        [     -55,   h, 0],
        [      55,   h, 0],
        [ w1/2-d1, h/2, 0],
        [ w1/2-d1,   0, 0]
    ];

    path = nurbs_curve(points, 2, splinesteps=64);
    ushape = ellipse([2*d1, d1], $fn = 100);

    path_sweep(ushape, path3d(path));
};

intersection() {
    bagdrier3();
    
    translate([-w1, 0, 0])
    cube([2*w1, 2*h, 10*d1]);
}

