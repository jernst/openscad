

linear_extrude( 12 ) {
    union() {
        text( "A", 60, "DejaVu Sans:style=Bold" );

        translate( [36, 1, 0 ] ) {
            text( "C", 59, "DejaVu Sans:style=Bold" );
        }
    }
}
