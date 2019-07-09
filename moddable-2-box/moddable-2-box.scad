//
// OpenSCAD file for a simple enclosure for the Moddable-2,
// an ESP32-based embedded development module with touch screen.
// see https://www.moddable.com/purchase.php
//
// (C) 2019 Johannes Ernst
//
// This work is licensed under a
// Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License.
// See http://creativecommons.org/licenses/by-nc-sa/4.0/
//

// all units in mm

length =  81.5;   // outside length
width  =  47.6;   // outside width
th     =  1;      // wall thickness
depth  =  4 + th; // inside height plus wall thickness

holes_length = 25.4 * 3; // distance of mounting holes along length (apparently 3in)
holes_width  = 43;       // distance of mounting holes along width

post_length = 3.4;       // length of the post that contains the screw hole
post_width  = 4;         // width of the post that contains the screw hole

hole_r = 1.9/2; // M2 screw needing to cut its own thread
                // you may need to adjust this based on the behavior of your
                // printer and which exact screws you are using.

cutout = 3;     // height of the cutouts for the terminals

eps    = 0.01;  // helper constant to avoid floating-point errors

$fn = 64;  // smoothness of the round surfaces

// post that will contain the screw hole
module post() {
    translate( [ -post_length/2, -post_width/2, 0 ] ) {
        cube( [ post_length, post_width, depth-eps ] );
    }
}

// the screw hole
module post_hole() {
    translate( [ 0, 0, -eps ] ) {
        cylinder( r=hole_r, h = depth + 2*eps, center=false);
    }
}

// the actual enclosure
difference() {
    union() {

        // the shell
        difference() {
            cube( [ length, width, depth ] );
            translate( [ th, th, th ] ) {
                cube( [ length - 2*th, width - 2*th, depth ] );
            }
        };

        // 4 posts
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

    // minus 4 holes
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

    // minus cutout for serial
    translate( [ -eps, 26, depth - cutout ] ) {
        cube( [ th + 2*eps, 17, cutout + eps ] );
    }
    // minus cutout for USB
    translate( [ -eps, 6.5, depth - cutout ] ) {
        cube( [ th + 2*eps, 9, cutout + eps ] );
    }
    // minus cutout for GPIO
    translate( [ 7, -eps, depth - cutout ] ) {
        cube( [ 42, th + 2*eps, cutout + eps ] );
    }
    // minus cutout for chip
    translate( [ 58, -eps, depth - cutout/2 ] ) {
        cube( [ 19, th + 2*eps, cutout/2 + eps ] );
    }
};
