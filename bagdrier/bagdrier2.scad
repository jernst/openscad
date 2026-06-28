w1 = 100;
w2 = 130;
r = 16;
d = 4;
h = 160;
eps = 0.01;

footd = 5*d;


// foot

cube( [ w2, footd, 5 ] );

translate([ 0, d, -eps ])
rotate([90, 0, 0])
difference() {
    linear_extrude(d) {
        polygon([
            [ 0, d ],
            [ (w2-w1)/2, h],
            [ (w2+w1)/2, h],
            [ w2, d ]
        ]);
    };
    
    translate([0, 0, -eps])
    linear_extrude(d+2*eps) {
        polygon([
            [ d, d ],
            [ (w2-w1)/2+d, h-d],
            [ (w2+w1)/2-d, h-d],
            [ w2-d, d ]
        ]);
    };

 };
 