thread_height = 10;
base_height = 12;
funnel_height = 10;
overlap_height1 = 10;
overlap_height2 = 8;
thread_d = 68.0;
portafilter_d = 62.5;

eps = 0.01;
$fn = 64;

use <../vendor/threads-scad/threads.scad>;

module singlethread(tolerance=0.4) {
    ScrewThread(
            outer_diam    = thread_d,
            height        = thread_height,
            pitch         = 6,
            tooth_angle   = 30,
            tolerance     = tolerance,
            tip_height    = 2,
            tooth_height  = 0,
            tip_min_fract = 0.9);

}
module mythread() {
    singlethread();
    rotate([0, 0, 180])
    singlethread();
    
    translate([0, 0, thread_height-eps])
    cylinder(r=71/2, h=base_height-thread_height+eps);
}    

// module ScrewThread(outer_diam, height, pitch=0, tooth_angle=30, tolerance=0.4, tip_height=0, tooth_height=0, tip_min_fract=0) {

module part() {
    difference() {
        union() {
            mythread();
            translate([ 0, 0, base_height-eps]) {
                cylinder(r=34, h=funnel_height + overlap_height1 + overlap_height2 + eps);
            };
        };
     
        // inside funnel
        translate( [0, 0, -eps] ) {
            cylinder(r1=portafilter_d/2, r2=27, h = base_height + funnel_height + 2*eps);
        };
        
        // cylinder for the cutouts
        translate([ 0, 0, base_height + funnel_height ]) {
            cylinder(r=portafilter_d/2, h=overlap_height1 + overlap_height2 +eps);
        }

        // cutouts
        for( angle=[0:120:360] ) {
            rotate([0, 0, angle]) {
                translate([ 0, 0, base_height + funnel_height + 1]) {
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
                translate([ 0, 0, base_height + funnel_height + overlap_height1 ]) {
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
}

part();
// singlethread();
// difference() {
//    mythread();
    
//    translate([0, 0, -eps])
//    cylinder(r=thread_d/2 - 4, h = base_height + 2*eps);
//}
