module Wedge ( dx, dy, dz ) {
    linear_extrude( dz ) {
        polygon( points = [ [0, 0], [dx, 0], [dx, dy], [0, 0] ] );
    };
};

module BiWedge ( dx, dy, dz ) {
    linear_extrude( dz ) {
        polygon( points = [ [0, 0], [dx, 0], [dx/2, dy], [0, 0] ] );
    };
};
