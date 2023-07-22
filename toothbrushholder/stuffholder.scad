eps = 0.01;
$fn = 48;
chamfer = 2;

footheight=3;

module roundedBox( width1, width2, depth1, depth2, height, convexCornerRadius, concaveCornerRadius ) {
    union() {
        translate( [ convexCornerRadius, convexCornerRadius, 0 ] ) {
            cylinder( r=convexCornerRadius, h=height );
        }
        translate( [ width2 - convexCornerRadius, convexCornerRadius, 0 ] ) {
            cylinder( r=convexCornerRadius, h=height );
        }
        translate( [ convexCornerRadius, depth1 - convexCornerRadius, 0 ] ) {
            cylinder( r=convexCornerRadius, h=height );
        }
        translate( [ width2 - convexCornerRadius, depth2 - convexCornerRadius, 0 ] ) {
            cylinder( r=convexCornerRadius, h=height );
        }
        translate( [ width1 - convexCornerRadius, depth1 - convexCornerRadius, 0 ] ) {
            cylinder( r=convexCornerRadius, h=height );
        }
        translate( [ convexCornerRadius, 0, 0 ] ) {
            cube( [ width2 - 2 * convexCornerRadius, depth2, height ] );
        }
        translate( [ convexCornerRadius, 0, 0 ] ) {
            cube( [ width1 - 2 * convexCornerRadius, depth1, height ] );
        }
        translate( [ 0, convexCornerRadius, 0 ] ) {
            cube( [ width1, depth1 - 2 * convexCornerRadius, height ] );
        }
        translate( [ width1, convexCornerRadius, 0 ] ) {
            cube( [ width2-width1, depth2 - 2 * convexCornerRadius, height ] );
        }
        translate( [ width1, depth2, 0 ] )
        difference() {
            cube( [ concaveCornerRadius, concaveCornerRadius, height ] );

            translate( [ concaveCornerRadius, concaveCornerRadius, -eps ] )
            cylinder( r=concaveCornerRadius, h=height+2*eps );
        }
    }
}

module foot() {
    r = 5;
    h = footheight;

    intersection() {
        translate( [ 0, 0, r-h ] ) {
            sphere( r=r );
        }
        translate( [ -3 * r, -3 * r, -h ] ) {
            cube( [ 6 * r, 6 * r, h ] );
        }
    }
}

module frame( width1, width2, depth1, depth2, height, thickness, outerCornerRadius ) {
    innerCornerRadius = outerCornerRadius - thickness;

    difference() {
        union() {
            roundedBox( width1, width2, depth1, depth2, height, outerCornerRadius, innerCornerRadius );

            translate( [ outerCornerRadius, depth1 - eps, 0 ] ) {
                saddleWidth  = 6;
                saddleRadius = 32 + chamfer;
                difference() {
                    cube( [ saddleWidth, 12, height ] );
                    translate( [ -eps, saddleRadius + 5, height/2 ] )
                    rotate( [ 0, 90, 0 ] ) {
                        cylinder( r = saddleRadius, h = saddleWidth + 2 * eps );
                    }
                }
            }

            feetInsetX = 14;
            feetInsetY = 10;

            // feet

            translate( [ feetInsetX, 0, feetInsetY ] )
            rotate( [ -90, 0, 0 ] ) {
                foot();
            }

            translate( [ feetInsetX, 0, height-feetInsetY ] )
            rotate( [ -90, 0, 0 ] ) {
                foot();
            }
            translate( [ width2 - feetInsetX, 0, feetInsetY ] )
            rotate( [ -90, 0, 0 ] ) {
                foot();
            }

            translate( [ width2 - feetInsetX, 0, height-feetInsetY ] )
            rotate( [ -90, 0, 0 ] ) {
                foot();
            }
        }

        translate( [ thickness,  thickness, -eps ] ) {
            roundedBox( width1 - 2 * thickness, width2 - 2 * thickness, depth1 - 2 * thickness, depth2 - 2 * thickness, height + 2 * eps, innerCornerRadius, outerCornerRadius );
        }

        translate( [ 45, - footheight - eps, height/2 ] )
        rotate( [ -90, 0, 0 ] ) {
            scale( [ 1, 0.75, 1 ] )
            cylinder( r = 16 + chamfer, h = depth1 + footheight + 2 * eps);
        }

        brushCutoutRadius = 10;
        brushCutoutInset = 15;

        translate( [ width1 - 20, - footheight - eps, brushCutoutInset ] )
        rotate( [ -90, 0, 0 ] ) {
            cylinder( r = brushCutoutRadius, h = depth1 + footheight + 2 * eps);
        }

        translate( [ width1 - 20, - footheight - eps, height - brushCutoutInset ] )
        rotate( [ -90, 0, 0 ] ) {
            cylinder( r = brushCutoutRadius, h = depth1 + footheight + 2 * eps);
        }

        // for the lid

        translate( [ width1 + 10, depth2+25, height/2 ] )
        rotate( [ 0, 90, 0 ] ) {
            cylinder( r = 32, h=14 + 2 * chamfer );
        }

        translate( [ width1 + 10, -eps, 15 ] )
        cube( [ 13, depth2 + 2*eps, height-30 ] );


        translate( [ width2 - 30, - footheight - eps, height/2 ] )
        rotate( [ -90, 0, 0 ] ) {
            cylinder( r = 13 + chamfer, h = depth1 + footheight + 2 * eps);
        }

    }
}

width1 = 110;
width2 = 202;
depth1  = 90;
depth2  = 50;
height = 60;
thickness = 6;
outerCornerRadius = 12;

if( chamfer > 0 ) {
    minkowski() {
        sphere( r=chamfer );

        translate( [ chamfer, chamfer, chamfer ] ) {
            frame( width1 - 2 * chamfer, width2 - 2 * chamfer, depth1 - 2 * chamfer, depth2 - 2 * chamfer, height - 2 * chamfer, thickness - 2 * chamfer, outerCornerRadius );
        }
    }
} else {
    frame( width1 - 2 * chamfer, width2 - 2 * chamfer, depth1 - 2 * chamfer, depth2 - 2 * chamfer, height - 2 * chamfer, thickness - 2 * chamfer, outerCornerRadius );
}

