// A standoff with a screw hole

module Standoff(
        height,
        radius,
        holeDepth,
        holeRadius )
{
    difference() {
        cylinder( height, radius, radius );
        translate( [ 0, 0, height-holeDepth ] ) {
            cylinder( holeDepth, holeRadius, holeRadius );
        }
    }
}
