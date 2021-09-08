eps = 0.01;
$fn = 64;
chamfer = 2; // 1;


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
    h = 3;

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
        roundedBox( width, depth, height, outerCornerRadius );

        translate( [ thickness,  thickness, -eps ] ) {
            roundedBox( width - 2 * thickness, depth - 2 * thickness, height + 2 * eps, outerCornerRadius - thickness );
        }

        // bottom

        bottomCutoutInsetX = 20;
        bottomCutoutInsetY = 10;
        bottomCutoutWidth = width - 2 * bottomCutoutInsetX;

        translate( [ bottomCutoutInsetX, -eps, bottomCutoutInsetY ] ) {
            cube( [ bottomCutoutWidth, thickness + 2 * eps, height - bottomCutoutInsetY + eps ] );
        }

        // top

        translate( [ 45, depth - thickness - eps, height/2 ] )
        rotate( [ -90, 0, 0 ] ) {
            scale( [ 1.5, 1, 1 ] )
            cylinder( r = 20 + 2 * chamfer, h = thickness + 2 * eps);
        }

        brushCutoutRadius = 10;
        brushCutoutInset = 16;

        translate( [ width - 25, depth - thickness - eps, brushCutoutInset ] )
        rotate( [ -90, 0, 0 ] ) {
            cylinder( r = brushCutoutRadius, h = thickness + 2 * eps);
        }

        translate( [ width - 25, depth - thickness - eps, height - brushCutoutInset ] )
        rotate( [ -90, 0, 0 ] ) {
            cylinder( r = brushCutoutRadius, h = thickness + 2 * eps);
        }

    }

    // feet

    feetInsetX = 14;
    feetInsetY = 10;

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

