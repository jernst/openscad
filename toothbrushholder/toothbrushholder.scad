eps = 0.01;
$fn = 64;
chamfer = 2;

footheight=3;

module roundedBox( width, depth, height, cornerRadius ) {
    union() {
        translate( [ cornerRadius, cornerRadius, 0 ] ) {
            cylinder( r=cornerRadius, h=height );
        }
        translate( [ width - cornerRadius, cornerRadius, 0 ] ) {
            cylinder( r=cornerRadius, h=height );
        }
        translate( [ cornerRadius, depth - cornerRadius, 0 ] ) {
            cylinder( r=cornerRadius, h=height );
        }
        translate( [ width - cornerRadius, depth - cornerRadius, 0 ] ) {
            cylinder( r=cornerRadius, h=height );
        }
        translate( [ cornerRadius, 0, 0 ] ) {
            cube( [ width - 2 * cornerRadius, depth, height ] );
        }
        translate( [ 0, cornerRadius, 0 ] ) {
            cube( [ width, depth - 2 * cornerRadius, height ] );
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

module frame( width, depth, height, thickness, outerCornerRadius ) {
    difference() {
        union() {
            roundedBox( width, depth, height, outerCornerRadius );

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
            translate( [ width - feetInsetX, 0, feetInsetY ] )
            rotate( [ -90, 0, 0 ] ) {
                foot();
            }

            translate( [ width - feetInsetX, 0, height-feetInsetY ] )
            rotate( [ -90, 0, 0 ] ) {
                foot();
            }
        }

        translate( [ thickness,  thickness, -eps ] ) {
            roundedBox( width - 2 * thickness, depth - 2 * thickness, height + 2 * eps, outerCornerRadius - thickness );
        }

        translate( [ 45, - footheight - eps, height/2 ] )
        rotate( [ -90, 0, 0 ] ) {
            scale( [ 1.25, 1, 1 ] )
            cylinder( r = 20 + 2 * chamfer, h = depth + footheight + 2 * eps);
        }

        brushCutoutRadius = 10;
        brushCutoutInset = 15;

        translate( [ width - 25, - footheight - eps, brushCutoutInset ] )
        rotate( [ -90, 0, 0 ] ) {
            cylinder( r = brushCutoutRadius, h = depth + footheight + 2 * eps);
        }

        translate( [ width - 25, - footheight - eps, height - brushCutoutInset ] )
        rotate( [ -90, 0, 0 ] ) {
            cylinder( r = brushCutoutRadius, h = depth + footheight + 2 * eps);
        }
    }
}

width = 120;
depth  = 90;
height = 60;
thickness = 6;
outerCornerRadius = 12;

if( chamfer > 0 ) {
    minkowski() {
        sphere( r=chamfer );

        translate( [ chamfer, chamfer, chamfer ] ) {
            frame( width - 2 * chamfer, depth - 2 * chamfer, height - 2 * chamfer, thickness - 2 * chamfer, outerCornerRadius );
        }
    }
} else {
    frame( width - 2 * chamfer, depth - 2 * chamfer, height - 2 * chamfer, thickness - 2 * chamfer, outerCornerRadius );
}

