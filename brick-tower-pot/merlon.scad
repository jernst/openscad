use <brick.scad>;

eps = 0.01;

brick_width = 30;
brick_height = 10;
brick_depth = 10;

loophole_height = 2*brick_height;
loophole_width = 0.5*brick_height;

camph = 1.2;

module rotated_brick(width, height, depth, surface, bumpiness = 0.5, camph = camph) {
     translate([ 0, depth, 0])
     rotate([90, 0, 0])
     brick(width, height, depth, surface, bumpiness, camph );
}

module corbel(width, depth, height) {
    difference() {
        translate([width, depth, 0])
        rotate([90, 0, 0])
        rotate([0, -90, 0])
        linear_extrude(h = brick_width) {
            polygon([
                [0, 0],
                [0, -height],
                [depth, 0]
            ]);
        }
        
        insetx = width/6;
        insety = height*0.8;

        translate([brick_width/2, depth, -height-eps])
        rotate([90, 0, 0])
        linear_extrude(h = depth + 2*eps ) {
            polygon([
                [ -brick_width/2 + insetx, 0],
                [  brick_width/2 - insetx, 0],
                [  insetx/2, insety ],
                [ -insetx/2, insety ]
            ]);
        }
    }
}

module merlon() {
    difference() {
        union() {
            rotated_brick(brick_width, brick_height, brick_depth, "surfaces/1.txt");
            
            translate([ 0, 0, brick_height])
            rotated_brick(brick_width, brick_height, brick_depth, "surfaces/2.txt");

            translate([ 0, 0, 2*brick_height])
            rotated_brick(brick_width, brick_height, brick_depth, "surfaces/3.txt");
        }
        
        translate([ brick_width/2, brick_depth + eps, 3*brick_height/2])
        rotate([90, 0, 0])
        linear_extrude(h=2*brick_depth) {
            polygon([
                [ 0,                -loophole_height/2],
                [ loophole_width/2, -loophole_height/2 + loophole_width/2 ],
                [ loophole_width/2,  loophole_height/2 - loophole_width/2 ],
                [ 0,                 loophole_height/2],
                [-loophole_width/2,  loophole_height/2 - loophole_width/2 ],
                [-loophole_width/2, -loophole_height/2 + loophole_width/2 ]                
            ]);
        }
    }
    
    translate([0, camph, 0])
    corbel(brick_width, brick_depth - camph, brick_depth*2);
}


merlon();
// corbel(brick_width, brick_depth, brick_depth*2);
