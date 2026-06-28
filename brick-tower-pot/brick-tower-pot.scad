N_SURFACES = 20;

radius_inner = 50;
height = 50;
drain_r1 = 3;
drain_r2 = 18;

bricks_per_layer = 20;
brick_height = 10;

t = 2;

eps = 0.01;
$fn = 128;

brick_length = 2 * PI * (radius_inner + t) / bricks_per_layer;



module brick(width, depth, height, surface, bumpiness = 0.5, camph = 1.2) {
    translate([camph, camph, height])
    scale([(width - 2*camph)/22, (depth - 2*camph)/12, bumpiness])
    surface(surface);

    polyhedron(
        points = [
            [ 0,     0,     0 ],
            [ width, 0,     0 ],
            [ width, depth, 0 ],
            [ 0,     depth, 0 ],

            [ 0,     0,     height - camph ],
            [ width, 0,     height - camph ],
            [ width, depth, height - camph ],
            [ 0,     depth, height - camph ],

            [ camph,         camph,         height + eps ],
            [ width - camph, camph,         height + eps ],
            [ width - camph, depth - camph, height + eps ],
            [ camph,         depth - camph, height + eps ]
        ],
        faces = [
            [ 0, 1, 2, 3 ],

            [ 0, 4, 5, 1 ],
            [ 1, 5, 6, 2 ],

            [ 2, 6, 7, 3 ],
            [ 3, 7, 4, 0 ],
            
            [ 4, 8, 9, 5 ],
            [ 5, 9, 10, 6 ],
            [ 6, 10, 11, 7 ],
            [ 7, 11, 8, 4 ],
            
            [ 8, 11, 10, 9 ]
        ],
        convexity = 10
    );
}

//row_length = 3;

//for( i=[0 : 9-1] ) {
//   dx = i % row_length;
//   dy = floor(i/row_length);

//   surface_index = floor(rands(0, N_SURFACES, 1)[0]);
//
//   translate([ 20 * dx, 10 * dy, 0 ])
//   brick(20, 10, 5, str("surfaces/", surface_index +1, ".txt"));
//}

difference() {
    cylinder( r=radius_inner + t, h=height );

    translate([0, 0, t])
    cylinder( r=radius_inner, h=height );
    
    for(angle = [0 : 90 : 270]) {
        rotate([ 0, 0, angle ])
        translate([ radius_inner/2, 0, -eps ])
        scale([ 1, drain_r1/drain_r2, 1])
        cylinder(r = drain_r2, h = t + 2*eps);
    }
};


for( h = [0 : brick_height : height - brick_height]) {
    offset = rands(-0.1, 0.1, 1)[0];
    for(i = [0 : 1 : bricks_per_layer-1] ) {
        surface_index = floor(rands(0, N_SURFACES, 1)[0]);
    
        rotate([ 0, 0, 360 * ( i + h / brick_height/2 + offset) / bricks_per_layer ])
        translate([0, -radius_inner-t/2, h])
        rotate([90, 0, 0])
        translate([ -brick_length/2, 0, 0])
        brick(brick_length, brick_height, t, str("surfaces/", surface_index +1, ".txt"));
    }
}
