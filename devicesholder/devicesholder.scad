$fn = 64;
eps = 0.01;

play = 1;


module powerHolder() {
    width = 32 + 2*play;
    depth = 85.5 + 2*play;
    height = 85.6 + 2*play;
    
    wall = 8;
    
    translate([0, (-depth-wall)/2, 0])
    difference() {
        cube([width + wall, depth + wall, height/2 + wall]);

        translate([wall/2, wall/2, wall/2])    
        cube([width, depth, height+wall]);

        translate([wall, -eps, wall/2])
        cube([width-wall, depth + wall + 2*eps, height+wall]);

        translate([-eps, (depth + wall)/2, height + 4*wall])
        rotate([0, 90, 0])
        scale([2.5, 1, 1])
        cylinder(h = width + wall + 2*eps, r = depth/2);
    }
};

module deviceHolder(d, w, t, footH, leanToH) {
    outerD = w + 2*t + 2*play;

    translate([0, -w/2 - t - play, 0 ]) {
        difference() {
            cube([ d + 2*t, outerD, footH]);
         
            translate([ d/2 + t, t + d/2 + play/2, footH])
            rotate([-90, 0, 0])
            cylinder(r = d/2, h = w - d + play);   

            translate([ d/2 + t, (play + d)/2 + t, footH])
            sphere(r = d/2);

            translate([ d/2 + t, w + play - d/2 + t, footH])
            sphere(r = d/2);
        };
        
        translate([ d + 2*t - eps, 0, 0])
        difference() {
            cube([ 2*t, outerD, leanToH + footH]);
            
            translate([ -eps, outerD/2, leanToH * 2.5])
            rotate([0, 90, 0])
            scale([3, 1, 1])
            cylinder(r = outerD/2, h = 2*t + 2*eps);   
        };
    };
}

module ipadHolder() {
    d = 11;
    w = 175;
    t = 2;
    h = 30;
    leanToH = 120;

    deviceHolder(d, w, t, h, leanToH);
};


module iphoneHolder() {
    d = 13;
    w = 76;
    t = 2;
    h = 30;
    leanToH = 80;

    deviceHolder(d, w, t, h, leanToH);
};


angle = 15;

translate([10, 50, 0])
rotate([0, angle, 0])
iphoneHolder();


translate([50, 0, 0])
rotate([0, angle, 0])
// translate([0, 0, sin(angle) * (d + 2*t)])
ipadHolder();

translate([100, 0, 0])
powerHolder();
