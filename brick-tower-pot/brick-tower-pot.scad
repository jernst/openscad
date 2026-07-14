use <brick.scad>;

eps = 0.01;
$fn = 64;

N_SURFACES = 24;

height = 184;
t = 2;

brick_length = 24;
brick_height = brick_length/3;
bricks_per_layer = 24;

brick_bumpiness = 0.5;
brick_camph = 1.2;

loophole_height = 2*brick_height;
loophole_width = 0.5*brick_height;

radius_inner = bricks_per_layer * brick_length / 2 / PI - t;

drain_r1 = 1.5;
drain_r2 = 18;


module round_wall() {
    cylinder( r=radius_inner + t, h=height );
}

module wall_bricks( bumpiness = 0.5, camph = brick_camph) {
    for( h = [0 : brick_height : height - brick_height]) {
        offset = rands(-0.1, 0.1, 1)[0];
        for(i = [0 : 1 : bricks_per_layer-1] ) {
            surface_index = floor(rands(0, N_SURFACES, 1)[0]);

            rotate([ 0, 0, 360 * ( i + h / brick_height/2 + offset) / bricks_per_layer ])
            translate([0, -radius_inner-t/2, h])
            rotate([90, 0, 0])
            translate([ -brick_length/2, 0, 0])
            brick(brick_length, brick_height, t, str("surfaces/", surface_index +1, ".txt"), bumpiness, camph);
        }
    }
}

module wall() {
    round_wall();
    wall_bricks();
}

module cutouts() {
    translate([0, 0, t])
    cylinder( r=radius_inner, h=height );

    for(angle = [0 : 45 : 360-45]) {
        rotate([ 0, 0, angle ])
        translate([ radius_inner*.4, 0, -eps ])
        scale([ 1, drain_r1/drain_r2, 1])
        cylinder(r = drain_r2, h = t + 2*eps);
    }

    for(angle = [0 : 45 : 360-45]) {
        rotate([ 0, 0, angle+22.5 ])
        translate([ radius_inner*0.67, 0, -eps ])
        scale([ 1, drain_r1/drain_r2, 1])
        cylinder(r = drain_r2, h = t + 2*eps);
    }
}

module rotated_brick(width, height, depth, surface, bumpiness = 0.5, camph = brick_camph) {
     translate([ 0, depth, 0])
     rotate([90, 0, 0])
     brick(width, height, depth, surface, bumpiness, camph );
}

module corbel(width, depth, height) {
    difference() {
        translate([width, depth, 0])
        rotate([90, 0, 0])
        rotate([0, -90, 0])
        linear_extrude(h = width) {
            polygon([
                [0, 0],
                [0, -height],
                [depth, 0]
            ]);
        }
        
        insetx = width/6;
        insety = height*0.8;

        translate([width/2, depth, -height-eps])
        rotate([90, 0, 0])
        linear_extrude(h = depth + 2*eps ) {
            polygon([
                [ -width/2 + insetx, 0],
                [  width/2 - insetx, 0],
                [  insetx/2, insety ],
                [ -insetx/2, insety ]
            ]);
        }
    }
}

module merlon(camph = brick_camph) {
    brick_depth = t + 8;

    translate([0, -brick_depth, 0])
    difference() {
        union() {
            rotated_brick(brick_length, brick_height, brick_depth, "surfaces/1.txt");
            
            translate([ 0, 0, brick_height])
            rotated_brick(brick_length, brick_height, brick_depth, "surfaces/2.txt");

            translate([ 0, 0, 2*brick_height])
            rotated_brick(brick_length, brick_height, brick_depth, "surfaces/3.txt");
        }
        
        translate([ brick_length/2, brick_depth + eps, 3*brick_height/2])
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
    
    translate([0, camph - brick_depth, 0])
    corbel(brick_length, brick_depth - camph, brick_depth*2);
}

module battlements() {
    for(i = [0 : 2 : bricks_per_layer-2] ) {
        angle = 360 * i / bricks_per_layer;
        rotate([0, 0, angle])
        translate([0, -radius_inner-t/2, height])
        translate([ -brick_length/2, 0, 0])
        merlon();
   }
}


module tower() {
    difference() {
        wall();
        cutouts();
    }
    battlements();
}

tower();
