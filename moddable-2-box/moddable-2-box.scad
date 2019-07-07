//
//
//

length =  81.5;
width  =  47.6;
th     =  1;
depth  =  4 + th;

holes_length = 25.4 * 3; // 3in
holes_width  = 43;

post_width  = 4;
post_length = 3.4;

hole_r = 1.9/2; // M2 screw needing to cut its own thread

cutout = 3;

eps    = 0.01;

$fn = 64;

module post() {
    translate( [ -post_length/2, -post_width/2, 0 ] ) {
        cube( [ post_length, post_width, depth-eps ] );
    }
}

module post_hole() {
    translate( [ 0, 0, -eps ] ) {
        cylinder( r=hole_r, h = depth + 2*eps, center=false);
    }
}


difference() {
    union() {
        difference() {
            cube( [ length, width, depth ] );
            translate( [ th, th, th ] ) {
                cube( [ length - 2*th, width - 2*th, depth ] );
            }
        };
        translate( [ (length - holes_length)/2, (width - holes_width)/2, 0 ] ) {
            post();
        };
        translate( [ (length + holes_length)/2, (width - holes_width)/2, 0 ] ) {
            post();
        };
        translate( [ (length - holes_length)/2, (width + holes_width)/2, 0 ] ) {
            post();
        };
        translate( [ (length + holes_length)/2, (width + holes_width)/2, 0 ] ) {
            post();
        };
    };

    translate( [ (length - holes_length)/2, (width - holes_width)/2, 0 ] ) {
        post_hole();
    };
    translate( [ (length + holes_length)/2, (width - holes_width)/2, 0 ] ) {
        post_hole();
    };
    translate( [ (length - holes_length)/2, (width + holes_width)/2, 0 ] ) {
        post_hole();
    };
    translate( [ (length + holes_length)/2, (width + holes_width)/2, 0 ] ) {
        post_hole();
    };

    // serial
    translate( [ -eps, 26, depth - cutout ] ) {
        cube( [ th + 2*eps, 17, cutout + eps ] );
    }
    // USB
    translate( [ -eps, 6.5, depth - cutout ] ) {
        cube( [ th + 2*eps, 9, cutout + eps ] );
    }
    // GPIO
    translate( [ 7, -eps, depth - cutout ] ) {
        cube( [ 42, th + 2*eps, cutout + eps ] );
    }
    // chip
    translate( [ 58, -eps, depth - cutout/2 ] ) {
        cube( [ 19, th + 2*eps, cutout/2 + eps ] );
    }
};
