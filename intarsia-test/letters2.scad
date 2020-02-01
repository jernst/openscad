
$fn = 200;

difference() {
    cube( [ 20, 30, 5 ] );

    translate( [ 5, 7, -1 ] )
    linear_extrude( 7 ) {
        text( "J", 20, "DejaVu Sans:style=Bold" );
    }
}
