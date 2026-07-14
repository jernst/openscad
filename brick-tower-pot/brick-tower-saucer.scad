use <brick.scad>;

eps = 0.01;
$fn = 64;

N_SURFACES = 24;

height = 24;
t = 2;

brick_length = 24;
brick_height = brick_length/3;
bricks_per_layer = 27;

brick_bumpiness = 0.5;
brick_camph = 1.2;

loophole_height = 2*brick_height;
loophole_width = 0.5*brick_height;

radius_inner = bricks_per_layer * brick_length / 2 / PI - t;

drain_r1 = 1.5;
drain_r2 = 18;


module simple_brick(width, height, depth, surface, bumpiness = 0.5, camph = 1.2) {
    cube([width, height, depth, ]);
}

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

module sector(radius, angle, height) {
    intersection() {
        cylinder(r = radius, h = height);

        translate([ 0, 0, -eps ])
        linear_extrude(h = height + 2*eps) {
            polygon([
                [0, 0],
                [2 * radius * cos(-angle/2), 2 * radius * sin(-angle/2)],
                [2 * radius * cos( angle/2), 2 * radius * sin( angle/2)]
            ]);
        }
    }
}


module supports() {
    above_ground = 5;

    inner_r = 189/2;

    difference() {
        translate([ 0, 0, t ])
        for(angle = [0 : 60 : 360-60 ]) {
            rotate([ 0, 0, angle ])
            sector( radius = inner_r + t, angle = 30, height = above_ground + t );
        }
        // cylinder(h = t, r = inner_r + t );

        translate([ 0, 0, t-eps ])
        cylinder(h = above_ground + t + 2*eps, r = inner_r );
    }

    translate([ 0, 0, t-eps]) {
        for(angle = [0 : 10 : 360-10 ]) {
            rotate([ 0, 0, angle ])
            translate([ inner_r * 0.75, 0, above_ground/2])
            cube([ inner_r*0.4, t, above_ground], center=true);
        }

        for(angle = [0 : 30 : 360-30 ]) {
            rotate([ 0, 0, angle ])
            translate([ inner_r * 0.3, 0, above_ground/2])
            cube([ inner_r*0.4, t, above_ground], center=true);
        }
        
        cylinder(r=2*t, h=above_ground);
    }
}


module cutouts() {
    translate([0, 0, t])
    cylinder( r=radius_inner, h=height + 2*eps );
}


module saucer() {
    difference() {
        wall();
        cutouts();
    }
    supports();
}

saucer();
