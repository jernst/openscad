n = 4; // number of chop sticks
s = 5; // defines the grid
wd = 5; // wall depth
d = 50; // depth of entire part
h = 40;
wh = 10; // wall height
play = 0.2;
eps = 0.01;
snap_h=0.6;

d2 = 30; // y location of part2 relative to part1

$fn = 64;

// calculated
w = n*2*s + 2*wd;

module part1() {
    module front() {
        translate([0, wd, 0])
        rotate([90, 0, 0])
        linear_extrude(height=wd) {
            polygon([
                [0, 0],
                [0, h],
                for( i= [ 0 : 1 : 2*n ] )
                    [i*s + wd, i % 2 == 0 ? h : h -s],
                [w, h],
                [w, 0]
            ]);
        };
    };

    module side_left() {
        difference() {
            cube([wd, d, wh]);
            
            translate([wd/2-play/2, d2-play/2, -eps]) {
                cube([wd/2+play/2+eps, wh+play, wh+2*eps]);
            }
            
            translate([wd/2-eps, d2+wh/2, wh/2 ])
            rotate([0, -90, 0])
            cylinder(r=wh/4+play/2, h=snap_h+play);            
        }
    }

    module side_right() {
        translate([w-wd, 0, 0])
        difference() {
            cube([wd, d, wh]);

            translate([-eps, d2-play/2, -eps]) {
                cube([wd/2+play/2+eps, wh+play, wh+2*eps]);
            }
            
            translate([wd/2-eps, d2+wh/2, wh/2 ])
            rotate([0, 90, 0])
            cylinder(r=wh/4+play/2, h=snap_h+play);
        }
    }

    module back() {
        translate([0, d-wd, 0])
        cube([w, wd, h]);
    }

    front();
    side_left();
    side_right();
    back();
}

module part2() {
    module main() {
        h2 = 25;

        translate([0, wd, 0])
        rotate([90, 0, 0])
        linear_extrude(height=wd) {
            polygon([
                [0, h2],
                [0, h],
                [w, h],
                [w, h2],
                for( i= [ 2*n : -1 : 0 ] )
                    [i*s + wd, i % 2 == 0 ? h2 : h2+s],
            ]);
        };
    }

    module side_left() {
        translate([ 0, wd/2-wh/2, 0]) {
            difference() {
                cube([wd, wh, h]);
                translate([-eps, -eps, -eps]) {
                    cube([wd/2+eps-play/2, wh+2*eps, wh+eps+play]);
                };
            }
            translate([wd/2-eps, wh/2, wh/2 ])
            rotate([0, -90, 0])
            cylinder(r=wh/4-play/2, h=snap_h-play/2+eps);
            
        }
    }

    module side_right() {
        translate([ w-wd, wd/2-wh/2, 0]) {
            difference() {
                cube([wd, wh, h]);
                translate([wd/2-play/2, -eps, -eps]) {
                    cube([wd/2+eps+play/2, wh+2*eps, wh+eps+play]);
               };
            }
            translate([wd/2-play/2-eps, wh/2, wh/2 ])
            rotate([0, 90, 0])
            cylinder(r=wh/4-play/2, h=snap_h+eps);
        }
    }

    main();
    side_left();
    side_right();
}

part1();

// translate([1.5*w, d2, 0])
// part2();
