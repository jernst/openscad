thread_height = 10;
funnel_height = 10;
overlap_height1 = 10;
overlap_height2 = 8;

eps = 0.01;
$fn = 64;

use <threads.scad>

module mythread() {
    // metric_thread(67, 3, thread_height, square=true);
    

    linear_extrude(
        height = thread_height,
        twist = 2 * 360,
        slices = 50
    )
//    translate([d/2,0,0])
    circle(r=0.6);
};


difference() {
    union() {
        #mythread();
        translate([ 0, 0, thread_height-eps]) {
            cylinder(r=34, h=funnel_height + overlap_height1 + overlap_height2 + eps);
        };
    };
 
    translate( [0, 0, -eps] ) {
        cylinder(r1=31, r2=27, h = thread_height + funnel_height + 2*eps);
    };
    
    translate([ 0, 0, thread_height + funnel_height ]) {
        cylinder(r=31, h=overlap_height1 + overlap_height2 +eps);
    }

    for( angle=[0:120:360] ) {
        rotate([0, 0, angle]) {
            translate([ 0, 0, thread_height + funnel_height + 1]) {
                linear_extrude(h=overlap_height1+eps) {
                    r = 100;
                    angle2 = 40;
                    polygon( [
                        [ 0, 0 ],
                        [ r * sin(angle2), r * cos(angle2) ],
                        [ - r * sin(angle2), r * cos(angle2) ]
                    ] );
                }
            }
        }
        rotate([0, 0, angle + 15]) {
            translate([ 0, 0, thread_height + funnel_height + overlap_height1 ]) {
                linear_extrude(h=overlap_height2+eps) {
                    r = 100;
                    angle3 = 25;
                    polygon( [
                        [ 0, 0 ],
                        [ r * sin(angle3), r * cos(angle3) ],
                        [ - r * sin(angle3), r * cos(angle3) ]
                    ] );
                }
            }
        }
    };

}
