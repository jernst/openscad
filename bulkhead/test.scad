
campher = 3;

translate( [ campher, campher, campher ] )
minkowski() {
    cube( [ 10 - 2 * campher, 10 - 2 * campher, 10 - 2 * campher ] );
    sphere( r=campher );
}
